# frozen_string_literal: true

module AcaEntities
  module Iap
    module Mitc
      class Person < Dry::Struct

        # @!attribute [r] person_id
        # An integer representing the applicant, only for the use of the submitter
        # @return [Integer]
        attribute :person_id,        Types::Integer.meta(omittible: false)

        # @!attribute [r] is_applicant
        # A boolean if the person applying for insurance.
        # @return [String]
        attribute :is_applicant,     Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] is_blind_or_disabled
        # A boolean if the person is blind or disabled. Does the Person qualify for ABD?
        # @return [String]
        attribute :is_blind_or_disabled,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] is_full_time_student
        # A boolean if the person is a full time student.
        # @return [String]
        attribute :is_full_time_student,  Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] is_medicare_entitled
        # A boolean if the person is entitled to receive Medicare.
        # @return [String]
        attribute :is_medicare_entitled,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] is_incarcerated
        # A boolean if the person is incarcerated.
        # @return [String]
        attribute :is_incarcerated,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] is_claimed_as_dependent_by_non_applicant
        # A boolean if the person is claimed as dependent person not in this data structure.
        # is the person  claimed by a person not in this data structure (like an absent parent)
        # @return [String]
        attribute :is_claimed_as_dependent_by_non_applicant,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] is_self_attested_long_term_care
        # A boolean if the applicant claims to be in long-term care.
        # @return [String]
        attribute :is_self_attested_long_term_care,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] has_insurance
        # A boolean if applicant already has insurance coverage.
        # @return [String]
        attribute :has_insurance,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] has_state_health_benefit
        # A boolean if applicant has health benefits by virtue working for a public entity or through a relative.
        # @return [String]
        attribute :has_state_health_benefit,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] had_prior_insurance
        # A boolean if applicant receiving coverage that has expired.
        # @return [String]
        attribute :had_prior_insurance,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] prior_insurance_end_date
        # The date the prior coverage ended.A date in YYYY-MM-DD format.
        # @return [Date]
        attribute :prior_insurance_end_date,    Types::Date.meta(omittable: false)

        # @!attribute [r] is_pregnant
        # A boolean if applicant is pregnant.
        # @return [String]
        attribute :is_pregnant,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] children_expected_count
        # For a pregnant woman, the number of children expected.
        # @return [Integer]
        attribute :children_expected_count,    Types::Integer.meta(omittable: false)

        # @!attribute [r] is_in_post_partum_period
        # Applicant is currently within the post-partum period.
        # The post-partum periodis defined as the time period starting from when the applicant gave birth,
        # continuing for at least 60 days,
        # and ending on the last day of the month in which the 60-day period ended.
        # @return [String]
        attribute :is_in_post_partum_period,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] is_in_former_foster_care
        # A boolean if applicant was in foster care previously.
        # @return [String]
        attribute :is_in_former_foster_care,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] had_medicaid_during_foster_care
        # A boolean if applicant received Medicaid coverage while in Foster care.
        # @return [String]
        attribute :had_medicaid_during_foster_care,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] age_left_foster_care
        # The age of the applicant at the time they left foster care.
        # @return [Integer]
        attribute :age_left_foster_care,    Types::Integer.meta(omittable: false)

        # @!attribute [r] foster_care_us_state
        # The state where the applicant received foster care.
        # Two character state code. For example, “CA”
        # @return [String]
        attribute :foster_care_us_state,    ::AcaEntities::Types::UsStateAbbreviationKind.meta(omittible: false)

        # @!attribute [r] is_required_to_file_taxes
        # A boolean if the applicant meets the bar to be required to file taxes.
        # @return [String]
        attribute :is_required_to_file_taxes,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] age_of_applicant
        # The age of the applicant.
        # @return [Integer]
        attribute :age_of_applicant,    Types::Integer.meta(omittable: false)

        # @!attribute [r] hours_worked_per_week
        # The hours the applicant works in an average week.
        # @return [Integer]
        attribute :hours_worked_per_week,    Types::Integer.meta(omittable: false)

        # @!attribute [r] is_temporarily_out_of_state
        # A boolean if the applicant is temporarily out of the state of application.
        # @return [String]
        attribute :is_temporarily_out_of_state,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] is_us_citizen
        # A boolean if the applicant is a US citizen.
        # @return [String]
        attribute :is_us_citizen,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] is_lawful_presence_self_attested
        # Does the non-citizen applicant claim to be in the state legally.
        # @return [String]
        attribute :is_lawful_presence_self_attested,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] immigration_status
        # Code indicating the person’s immigration status.
        # @return [String]
        attribute :immigration_status,    Types::ImmigrationStatusKind.meta(omittible: false)

        # @!attribute [r] is_amerasian
        # Does the non-citizen have Amerasian status?
        # @return [String]
        attribute :is_amerasian,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] has_forty_title_ii_work_quarters
        # For non-citizens, have they earned 40 Title II work quarters.
        # In general, this is answered by whether the applicant has had 40 quarters in which the applicant was employed in the US.
        # @return [String]
        attribute :has_forty_title_ii_work_quarters,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] five_year_bar_applies
        # Is the non-citizen subject to the 5 year bar?
        # @return [String]
        attribute :five_year_bar_applies,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] is_five_year_bar_met
        # Has the non-citizen applicant met the 5 year bar?
        # @return [String]
        attribute :is_five_year_bar_met,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] is_trafficking_victim
        # Is a victim of trafficking?
        # @return [String]
        attribute :is_trafficking_victim,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] is_eligible_for_refugee_medical_assistance
        # Is the applicant eligible for refugee medical assistance?
        # @return [String]
        attribute :is_eligible_for_refugee_medical_assistance,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] refugee_medical_assistance_start_date
        # Is the applicant eligible for refugee medical assistance?
        # @return [Date]
        attribute :refugee_medical_assistance_start_date,    Types::Date.meta(omittable: false)

        # @!attribute [r] seven_year_limit_start_date
        # This date varies based on the person’s immigration status:
        # LPR: Entry date
        # Asylee: Asylum grant date
        # Refugee: Refugee admit date
        # Cuban/Haitian entrant: Status grant date
        # Granted withholding of deportation: Deportation withheld date
        # All other statuses: This field is not required
        # @return [Date]
        attribute :seven_year_limit_start_date,    Types::Date.meta(omittable: false)

        # @!attribute [r] is_veteran
        # Whether the applicant is a veteran.
        # @return [String]
        attribute :is_veteran,    Types::YesNoKind.meta(ommittable: false)

        # @!attribute [r] income
        # a hash representing the income of the person.
        # @return Income
        attribute :income, Income.meta(omittible: false)

        # @!attribute [r] relationships
        # A list representing the relationships between this person and other people on the application.
        # @return [Array<Relationship>]
        attribute :relationships,         Types::Array.of(Relationship).meta(omittible: false)
      end
    end
  end
end
