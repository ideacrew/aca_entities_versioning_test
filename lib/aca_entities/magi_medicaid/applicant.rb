# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Cv3 IAP Entity for Applicant.
    class Applicant < Dry::Struct
      # All common entities across all the subs lives at aca_entities level just like address.
      attribute :name, AcaEntities::People::PersonName.meta(omittable: false)
      attribute :identifying_information, IdentifyingInformation.meta(omittable: false)
      attribute :demographic, Demographic.meta(omittable: false)
      attribute :attestation, Attestation.optional.meta(omittable: true)
      attribute :is_primary_applicant, Types::Bool.meta(omittable: false)
      attribute :native_american_information, NativeAmericanInformation.optional.meta(omittable: true)
      attribute :citizenship_immigration_status_information, CitizenshipImmigrationStatusInformation.meta(omittable: false)

      attribute :is_consumer_role, Types::Bool.optional.meta(omittable: true)
      attribute :is_resident_role, Types::Bool.optional.meta(omittable: true)
      attribute :is_applying_coverage, Types::Bool.optional.meta(omittable: true)
      attribute :is_consent_applicant, Types::Bool.optional.meta(omittable: true)
      attribute :vlp_document, AcaEntities::Documents::VlpDocument.optional.meta(omittable: true)
      attribute :family_member_reference, AcaEntities::Families::FamilyMemberReference.meta(omittable: false)

      attribute :person_hbx_id, Types::String.meta(omittable: false)

      attribute :is_required_to_file_taxes, Types::Bool.optional.meta(omittable: true)
      attribute :tax_filer_kind, Types::TaxFilerKind.optional.meta(omittable: true)
      attribute :is_joint_tax_filing, Types::Bool.optional.meta(omittable: true)
      attribute :is_claimed_as_tax_dependent, Types::Bool.optional.meta(omittable: true)
      attribute :claimed_as_tax_dependent_by, ApplicantReference.optional.meta(omittable: true)

      attribute :student, Student.optional.meta(omittable: true)
      attribute :is_refugee, Types::Bool.optional.meta(omittable: true)
      attribute :is_trafficking_victim, Types::Bool.optional.meta(omittable: true)
      attribute :foster_care, FosterCare.optional.meta(omittable: true)
      attribute :pregnancy_information, PregnancyInformation.optional.meta(omittable: true)

      # TODO: do we want to move these anywhere?
      attribute :is_subject_to_five_year_bar, Types::Bool.optional.meta(omittable: true)
      attribute :is_five_year_bar_met, Types::Bool.optional.meta(omittable: true)
      attribute :is_forty_quarters, Types::Bool.optional.meta(omittable: true)
      attribute :is_ssn_applied, Types::Bool.optional.meta(omittable: true)
      attribute :non_ssn_apply_reason, Types::String.optional.meta(omittable: true)
      # 5 Yr. Bar QNs.
      attribute :moved_on_or_after_welfare_reformed_law, Types::Bool.optional.meta(omittable: true)
      attribute :is_currently_enrolled_in_health_plan, Types::Bool.optional.meta(omittable: true)

      # Other QNs.
      attribute :has_daily_living_help, Types::Bool.optional.meta(omittable: true)
      attribute :need_help_paying_bills, Types::Bool.optional.meta(omittable: true)

      # Driver QNs.
      attribute :has_job_income, Types::Bool.optional.meta(omittable: true)
      attribute :has_self_employment_income, Types::Bool.optional.meta(omittable: true)
      attribute :has_unemployment_income, Types::Bool.optional.meta(omittable: true)
      attribute :has_other_income, Types::Bool.optional.meta(omittable: true)
      attribute :has_deductions, Types::Bool.optional.meta(omittable: true)
      attribute :has_enrolled_health_coverage, Types::Bool.optional.meta(omittable: true)
      attribute :has_eligible_health_coverage, Types::Bool.optional.meta(omittable: true)

      attribute :addresses, Types::Array.of(AcaEntities::Locations::Address).optional.meta(omittable: true)
      attribute :emails, Types::Array.of(AcaEntities::Contacts::EmailContact).optional.meta(omittable: true)
      attribute :phones, Types::Array.of(AcaEntities::Contacts::PhoneContact).optional.meta(omittable: true)

      attribute :incomes,         Types::Array.of(Income).optional.meta(omittable: true)
      attribute :benefits,        Types::Array.of(Benefit).optional.meta(omittable: true)
      attribute :deductions,      Types::Array.of(Deduction).optional.meta(omittable: true)

      # @!attribute [r] is_medicare_eligible
      # A boolean that tells if applicant has any medicare benefits('medicare', 'medicare_advantage', or 'medicare_part_b').
      # @return [Bool]
      attribute :is_medicare_eligible, Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] has_insurance
      # Applicant already has insurance coverage. Any benefits of type is_enrolled
      # @return [Bool]
      attribute :has_insurance, Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] has_state_health_benefit
      # A boolean if applicant has health benefits by virtue working for a public entity or through a relative
      # Any benefits of type medicaid
      # @return [Bool]
      attribute :has_state_health_benefit, Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] had_prior_insurance
      # Was the applicant receiving coverage that has expired?
      # Any benefits of type is_enrolled and end dated.
      # @return [Bool]
      attribute :had_prior_insurance, Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] prior_insurance_end_date
      # The date the prior coverage ended.A date in YYYY-MM-DD format
      # @return [Bool]
      attribute :prior_insurance_end_date, Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] age_of_applicant
      # The age of the applicant
      # @return [Integer]
      attribute :age_of_applicant, Types::Integer.meta(omittable: false)

      # @!attribute [r] is_self_attested_long_term_care
      # @return [Bool]
      attribute :is_self_attested_long_term_care, Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] hours_worked_per_week
      # @return [Integer]
      attribute :hours_worked_per_week, Types::Integer.optional.meta(omittable: true)

      # @!attribute [r] is_temporarily_out_of_state
      # Applicant is currently living outside State of Application
      # @return [Bool]
      attribute :is_temporarily_out_of_state, Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] is_claimed_as_dependent_by_non_applicant
      # Applicant is claimed as dependent by a person who is not applying for coverage(is_applying_coverage).
      # @return [Bool]
      attribute :is_claimed_as_dependent_by_non_applicant, Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] slcsp_premium
      # Member Premium of the Second Lowest Cost Silver Plan of the applicant based on the age_of_applicant
      # @return [Money]
      attribute :slcsp_premium, Types::Money.meta(omittable: false)

      # Set of attributes specific to MitC which helps to not have much logic in IapTo MitC Transform.
      attribute :mitc_income, AcaEntities::MagiMedicaid::Mitc::Income.optional.meta(omittable: true)
      attribute :mitc_relationships, Types::Array.of(AcaEntities::MagiMedicaid::Mitc::Relationship).optional.meta(omittable: true)

      def monthly_qsehra_amount
        0
        # qsehra_benefits = benefits.select { |benefit| benefit.kind == 'qsehra' }
        # qsehra_benefits.map(&:monthly_amount)
      end

      def minimum_essential_coverages
        return [] if benefits.blank?

        benefits.select do |benefit|
          Types::MinimumEssentialCoverageBenefitKinds.include?(benefit.kind)
        end
      end
    end
  end
end
