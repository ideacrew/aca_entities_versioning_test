# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

# lib/aca_entities/medicaid/contracts
require 'aca_entities/medicaid/atp'
require 'aca_entities/medicaid/contracts/account_transfer_request_contract'
require 'aca_entities/serializers/xml/medicaid/atp'
require 'aca_entities/atp/transformers/aces/family'
require 'aca_entities/serializers/xml/medicaid/atp/account_transfer_request'

module AcaEntities
  module Atp
    module Operations
      module Aces
        # Family Operations for atp payloads
        class GenerateXml
          include Dry::Monads[:result, :do, :try]

          def call(payload)
            valid_payload = yield validate(payload)
            aces_payload = yield to_aces(valid_payload)
            valid_aces_payload = yield validate_aces(aces_payload)
            entity = yield initialize_entity(valid_aces_payload)
            serialized_payload = yield to_serialized_obj(entity)
            # _result = yield validate_xml(serialized_payload)
            xml_payload = serialized_payload.to_xml
            Success(xml_payload)
          end

          private

          def validate(params)
            payload = JSON.parse(params)
            Success(payload)
          end

          def validate_aces(params)
            result = Try do
              AcaEntities::Medicaid::Contracts::AccountTransferRequestContract.new.call(params[:aces])
            end.to_result

            if result.success?
              result
            else
              Failure("AccountTransferRequestContract -> #{result.failure.errors.to_h}")
            end
          end

          def initialize_entity(payload)
            result = Try do
              AcaEntities::Medicaid::Atp::AccountTransferRequest.new(payload.to_h)
            end.to_result

            if result.success?
              result
            else
              Failure("entity-AccountTransferRequest -> #{result.failure}")
            end
          end

          def to_serialized_obj(entity)
            seralized_xml = Try do
              AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest.domain_to_mapper(entity)
            end.to_result

            if seralized_xml.success?
              seralized_xml
            else
              Failure("Serializers-AccountTransferRequest -> #{seralized_xml.failure}")
            end
          end

          def validate_xml(seralized_xml)
            document = Nokogiri::XML(seralized_xml.to_xml)
            xsd_path = File.open(Pathname.pwd.join("lib/aca_entities/atp/schema/aces/atp_service.xsd"))
            schema_location = File.expand_path(xsd_path)
            schema = Nokogiri::XML::Schema(File.open(schema_location))
            result = schema.validate(document).each_with_object([]) do |error, collect|
              collect << error.message
            end

            if result.empty?
              Success(true)
            else
              Failure("validate_xml -> #{result}")
            end
          end

          # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
          def prep_record(record)
            family_members = record["family"]["family_members"]
            applicants = record["family"]["magi_medicaid_applications"]["applicants"]
            applicant_ids = applicants.map { |h| h["person_hbx_id"] }
            broker_account = record["family"]["broker_accounts"]&.first

            record["family"].merge!("family_members" => family_members.select { |h| applicant_ids.include? h["person"]["hbx_id"] }.group_by do |h|
                                                          h["person"]["hbx_id"]
                                                        end.transform_keys(&:to_s).transform_values(&:first))
            record["family"]["magi_medicaid_applications"].merge!("applicants" => applicants.group_by do |h|
              h["person_hbx_id"]
            end.transform_keys(&:to_s).transform_values(&:first))
            magi_medicaid_application = record["family"]["magi_medicaid_applications"]
            record["family"].merge!("magi_medicaid_applications" => magi_medicaid_application)
            family_members = record["family"].delete("family_members")

            if record["family"]["magi_medicaid_applications"].present?
              tax_households = record["family"]["magi_medicaid_applications"]["tax_households"]
              tax_households.each do |th|
                next unless th["annual_tax_household_income"].instance_of?(String)
                th["annual_tax_household_income"] = { "cents" => th["annual_tax_household_income"].to_f, "currency_iso" => "USD" }
              end
              record["family"]["magi_medicaid_applications"].merge!("tax_households" => tax_households.group_by do |th|
                th["hbx_id"]
              end.transform_keys(&:to_s).transform_values(&:first))
            end

            family_members.each do |family_member|
              person_relationships = family_member[1]["person"].delete("person_relationships")
              family_member[1]["person"].merge!("person_relationship" => person_relationships.first)

              person = family_member[1].delete("person")
              family_member[1].merge!("person" => person)
            end
            record["family"].merge!("family_members" => family_members)
            record["family"].merge!("broker_accounts" => broker_account)

            record
          end

          def remove_flagged_params(record)
            param_flags = record['drop_param_flags']
            return record unless param_flags.present?

            record['family']['magi_medicaid_applications']['applicants'].each do |applicant|
              applicant['non_ssn_apply_reason'] = nil if param_flags.include?('drop_non_ssn_apply_reason')
              applicant['is_ssn_applied'] = nil if param_flags.include?('drop_non_ssn_apply_reason')
              applicant['vlp_document'] = nil if param_flags.include?('drop_vlp_document')
              applicant['incomes'].each do |income|
                income['start_on'] = nil if param_flags.include?('drop_income_start_on')
                income['end_on'] = nil if param_flags.include?('drop_income_end_on')
              end
            end
            record
          end
          # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity

          def to_aces(record)
            cleaned_record = remove_flagged_params(record)
            record_hash = prep_record(cleaned_record)
            result = ::AcaEntities::Atp::Transformers::Aces::Family.transform(record_hash)
            Success(result)
          rescue StandardError => e
            Failure("to_aces transformer #{e.backtrace}")
          end
        end
      end
    end
  end
end