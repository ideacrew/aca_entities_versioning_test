# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh VlpV37Contract
        class VlpV37Contract < ::Dry::Validation::Contract
          ALIEN_NUMBER_REQUIRED_SUBJECTS = ['I-327 (Reentry Permit)',
                                            'I-551 (Permanent Resident Card)',
                                            'I-571 (Refugee Travel Document)',
                                            'I-766 (Employment Authorization Card)',
                                            'Machine Readable Immigrant Visa (with Temporary I-551 Language)',
                                            'Temporary I-551 Stamp (on passport or I-94)',
                                            'Other (With Alien Number)'].freeze

          I94_NUMBER_REQUIRED_SUBJECTS = ['I-94 (Arrival/Departure Record)',
                                          'I-94 (Arrival/Departure Record) in Unexpired Foreign Passport',
                                          'Other (With I-94 Number)'].freeze

          PASSPORT_NUMBER_REQUIRED_SUBJECTS = ['Machine Readable Immigrant Visa (with Temporary I-551 Language)',
                                               'I-94 (Arrival/Departure Record) in Unexpired Foreign Passport',
                                               'Unexpired Foreign Passport'].freeze

          SEVIS_ID_REQUIRED_SUBJECTS = ['I-20 (Certificate of Eligibility for Nonimmigrant (F-1) Student Status)',
                                        'DS2019 (Certificate of Eligibility for Exchange Visitor (J-1) Status)'].freeze

          NATURALIZATION_CERTIFICATE_REQUIRED_SUBJECTS = ['Naturalization Certificate'].freeze

          CITIZENSHIP_CERTIFICATE_REQUIRED_SUBJECTS = ['Certificate of Citizenship'].freeze

          CARD_NUMBER_REQUIRED_SUBJECTS = ['I-551 (Permanent Resident Card)',
                                           'I-766 (Employment Authorization Card)'].freeze

          COUNTRY_OF_CITIZENSHIP_REQUIRED_SUBJECTS = [
            'I-94 (Arrival/Departure Record) in Unexpired Foreign Passport',
            'Machine Readable Immigrant Visa (with Temporary I-551 Language)',
            'Unexpired Foreign Passport'
          ].freeze

          EXPIRATION_DATE_REQUIRED_SUBJECTS = ['I-94 (Arrival/Departure Record) in Unexpired Foreign Passport',
                                               'Unexpired Foreign Passport'].freeze

          DESCRIPTION_REQUIRED_SUBJECTS = ['Other (With Alien Number)',
                                           'Other (With I-94 Number)'].freeze

          params do
            optional(:subject).filled(:string)
            optional(:alien_number).filled(:string).value(size?: 9)
            optional(:i94_number).filled(:string).value(size?: 11)
            optional(:visa_number).filled(:string).value(size?: 8..12)
            optional(:passport_number).filled(:string).value(size?: 6..12)
            optional(:sevis_id).filled(:string).value(size?: 10)
            optional(:naturalization_number).filled(:string).value(size?: 6..12)
            optional(:receipt_number).filled(:string).value(size?: 13)
            optional(:citizenship_number).filled(:string).value(size?: 6..12)
            optional(:card_number).filled(:string).value(size?: 13)
            optional(:country_of_citizenship).filled(:string)
            optional(:expiration_date).filled(:string)
            optional(:issuing_country).filled(:string)
            optional(:status).filled(:string)
            optional(:comment).filled(:string)
            optional(:description).filled(:string).value(size?: 0..35)
          end

          rule(:subject) do
            key.failure('Invalid VLP Document type') unless ::VlpDocument::VLP_DOCUMENT_KINDS.include?(value)
          end

          rule(:alien_number) do
            key.failure(message(values[:subject])) if  ALIEN_NUMBER_REQUIRED_SUBJECTS.include?(values[:subject]) && value.blank?
          end

          rule(:i94_number) do
            key.failure(message(values[:subject])) if  I94_NUMBER_REQUIRED_SUBJECTS.include?(values[:subject]) && value.blank?
          end

          rule(:passport_number) do
            key.failure(message(values[:subject])) if  PASSPORT_NUMBER_REQUIRED_SUBJECTS.include?(values[:subject]) && value.blank?
          end

          rule(:sevis_id) do
            key.failure(message(values[:subject])) if  SEVIS_ID_REQUIRED_SUBJECTS.include?(values[:subject]) && value.blank?
          end

          rule(:naturalization_number) do
            key.failure(message(values[:subject])) if  NATURALIZATION_CERTIFICATE_REQUIRED_SUBJECTS.include?(values[:subject]) && value.blank?
          end

          rule(:citizenship_number) do
            key.failure(message(values[:subject])) if  CITIZENSHIP_CERTIFICATE_REQUIRED_SUBJECTS.include?(values[:subject]) && value.blank?
          end

          rule(:card_number) do
            key.failure(message(values[:subject])) if  CARD_NUMBER_REQUIRED_SUBJECTS.include?(values[:subject]) && value.blank?
          end

          rule(:country_of_citizenship) do
            key.failure(message(values[:subject])) if  COUNTRY_OF_CITIZENSHIP_REQUIRED_SUBJECTS.include?(values[:subject]) && value.blank?
          end

          rule(:expiration_date) do
            key.failure(message(values[:subject])) if  EXPIRATION_DATE_REQUIRED_SUBJECTS.include?(values[:subject]) && value.blank?
          end

          rule(:description) do
            key.failure(message(values[:subject])) if  DESCRIPTION_REQUIRED_SUBJECTS.include?(values[:subject]) && value.blank?
          end

          private

          def message(subject_name)
            "is required for VLP Document type: #{subject_name}"
          end
        end
      end
    end
  end
end