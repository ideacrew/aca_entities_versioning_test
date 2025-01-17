# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Contracts::Families::FamilyContract,  dbclean: :after_each do

  let(:family_member_reference) do
    {
      family_member_hbx_id: '1001',
      first_name: 'first name',
      last_name: 'last name',
      person_hbx_id: '1001',
      is_primary_family_member: true
    }
  end
  let(:family_reference) do
    {
      hbx_id: '1000'
    }

  end
  let(:issuer_profile_reference) do
    {
      hbx_id: '1234',
      fein: '123333333',
      hbx_carrier_id: '333333',
      name: 'Delta Dental',
      abbrev: 'DDPA'
    }
  end
  let(:qualifying_life_event_kind_reference) do
    {
      start_on: Date.today,
      title: 'test title',
      reason: 'test reason',
      market_kind: 'individual'
    }
  end
  let(:special_enrollment_period_reference) do
    {
      qualifying_life_event_kind_reference: qualifying_life_event_kind_reference,
      qle_on: Date.today,
      start_on: Date.today,
      end_on: Date.today, submitted_at: Date.today, effective_on: Date.today
    }
  end
  let(:consumer_role_reference) do
    {
      is_active: true,
      is_applying_coverage: true,
      is_applicant: true, is_state_resident: true,
      lawful_presence_determination: lawful_presence_determination,
      citizen_status: "us_citizen"
    }
  end

  let(:resident_role_reference) do
    {
      is_applicant: true,
      is_active: true,
      is_state_resident: true,
      residency_determined_at: Date.today
    }
  end

  let(:product_reference) do
    {
      hios_id: '92479DC0020002',
      name: 'Access PPO',
      active_year: 2020,
      is_dental_only: false,
      metal_level: 'gold',
      product_kind: 'health',
      benefit_market_kind: 'aca_shop',
      ehb_percent: '0.0',
      issuer_profile_reference: issuer_profile_reference
    }
  end

  let(:coverage_household_reference) do
    {
      start_date: Date.today,
      is_immediate_family: false,
      is_determination_split_household: false
    }
  end

  let(:household_reference) do
    {}
  end

  let(:benefit_package_reference) do
    {
      title: 'test title',
      elected_premium_credit_strategy: 'unassisted'
    }
  end

  let(:benefit_coverage_period_reference) do
    {
      title: 'test title',
      market_place: 'individual',
      start_on: Date.today,
      end_on: Date.today,
      open_enrollment_start_on: Date.today,
      open_enrollment_end_on: Date.today
    }
  end

  let(:hbx_enrollment_reference) do
    {
      hbx_id: "122333",
      effective_on: Date.today,
      aasm_state: 'coverage_selected',
      market_place_kind: 'individual',
      enrollment_period_kind: 'open_enrollment',
      product_kind: 'health'
    }
  end

  let!(:hbx_enrollments) do
    [
      {
        market_place_kind: 'individual',
        enrollment_period_kind: 'open_enrollment',
        product_kind: 'health',
        hbx_id: '1000',
        aasm_state: 'coverage_selected',
        enrollment_kind: 'open_enrollment',
        coverage_kind: 'health',
        effective_on: Date.today,
        is_any_enrollment_member_outstanding: false,
        elected_amount: currency,
        elected_premium_credit: currency,
        applied_premium_credit: currency,
        elected_aptc_pct: 0.0, applied_aptc_amount: currency,
        aggregate_aptc_amount: currency,
        terminated_on: nil,
        terminate_reason: nil,
        enrollment_signature: nil,
        is_active: false,
        waiver_reason: nil,
        review_status: "incomplete",
        special_verification_period: Date.today,
        termination_submitted_on: nil,
        external_enrollment: false,
        coverage_household_reference: coverage_household_reference,
        household_reference: household_reference,
        family_reference: family_reference,
        special_enrollment_period_reference: special_enrollment_period_reference,
        product_reference: product_reference,
        issuer_profile_reference: issuer_profile_reference,
        consumer_role_reference: consumer_role_reference,
        resident_role_reference: resident_role_reference,
        broker_agency_reference: broker_agency_reference,
        broker_role_reference: broker_role_reference,
        predecessor_enrollment: hbx_enrollment_reference,
        benefit_package_reference: benefit_package_reference,
        benefit_coverage_period_reference: benefit_coverage_period_reference,
        updated_by: person_reference,
        # benefit_sponsorship_reference: benefit_sponsorship_reference,
        # sponsored_benefit_package_reference: sponsored_benefit_package_reference,
        # sponsored_benefit_reference: sponsored_benefit_reference,
        # rating_area_reference: rating_area_reference,
        # employee_role_reference: employee_role_reference,
        # benefit_group_assignment_reference: benefit_group_assignment_reference,
        hbx_enrollment_members:
          [
            {
              family_member_reference: family_member_reference,
              carrier_member_id: nil,
              premium_amount: currency,
              applied_aptc_amount: currency,
              coverage_end_on: nil,
              is_subscriber: true,
              eligibility_date: Date.today,
              coverage_start_on: Date.today
            }
          ]
      }
    ]
  end

  let!(:irs_group_reference) do
    {
      hbx_id: '44444'
    }
  end

  let!(:currency) do
    {
      cents: BigDecimal(0),
      currency_iso: "USD"
    }
  end

  let!(:eligibility_determinations) do
    [
      {
        e_pdc_id: "3135650",
        benchmark_plan_id: product_reference,
        max_aptc: currency,
        premium_credit_strategy_kind: "unassisted",
        csr_percent_as_integer: 0,
        csr_eligibility_kind: "csr_0",
        aptc_csr_annual_household_income: currency,
        aptc_annual_income_limit: currency,
        csr_annual_income_limit: currency,
        determined_at: Date.today,
        source: "Curam"
      }
    ]
  end

  let(:broker_role_reference) do
    {
      npn: '3333333333',
      person_reference: person_reference,
      broker_agency_reference: broker_agency_reference
    }
  end

  let(:coverage_households) do
    [
      {
        start_date: Date.today,
        is_immediate_family: true,
        is_determination_split_household: false,
        aasm_state: "applicant",
        broker_agency_reference: broker_agency_reference,
        broker_role_reference: broker_role_reference,
        coverage_household_members: coverage_household_members
      }
    ]
  end

  let(:coverage_household_members) do
    [
      {
        family_member_reference: family_member_reference,
        is_subscriber: true
      }
    ]
  end

  let(:tax_household_member_eligibity_determination) do
    {
      is_ia_eligible: true,
      is_medicaid_chip_eligible: false,
      is_totally_ineligible: false,
      is_uqhp_eligible: false,
      is_non_magi_medicaid_eligible: false,
      magi_as_percentage_of_fpl: 0.0,
      magi_medicaid_type: nil,
      magi_medicaid_category: nil,
      magi_medicaid_monthly_household_income: currency,
      magi_medicaid_monthly_income_limit: currency,
      medicaid_household_size: nil,
      is_without_assistance: false
    }
  end

  let(:tax_household_members) do
    [
      { family_member_reference: family_member_reference,
        reason: "",
        is_subscriber: true,
        product_eligibility_determination: tax_household_member_eligibity_determination }
    ]
  end

  let(:tax_households) do
    [
      {
        hbx_id: "828762",
        allocated_aptc: currency,
        is_eligibility_determined: true,
        start_date: Date.today,
        end_date: Date.today,
        tax_household_members: tax_household_members,
        eligibility_determinations: eligibility_determinations
      }
    ]
  end

  let!(:household_params) do
    [
      {
        start_date: Date.today,
        end_date: Date.today,
        is_active: true,
        submitted_at: Date.today,
        irs_group_reference: irs_group_reference,
        coverage_households: coverage_households,
        tax_households: tax_households,
        hbx_enrollments: hbx_enrollments
      }
    ]
  end

  let!(:person_name) do
    {
      first_name: 'first name',
      last_name: 'last name',
      middle_name: 'middle name'
    }
  end

  let!(:person_health) do
    {
      is_tobacco_user: 'unknown',
      is_physically_disabled: false
    }
  end

  let!(:demographics) do
    {
      ssn: "123456789",
      no_ssn: false,
      gender: 'male',
      dob: Date.today,
      is_incarcerated: false
    }
  end

  let!(:person_reference) do
    {
      hbx_id: '1234',
      first_name: 'first name',
      last_name: 'last name',
      middle_name: 'middle name',
      dob: Date.today,
      gender: 'male',
      ssn: nil
    }
  end

  let!(:person_relationships) do
    [
      {
        kind: 'child',
        relative: person_reference
      }
    ]
  end

  let(:documents) { [] }

  let(:event_response) do
    [
      {
        received_at: DateTime.now,
        body: "response"
      }
    ]
  end

  let(:event_request) do
    [
      {
        requested_at: DateTime.now,
        body: "request"
      }
    ]
  end

  let!(:lawful_presence_determination) do
    {
      vlp_verified_at: DateTime.now,
      vlp_authority: "curam",
      vlp_document_id: nil,
      citizen_status: "some status",
      citizenship_result: nil,
      qualified_non_citizenship_result: nil,
      aasm_state: "verification_successful",
      ssa_responses: event_response,
      ssa_requests: event_request,
      vlp_responses: event_response,
      vlp_requests: event_request
    }
  end

  let(:vlp_documents) do
    [
      {
        title: "untitled",
        creator: "dchl",
        subject: "Naturalization Certificate",
        description: nil,
        publisher: "dchl",
        contributor: nil,
        date: Date.today,
        type: "text",
        format: "application/octet-stream",
        identifier: nil,
        source: "enroll_system",
        language: "en",
        relation: nil,
        coverage: nil,
        rights: 'public',
        tags: [], size: nil,
        doc_identifier: nil,
        alien_number: "047122478",
        i94_number: nil,
        visa_number: nil,
        passport_number: nil,
        sevis_id: nil,
        naturalization_number: "30121997",
        receipt_number: nil,
        citizenship_number: nil,
        card_number: nil,
        country_of_citizenship: nil,
        expiration_date: DateTime.now,
        issuing_country: nil,
        status: "not submitted",
        verification_type: "Citizenship",
        comment: nil
      }
    ]
  end

  let(:ridp_documents) do
    [
      {
        title: "license - back.pdf",
        creator: "mhc",
        subject: "license - back.pdf",
        description: nil,
        publisher: "mhc",
        contributor: nil,
        date: Date.today,
        type: "text",
        format: "application/octet-stream",
        identifier: nil, source: "enroll_system",
        language: "en", relation: nil, coverage: nil,
        rights: 'public',
        tags: [],
        size: nil,
        doc_identifier: nil,
        status: "downloaded",
        ridp_verification_type: "Identity",
        comment: nil,
        uploaded_at: Date.today
      }
    ]
  end

  let(:verification_type_history_elements) do
    [
      { verification_type: "Social Security Number",
        action: "SSA Hub Request",
        modifier: "Enroll App",
        update_reason: "Hub request" }
    ]
  end

  let!(:consumer_role) do
    {
      five_year_bar: false,
      requested_coverage_start_date: Date.today,
      aasm_state: "fully_verified",
      is_applicant: true,
      birth_location: nil,
      marital_status: nil,
      is_active: true,
      is_applying_coverage: true,
      raw_event_responses: [],
      bookmark_url: nil,
      admin_bookmark_url: nil,
      contact_method: "Only Paper communication",
      language_preference: "English",
      is_state_resident: true,
      identity_validation: "na",
      application_validation: "na",
      identity_update_reason: nil,
      application_update_reason: nil,
      identity_rejected: false,
      application_rejected: false,
      documents: [],
      vlp_documents: vlp_documents,
      ridp_documents: ridp_documents,
      verification_type_history_elements: verification_type_history_elements,
      lawful_presence_determination: lawful_presence_determination,
      local_residency_responses: event_response,
      local_residency_requests: event_request
    }
  end

  let!(:resident_role) do
    {
      is_applicant: true,
      is_active: true,
      bookmark_url: "/families/home",
      is_state_resident: true,
      residency_determined_at: Date.today,
      contact_method: "Paper and Electronic communications",
      language_preference: "English",
      local_residency_responses: event_response,
      lawful_presence_determination: lawful_presence_determination
    }
  end

  let!(:individual_market_transitions) do
    [
      {
        role_type: "consumer",
        start_on: Date.today,
        end_on: Date.today,
        reason_code: "initial_individual_market_transition_created_using_data_migration",
        submitted_at: DateTime.now
      }
    ]
  end

  let!(:verification_types) do
    [
      {
        type_name: "DC Residency",
        validation_status: "attested",
        applied_roles: ["consumer_role"],
        update_reason: nil,
        rejected: false,
        external_service: nil,
        due_date: Date.today,
        due_date_type: nil,
        updated_by: person_reference,
        inactive: nil,
        vlp_documents: []
      }
    ]
  end

  let(:broker_agency_reference) do
    { hbx_id: "1233444", market_kind: 'both', name: 'broker agency', dba: nil, display_name: nil, fein: '089441964', corporate_npn: nil }
  end

  let!(:broker_role) do
    {
      aasm_state: "decertified",
      npn: "2355863",
      broker_agency_reference: broker_agency_reference,
      provider_kind: "broker",
      reason: "Broker has obtained carrier appointments and has completed training.",
      market_kind: "both",
      languages_spoken: ["en"],
      working_hours: false,
      accept_new_clients: nil,
      license: nil,
      training: nil,
      carrier_appointments:
        {
          aetna_health_inc: nil,
          aetna_life_insurance_company: nil,
          carefirst_bluechoice_inc: nil,
          group_hospitalization_and_medical_services_inc: nil,
          kaiser_foundation: nil, optimum_choice: nil,
          united_health_care_insurance: nil,
          united_health_care_mid_atlantic: nil
        }
    }
  end

  let(:addresses) do
    [
      {
        kind: "home",
        address_1: "S Street NW",
        address_2: "",
        address_3: "",
        city: "Washington",
        county: "",
        state: "DC",
        location_state_code: nil,
        full_text: nil,
        zip: "20009",
        country_name: ""
      }
    ]
  end

  let(:phones) do
    [
      {
        kind: "home",
        country_code: "",
        area_code: "202",
        number: "2991290",
        extension: "",
        primary: true,
        full_phone_number: "2022991290"
      }
    ]
  end

  let(:emails) do
    [
      {
        kind: "home",
        address: "test@gmail.com"
      }
    ]
  end

  let(:timestamp) do
    {
      submitted_at: DateTime.now,
      created_at: DateTime.now,
      modified_at: DateTime.now
    }
  end

  let!(:person) do
    {
      hbx_id: '1001',
      is_active: true,
      is_disabled: false,
      no_dc_address: nil,
      no_dc_address_reason: nil,
      is_homeless: nil,
      is_temporarily_out_of_state: nil,
      age_off_excluded: nil,
      is_applying_for_assistance: nil,
      person_name: person_name,
      person_health: person_health,
      demographics: demographics,
      person_relationships: person_relationships,
      consumer_role: consumer_role,
      resident_role: resident_role,
      individual_market_transitions: individual_market_transitions,
      verification_types: verification_types,
      broker_role: broker_role,
      addresses: addresses,
      phones: phones,
      emails: emails,
      documents: documents,
      timestamp: timestamp
    }
  end

  let(:hbx_enrollment_exemptions) { [] }

  let(:family_member_params) do
    [
      {
        hbx_id: '1001',
        is_primary_applicant: false,
        is_consent_applicant: true,
        is_coverage_applicant: nil,
        is_active: true,
        person: person,
        timestamp: timestamp
      }
    ]
  end

  let(:special_enrollment_periods) do
    [
      {
        qualifying_life_event_kind_reference: qualifying_life_event_kind_reference,
        qle_on: Date.today,
        is_valid: nil,
        effective_on_kind: "first_of_next_month",
        effective_on: Date.today,
        submitted_at: Date.today,
        title: "Lost or will soon lose other health insurance ",
        start_on: Date.today,
        end_on: Date.today,
        qle_answer: nil,
        next_poss_effective_date: Date.today,
        option1_date: Date.today,
        option2_date: Date.today,
        option3_date: Date.today,
        optional_effective_on: [],
        csl_num: nil,
        market_kind: nil,
        admin_flag: nil
      }
    ]
  end

  let(:broker_accounts) do
    [
      {
        start_on: Date.today,
        end_on: nil,
        updated_by: person_reference,
        broker_agency_reference: broker_agency_reference,
        broker_role_reference: broker_role_reference,
        is_active: true

      }
    ]

  end

  let!(:general_agency_accounts) { [] }

  let!(:irs_groups) do
    [
      {
        hbx_id: '1233',
        start_on: Date.today,
        end_on: Date.today,
        is_active: true
      }
    ]
  end

  let!(:payment_transactions) do
    [
      {
        payment_transaction_id: nil,
        enrollment_id: "44444",
        carrier_id: "123",
        enrollment_effective_date: Date.today,
        status: nil
      }
    ]
  end

  let!(:foreign_keys) do
    [
      {
        key: 'curam_e_case_id',
        item: '33333',
        kind: {
          key: 'e_case',
          namespace: 'curam',
          label: 'Curam Case Id',
          description: ''
        },
        start_on: Date.today,
        end_on: Date.today
      }
    ]
  end

  let(:required_params) do
    { hbx_id: '1000',
      foreign_keys: foreign_keys,
      renewal_consent_through_year: 2014,
      min_verification_due_date: nil,
      vlp_documents_status: nil,
      family_members: family_member_params,
      households: household_params,
      documents: documents,
      special_enrollment_periods: special_enrollment_periods,
      broker_accounts: broker_accounts,
      general_agency_accounts: general_agency_accounts,
      irs_groups: irs_groups,
      payment_transactions: payment_transactions,
      updated_by: person_reference,
      timestamp: timestamp }
  end

  context 'success case' do
    before do
      @result = subject.call(required_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end
  end

  context 'consumer role is not applying for coverage and their citizen status is nil' do
    before do
      consumer_role_reference[:is_applying_coverage] = false
      consumer_role_reference[:citizen_status] = nil
      @result = subject.call(required_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end
  end

  context 'failure case' do
    context 'missing required param' do
      before do
        @result = subject.call(required_params.reject { |k, _v| k == :family_members })
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('is missing')
      end
    end

    context 'with bad input data type' do
      before do
        @result = subject.call(required_params.merge(households: {}))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('must be an array')
      end

      it 'should return error message' do
        result = subject.call(required_params.merge(renewal_consent_through_year: 2012))
        expect(result.errors.messages.first.text).to eq('must be one of: 2014 - 2025')
      end
    end

    context 'consumer reference is applying for coverage and citizen status is nil' do
      before do
        consumer_role_reference[:citizen_status] = nil
        @result = subject.call(required_params)
      end

      it "should return failure" do
        expect(@result.success?).to be_falsy
      end

      it "should return error message" do
        expect(@result.errors.messages.first.text).to eq("Citizen status must be filled")
      end
    end

    context 'consumer reference is applying for coverage is nil and citizen status is nil' do
      before do
        consumer_role_reference[:is_applying_coverage] = nil
        consumer_role_reference[:citizen_status] = nil
        @result = subject.call(required_params)
      end

      it "should return failure" do
        expect(@result.success?).to be_falsy
      end

      it "should return error message" do
        expect(@result.errors.messages.first.text).to eq("must be boolean")
      end
    end

    context 'with magi_medicaid_applications' do
      let(:applicant) do
        { name: {},
          identifying_information: {},
          citizenship_immigration_status_information: { citizen_status: 'us_citizen' },
          demographic: {},
          attestation: {},
          is_primary_applicant: true,
          is_applying_coverage: false,
          family_member_reference: {},
          person_hbx_id: '95',
          is_required_to_file_taxes: false,
          pregnancy_information: {},
          has_job_income: false,
          has_self_employment_income: false,
          has_unemployment_income: false,
          has_other_income: false,
          has_deductions: false,
          has_enrolled_health_coverage: false,
          has_eligible_health_coverage: false }
      end
      let(:magi_medicaid_applications) do
        [{ family_reference: {},
           assistance_year: Date.today.year,
           aptc_effective_date: Date.today,
           applicants: [],
           us_state: 'DC',
           notice_options: { send_eligibility_notices: true, send_open_enrollment_notices: false },
           oe_start_on: Date.new(Date.today.year, 11, 1),
           hbx_id: '200000123' },
         { applicants: [applicant] }]
      end

      let(:family_with_magi_medicaid_apps) do
        required_params.merge({ magi_medicaid_applications: magi_medicaid_applications })
      end

      before do
        @errors = subject.call(family_with_magi_medicaid_apps).errors.to_h
      end

      it 'should return errors for first magi_medicaid_application' do
        expect(@errors[:magi_medicaid_applications][0]).to eq({ family_reference: { hbx_id: ['is missing'] } })
      end

      it 'should return errors for second magi_medicaid_application' do
        error_hash = { family_reference: ['is missing'],
                       assistance_year: ['is missing'],
                       aptc_effective_date: ['is missing'],
                       applicants: { 0 => { name: { first_name: ['is missing'], last_name: ['is missing'] },
                                            identifying_information: ["must be filled"],
                                            demographic: ["must be filled"],
                                            attestation: ["must be filled"],
                                            family_member_reference: { family_member_hbx_id: ['is missing'] },
                                            pregnancy_information: { is_pregnant: ['is missing'] },
                                            age_of_applicant: ['is missing'],
                                            benchmark_premium: ['is missing'],
                                            is_homeless: ['is missing'] } },
                       us_state: ['is missing'],
                       oe_start_on: ['is missing'],
                       notice_options: ['is missing'],
                       hbx_id: ['is missing'] }
        expect(@errors[:magi_medicaid_applications][1]).to eq(error_hash)
      end

      context 'validates ENR notice payload' do
        let(:enr_params) do
          { :hbx_id => "10365",
            :family_members => [
              { :is_primary_applicant => true,
                :person => {
                  :hbx_id => "1005166",
                  :person_name => { :first_name => "aqhp10", :last_name => "last" },
                  :demographics => { :ssn => "523542433", :gender => "male", :dob => "2003-07-01", :is_incarcerated => false },
                  :person_health => { :is_tobacco_user => "unknown" },
                  :is_active => true, :is_disabled => nil, :verification_types => []
                } }
            ],
            :households => [
              {
                :start_date => "2021-07-10",
                :is_active => true,
                :coverage_households => [
                  {
                    :is_immediate_family => true,
                    :coverage_household_members => [{ :is_subscriber => true }]
                  },
                  {
                    :is_immediate_family => false,
                    :coverage_household_members => []
                  }
                ],
                :hbx_enrollments => [
                  {
                    :effective_on => "2021-07-01",
                    :aasm_state => "coverage_selected",
                    :market_place_kind => "individual",
                    :enrollment_period_kind => "special_enrollment",
                    :product_kind => "health",
                    :product_reference => {
                      :hios_id => "48396ME0710040-01",
                      :name => "Anthem Catastrophic X HMO 8550",
                      :active_year => 2021,
                      :is_dental_only => false,
                      :metal_level => "catastrophic",
                      :benefit_market_kind => "aca_individual",
                      :product_kind => "health",
                      :csr_variant_id => "01",
                      :is_csr => false,
                      :family_deductible => "$8550 per person | $17100 per group",
                      :individual_deductible => "$8,550",
                      :issuer_profile_reference => { :hbx_id => "100241", :name => "Anthem Blue Cross and Blue Shield", :abbrev => "ANTHM" }
                    },
                    :issuer_profile_reference => {
                      :hbx_id => "100241",
                      :name => "Anthem Blue Cross and Blue Shield",
                      :abbrev => "ANTHM",
                      :phone => "1111111111"
                    },
                    :special_enrollment_period_reference => {
                      :qualifying_life_event_kind_reference => {
                        :start_on => "2021-05-20",
                        :title => "Had a baby",
                        :reason => "birth",
                        :market_kind => "individual"
                      },
                      :qle_on => "2021-07-01",
                      :start_on => "2021-07-01",
                      :end_on => "2021-08-30",
                      :effective_on => "2021-07-01",
                      :submitted_at => "2021-07-10T12:12:53.000+00:00"
                    },
                    :total_premium => 162.56,
                    :is_receiving_assistance => false,
                    :consumer_role_reference => {
                      :is_active => true,
                      :is_applying_coverage => true,
                      :is_applicant => true,
                      :is_state_resident => false,
                      :lawful_presence_determination => {},
                      :citizen_status => "us_citizen"
                    },
                    :hbx_enrollment_members => [
                      {
                        :family_member_reference => {
                          :family_member_hbx_id => "1005166",
                          :first_name => "aqhp10",
                          :last_name => "last",
                          :person_hbx_id => "1005166",
                          :is_primary_family_member => true,
                          :age => 18
                        },
                        :is_subscriber => true, :eligibility_date => "2021-07-01", :coverage_start_on => "2021-07-01"
                      }
                    ]
                  }
                ]
              }
            ], :documents_needed => false }
        end

        it 'should return success' do
          result = subject.call(enr_params)
          expect(result.success?).to be_truthy
        end
      end
    end
  end
end
