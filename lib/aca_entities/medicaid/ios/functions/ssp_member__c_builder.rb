# frozen_string_literal: true

require 'aca_entities/medicaid/ios/types'

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build SSP_Member__c for IOS transform
        class SspMemberCBuilder
          include ::AcaEntities::Operations::Transforms::HashFunctions

          def resolve_la_type(applicant)
            if applicant&.dig(:is_homeless)
              "H"
            elsif applicant&.dig(:person, :demographics, :is_incarcerated)
              "CO"
            else
              "CH"
            end
          end

          def resolve_hispanic(options)
            # applicant&.dig(:demographics, :ethnicity) ? not applicant&.dig(:demographics, :ethnicity).empty? : false
            return "false" if options.nil? || options.empty?
            (options & AcaEntities::Medicaid::Ios::Types::HISPANIC_MAP).empty?
          end

          def resolve_race(options)
            return "false" if options.nil? || options.empty?
          end

          # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
          def call(cache)
            # TODO: loop through applicants/people (?? depends on mappings)
            # build hash of field mappings
            # return array of SSP_Member__c hashes
            @memoized_data = cache

            family_members = @memoized_data.resolve('family.family_members_hash').item
            application = @memoized_data.resolve('family.magi_medicaid_applications').item
            applicants = application[:applicants]
            applicants.map do |applicant|
              # next unless applicant[:is_applying_coverage] # TODO: uncomment (unless we are sending non-applicants?)
              family_member = family_members.values.detect { |fm| fm[:hbx_id] == applicant[:person_hbx_id] }
              vlp_document = applicant[:vlp_document]
              home_address = applicant[:addresses].detect { |address| address[:kind] == 'home' }
              mailing_address = applicant[:addresses].detect { |address| address[:kind] == 'mailing' }
              primary_phone = applicant[:phones].detect { |num| num[:primary] == true }
              secondary_phone = applicant[:phones].detect { |num| num[:primary] == false }

              {
                # required
                'FirstName__c' => applicant&.dig(:name, :first_name),
                'HasDifferentMailingAddress__c' => boolean_string(home_address.equal?(mailing_address)),
                'IsFederalRecognizedIndianTribeToggle__c' => boolean_string(applicant&.dig(:native_american_information, :indian_tribe_member)),
                'IsFixedAddressToggle__c' => boolean_string(!applicant&.dig(:is_homeless)),
                'IsPregnant__c' => boolean_string(applicant&.dig(:pregnancy_information, :is_pregnant)),
                'LastName__c' => applicant&.dig(:name, :last_name),
                'LATypeCode__c' => resolve_la_type(applicant),
                'MemberProgramsApplied__c' => 'MA', # default value
                'PreferredNotificationMethodCode__c' => 'Email', # waiting on client to map
                'TaxFilerMemberCurrent__r' => { 'IndividualId__c' => applicant&.dig(:claimed_as_tax_dependent_by, :person_hbx_id) },
                'TaxFilerStatusCurrentYear__c' => AcaEntities::Medicaid::Ios::Types::TAX_KINDS_MAP[applicant&.dig(:tax_filer_kind)],
                # optional
                'AlienNumber__c' => vlp_document&.dig(:alien_number),
                'BirthDate__c' => applicant&.dig(:demographic, :dob),
                'CitizenshipNumber__c' => vlp_document&.dig(:citizenship_number),
                'CountryOfIssuanceCode__c' => vlp_document&.dig(:issuing_country),
                'DeathDate__c' => family_member&.dig(:person, :demographics, :date_of_death),
                'DocumentExpiryDate__c' => vlp_document&.dig(:expiration_date),
                'FosterStateCode__c' => applicant&.dig(:foster_care, :foster_care_us_state),
                'GenderCode__c' => AcaEntities::Medicaid::Ios::Types::GENDER_MAP[applicant&.dig(:demographic, :gender)&.downcase],
                'HasDifferentMailingAddressToggle__c' => boolean_string(home_address.equal?(mailing_address)),
                'I94Number__c' => vlp_document&.dig(:i94_number),
                'Id' => applicant&.dig(:person_hbx_id),
                'ImmigrationDateOfBirth__c' => applicant&.dig(:demographic, :dob),
                'ImmigrationDocumentTypeCode__c' =>
                  AcaEntities::Medicaid::Ios::Types::IMMIGRATION_DOCUMENT_TYPE_CODE_MAP[vlp_document&.dig(:subject)],
                'ImmigrationFirstName__c' => applicant&.dig(:name, :first_name),
                'ImmigrationLastName__c' => applicant&.dig(:name, :last_name),
                'ImmigrationMiddleName__c' => applicant&.dig(:name, :middle_name),
                'ImmigrationSuffix__c' => applicant&.dig(:name, :name_sfx)&.upcase,
                'IndianTribeCode__c' => applicant&.dig(:native_american_information, :tribe_codes)&.join(";"),
                'IndianTribeState__c' => applicant&.dig(:native_american_information, :tribal_state),
                'InmateStatusIndicator__c' => boolean_string(applicant&.dig(:person, :demographics, :is_incarcerated)),
                'IsCoverageMonth3__c' => boolean_string(applicant&.dig(:need_help_paying_bills)),
                'IsDeleted__c' => boolean_string(applicant&.dig(:incomes)&.detect { |x| x[:kind] == 'wages_and_salaries' }&.dig(:end_on)&.nil?),
                'IsDisabledToggle__c' => boolean_string(applicant&.dig(:is_disabled)),
                'IsEligibleForIHFlagToggle__c' => boolean_string(applicant&.dig(:other_health_service, :has_received)),
                'IsEligibleForIndianHealthServicesToggle__c' => boolean_string(applicant&.dig(:other_health_service, :is_eligible)),
                'IsFosterCareToggle' => boolean_string(applicant&.dig(:foster_care, :is_former_foster_care)),
                'IsHispanicLatinoSpanishToggle__c' => boolean_string(resolve_hispanic(applicant&.dig(:demographic, :ethnicity))),
                'IsIntendToResideToggle__c' => boolean_string(applicant&.dig(:mitc_state_resident)),
                'IsMilitaryMemberToggle__c' => boolean_string(applicant&.dig(:demographic, :is_veteran_or_active_military)),
                'IsPregnantInLastThreeMonthsToggle__c' => boolean_string(applicant&.dig(:pregnancy_information, :is_post_partum_period)),
                'IsReceivingMedicareBenefitToggle__c' => boolean_string(!applicant&.dig(:benefits)&.detect { |x| x[:kind] == 'medicare' }.nil?),
                'IsStateMedicaidprogramCode__c' => boolean_string(applicant&.dig(:foster_care, :had_medicaid_during_foster_care)),
                'IsUSCitizenToggle__c' =>
                  boolean_string(applicant&.dig(:citizenship_immigration_status_information, :citizen_status) == "us_citizen"),
                'MailingAddressLine1__c' => mailing_address&.dig(:address_1),
                'MailingAddressLine2__c' => mailing_address&.dig(:address_2),
                'MailingCity__c' => mailing_address&.dig(:city),
                'MailingCountryCode__c' => mailing_address&.dig(:country_name),
                'MailingCountyCode__c' => mailing_address&.dig(:county),
                'MailingStateCode__c' => mailing_address&.dig(:state),
                'MailingZipCode4__c' => mailing_address&.dig(:zip)&.split('-')&.at(1),
                'MailingZipCode5__c' => mailing_address&.dig(:zip)&.split('-')&.at(0),
                'MiddleInitial__c' => applicant&.dig(:name, :middle_name)&.chars&.first,
                'NaturalizationNumber__c' => vlp_document&.dig(:naturalization_number),
                'NumberOfBirthsExpected__c' => applicant&.dig(:pregnancy_information, :expected_children_count),
                'PassportNumber__c' => vlp_document&.dig(:passport_number),
                'PhysicalAddressLine1__c' => home_address&.dig(:address_1),
                'PhysicalAddressLine2__c' => home_address&.dig(:address_2),
                'PhysicalCity__c' => home_address&.dig(:city),
                'PhysicalCountryCode__c' => home_address&.dig(:country_name),
                'PhysicalCountyCode__c' => home_address&.dig(:county),
                'PhysicalStateCode__c' => home_address&.dig(:state),
                'PhysicalZipCode4__c' => home_address&.dig(:zip)&.split('-')&.at(1),
                'PhysicalZipCode5__c' => home_address&.dig(:zip)&.split('-')&.at(0),
                'PregnancyDueDate__c' => applicant&.dig(:pregnancy_information, :pregnancy_due_on),
                'PregnancyExpectedDueDate__c' => applicant&.dig(:pregnancy_information, :pregnancy_due_on),
                'PrimaryPhoneExtension__c' => primary_phone&.dig(:extension),
                'PrimaryPhoneNumber__c' => convert_to_phone(primary_phone&.dig(:full_phone_number)),
                'PrimaryPhoneTypeCode__c' => primary_phone&.dig(:kind),
                'RaceCode__c' => AcaEntities::Medicaid::Ios::Types::RACE_MAP[applicant&.dig(:demographic, :race)],
                'ReceiptNumber__c' => vlp_document&.dig(:card_number),
                'SecondaryPhoneExtension__c' => secondary_phone&.dig(:extension),
                'SecondaryPhoneNumber__c' => convert_to_phone(secondary_phone&.dig(:full_phone_number)),
                'SecondaryPhoneTypeCode__c' => secondary_phone&.dig(:kind),
                'SevisId__c' => vlp_document&.dig(:sevis_id),
                'SuffixCode__c' => applicant&.dig(:name, :name_sfx)&.upcase,
                'TribeName__c' => applicant&.dig(:native_american_information, :tribal_name)
              }

              # Use this if TaxFilerMemberCurrent__r is not actually required
              # if claimed_as_tax_dependent_by
              #   claimant_hash = {
              #     'TaxFilerMemberCurrent__r' => { 'Id' => applicant&.dig(:claimed_as_tax_dependent_by, :person_hbx_id) }
              #   }
              #   member_hash.merge!(claimant_hash)
              # end
            end
          end
          # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        end
      end
    end
  end
end