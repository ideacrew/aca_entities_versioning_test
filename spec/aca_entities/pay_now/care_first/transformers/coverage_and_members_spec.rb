# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/pay_now/care_first'

RSpec.describe AcaEntities::PayNow::CareFirst::Transformers::CoverageAndMembers do

  describe 'When a valid hash is passed' do
    let(:additional_info_payload) do
      {
        coverage_and_members:
          {
            hbx_enrollment: enrollment,
            members: members,
            primary_person: member
          }
      }
    end
    let(:enrollment) do
      {
        hbx_id: "50272480",
        effective_on: "2023-04-01",
        aasm_state: "coverage_selected",
        market_place_kind: "individual",
        enrollment_period_kind: "special_enrollment",
        terminated_on: nil,
        product_kind: "health",
        total_premium: 408.55,
        applied_aptc_amount: {
          cents: 0,
          currency_iso: "USD"
        },
        hbx_enrollment_members: [
          {
            family_member_reference: {
              family_member_hbx_id: "50001267",
              age: 37,
              first_name: "Benito",
              last_name: "Test",
              person_hbx_id: "50001267",
              is_primary_family_member: true
            },
            is_subscriber: true,
            eligibility_date: "2023-04-01",
            coverage_start_on: "2023-04-01",
            coverage_end_on: nil,
            tobacco_use: "NA",
            slcsp_member_premium: {
              cents: 39_771,
              currency_iso: "USD"
            }
          }
        ],
        is_receiving_assistance: false,
        consumer_role_reference: {
          is_active: true,
          is_applying_coverage: true,
          is_applicant: true,
          is_state_resident: false,
          lawful_presence_determination: {},
          citizen_status: "us_citizen"
        },
        product_reference: {
          hios_id: "86052DC0400010-01",
          name: "BlueChoice HMO HSA Standard $6,350",
          active_year: 2023,
          is_dental_only: false,
          metal_level: "bronze",
          benefit_market_kind: "aca_individual",
          csr_variant_id: "01",
          is_csr: false,
          family_deductible: "$6350 per person | $12700 per group",
          individual_deductible: "$6,350",
          product_kind: "health",
          rating_method: "Age-Based Rates",
          pediatric_dental_ehb: 0.0,
          family_rated_premiums: {},
          issuer_profile_reference: {
            hbx_id: "88d36bc5e5054e849d67c32955ed00fd",
            name: "CareFirst",
            abbrev: "GHMSI"
          }
        },
        issuer_profile_reference: {
          hbx_id: "88d36bc5e5054e849d67c32955ed00fd",
          name: "CareFirst",
          abbrev: "GHMSI",
          phone: "8554443121"
        },
        special_enrollment_period_reference: {
          qualifying_life_event_kind_reference: {
            start_on: "2015-10-10",
            title: "Lost or will soon lose other health insurance ",
            reason: "lost_access_to_mec",
            market_kind: "individual"
          },
          qle_on: "2023-03-19",
          start_on: "2023-01-18",
          end_on: "2023-05-18",
          effective_on: "2023-04-01",
          submitted_at: "2023-03-03T19:28:28.000+00:00"
        }
      }
    end
    let(:members) do
      [member, member_2]
    end
    let(:member) do
      {
        person_id: "640249d786b746001059929c",
        external_person_link: "http://pvt-3-enroll.dchbx.org/exchanges/agents/resume_enrollment?person_id=640249d786b746001059929c",
        hbx_id: "50001267",
        person_name: {
          first_name: "Benito",
          middle_name: nil,
          last_name: "Test",
          name_sfx: nil,
          name_pfx: nil,
          full_name: "Benito Test",
          alternate_name: nil
        },
        demographics: {
          encrypted_ssn: "EQbS0ycavkcS7BWbp0l+2YIEvP8EKMlIkg==\n",
          no_ssn: false,
          gender: "male",
          dob: "1986-01-01",
          date_of_death: nil,
          dob_check: false,
          is_incarcerated: false,
          ethnicity: [
            "",
            "",
            "",
            "",
            "",
            "",
            ""
          ],
          race: nil,
          tribal_id: "",
          language_code: "en"
        },
        person_health: {
          is_physically_disabled: nil,
          is_tobacco_user: "unknown"
        },
        no_dc_address: false,
        no_dc_address_reason: "",
        is_homeless: false,
        is_temporarily_out_of_state: false,
        age_off_excluded: false,
        is_applying_for_assistance: false,
        is_active: true,
        is_disabled: nil,
        person_relationships: [{ :kind => "spouse",
                                 :relative => {
                                   :hbx_id => "50001268",
                                   :first_name => "Spouse",
                                   :middle_name => nil,
                                   :last_name => "Test",
                                   :encrypted_ssn => "EQbS0ycavkcS7BWbp0l+2YIEvP8EKMlIkg==\n",
                                   :no_ssn => false, :dob => "1986-01-01",
                                   :gender => "male",
                                   :relationship_to_primary => "spouse"
                                 } }],
        consumer_role: {
          five_year_bar: false,
          requested_coverage_start_date: "2023-03-03",
          aasm_state: "verification_outstanding",
          is_applicant: true,
          birth_location: nil,
          marital_status: nil,
          is_active: true,
          is_applying_coverage: true,
          bookmark_url: "https://pvt-3-enroll.priv.dchbx.org/families/home",
          admin_bookmark_url: "/insured/families/home",
          contact_method: "Paper and Electronic communications",
          language_preference: "English",
          is_state_resident: false,
          identity_validation: "valid",
          identity_update_reason: "Verified from Experian",
          application_validation: "valid",
          application_update_reason: "Verified from Experian",
          identity_rejected: false,
          application_rejected: false,
          documents: [],
          vlp_documents: [],
          ridp_documents: [],
          verification_type_history_elements: [],
          lawful_presence_determination: {
            vlp_verified_at: "2023-03-03T19:29:05.948+00:00",
            vlp_authority: "ssa",
            vlp_document_id: nil,
            citizen_status: "us_citizen",
            citizenship_result: "not_lawfully_present_in_us",
            qualified_non_citizenship_result: nil,
            aasm_state: "verification_outstanding",
            ssa_responses: [
              {
                received_at: "2023-03-03T19:29:05.881+00:00",
                body: ""
              }
            ],
            ssa_requests: [],
            vlp_responses: [],
            vlp_requests: []
          },
          local_residency_responses: [
            {
              received_at: "2023-03-04T19:29:08.549+00:00",
              body: "TIMEOUT LIMIT EXCEEDED"
            }
          ],
          local_residency_requests: [
            {
              requested_at: "2023-03-03T19:29:04.426+00:00",
              body: ""
            }
          ]
        },
        resident_role: nil,
        individual_market_transitions: [
          {
            role_type: "consumer",
            start_on: "2023-03-03",
            end_on: nil,
            reason_code: "generating_consumer_role",
            submitted_at: "2023-03-03T19:26:16.000+00:00"
          }
        ],
        verification_types: [
          {
            type_name: "DC Residency",
            validation_status: "outstanding",
            applied_roles: [
              "consumer_role"
            ],
            update_reason: nil,
            rejected: nil,
            external_service: nil,
            due_date: "2023-06-08",
            due_date_type: "response_from_hub",
            inactive: nil,
            vlp_documents: []
          },
          {
            type_name: "Social Security Number",
            validation_status: "outstanding",
            applied_roles: [
              "consumer_role"
            ],
            update_reason: nil,
            rejected: nil,
            external_service: nil,
            due_date: "2023-06-07",
            due_date_type: "response_from_hub",
            inactive: nil,
            vlp_documents: []
          },
          {
            type_name: "Citizenship",
            validation_status: "outstanding",
            applied_roles: [
              "consumer_role"
            ],
            update_reason: nil,
            rejected: nil,
            external_service: nil,
            due_date: "2023-06-07",
            due_date_type: "response_from_hub",
            inactive: nil,
            vlp_documents: []
          }
        ],
        user: {},
        addresses: [
          {
            kind: "home",
            address_1: "123 k",
            address_2: "",
            address_3: "",
            city: "washington",
            county: "",
            state: "DC",
            zip: "20000",
            country_name: "United States of America",
            has_fixed_address: true
          }
        ],
        emails: [],
        phones: [],
        documents: [],
        timestamp: {
          created_at: "2023-03-03T19:26:15.747+00:00",
          modified_at: "2023-03-03T19:29:04.355+00:00"
        },
        relationship_to_primary: 'self',
        is_subscriber: true
      }
    end
    let(:member_2) do
      {
        person_id: "640249d786b746001059929c",
        external_person_link: "http://pvt-3-enroll.dchbx.org/exchanges/agents/resume_enrollment?person_id=640249d786b746001059929c",
        hbx_id: "50001268",
        person_name: {
          first_name: "Spouse",
          middle_name: nil,
          last_name: "Test",
          name_sfx: nil,
          name_pfx: nil,
          full_name: "Spouse Test",
          alternate_name: nil
        },
        demographics: {
          encrypted_ssn: "EQbS0ycavkcS7BWbp0l+2YIEvP8EKMlIkg==\n",
          no_ssn: false,
          gender: "male",
          dob: "1986-01-01",
          date_of_death: nil,
          dob_check: false,
          is_incarcerated: false,
          ethnicity: [
            "",
            "",
            "",
            "",
            "",
            "",
            ""
          ],
          race: nil,
          tribal_id: "",
          language_code: "en"
        },
        person_health: {
          is_physically_disabled: nil,
          is_tobacco_user: "unknown"
        },
        no_dc_address: false,
        no_dc_address_reason: "",
        is_homeless: false,
        is_temporarily_out_of_state: false,
        age_off_excluded: false,
        is_applying_for_assistance: false,
        is_active: true,
        is_disabled: nil,
        person_relationships: [],
        consumer_role: {
          five_year_bar: false,
          requested_coverage_start_date: "2023-03-03",
          aasm_state: "verification_outstanding",
          is_applicant: true,
          birth_location: nil,
          marital_status: nil,
          is_active: true,
          is_applying_coverage: true,
          bookmark_url: "https://pvt-3-enroll.priv.dchbx.org/families/home",
          admin_bookmark_url: "/insured/families/home",
          contact_method: "Paper and Electronic communications",
          language_preference: "English",
          is_state_resident: false,
          identity_validation: "valid",
          identity_update_reason: "Verified from Experian",
          application_validation: "valid",
          application_update_reason: "Verified from Experian",
          identity_rejected: false,
          application_rejected: false,
          documents: [],
          vlp_documents: [],
          ridp_documents: [],
          verification_type_history_elements: [],
          lawful_presence_determination: {
            vlp_verified_at: "2023-03-03T19:29:05.948+00:00",
            vlp_authority: "ssa",
            vlp_document_id: nil,
            citizen_status: "us_citizen",
            citizenship_result: "not_lawfully_present_in_us",
            qualified_non_citizenship_result: nil,
            aasm_state: "verification_outstanding",
            ssa_responses: [
              {
                received_at: "2023-03-03T19:29:05.881+00:00",
                body: ""
              }
            ],
            ssa_requests: [],
            vlp_responses: [],
            vlp_requests: []
          },
          local_residency_responses: [
            {
              received_at: "2023-03-04T19:29:08.549+00:00",
              body: "TIMEOUT LIMIT EXCEEDED"
            }
          ],
          local_residency_requests: [
            {
              requested_at: "2023-03-03T19:29:04.426+00:00",
              body: ""
            }
          ]
        },
        resident_role: nil,
        individual_market_transitions: [
          {
            role_type: "consumer",
            start_on: "2023-03-03",
            end_on: nil,
            reason_code: "generating_consumer_role",
            submitted_at: "2023-03-03T19:26:16.000+00:00"
          }
        ],
        verification_types: [
          {
            type_name: "DC Residency",
            validation_status: "outstanding",
            applied_roles: [
              "consumer_role"
            ],
            update_reason: nil,
            rejected: nil,
            external_service: nil,
            due_date: "2023-06-08",
            due_date_type: "response_from_hub",
            inactive: nil,
            vlp_documents: []
          },
          {
            type_name: "Social Security Number",
            validation_status: "outstanding",
            applied_roles: [
              "consumer_role"
            ],
            update_reason: nil,
            rejected: nil,
            external_service: nil,
            due_date: "2023-06-07",
            due_date_type: "response_from_hub",
            inactive: nil,
            vlp_documents: []
          },
          {
            type_name: "Citizenship",
            validation_status: "outstanding",
            applied_roles: [
              "consumer_role"
            ],
            update_reason: nil,
            rejected: nil,
            external_service: nil,
            due_date: "2023-06-07",
            due_date_type: "response_from_hub",
            inactive: nil,
            vlp_documents: []
          }
        ],
        user: {},
        addresses: [
          {
            kind: "home",
            address_1: "123 k",
            address_2: "",
            address_3: "",
            city: "washington",
            county: "",
            state: "DC",
            zip: "20000",
            country_name: "United States of America",
            has_fixed_address: true
          }
        ],
        emails: [],
        phones: [],
        documents: [],
        timestamp: {
          created_at: "2023-03-03T19:26:15.747+00:00",
          modified_at: "2023-03-03T19:29:04.355+00:00"
        },
        relationship_to_primary: 'spouse',
        is_subscriber: false
      }
    end

    context 'transform mappings' do
      subject { described_class.transform(additional_info_payload) }

      context 'coverage_kind' do
        it 'should transform and populate coverage_kind field' do
          expect(subject[:pay_now_transfer_payload]).to have_key(:coverage_kind)
          expect(subject[:pay_now_transfer_payload][:coverage_kind]).to eq('urn:openhbx:terms:v1:qhp_benefit_coverage#health')
        end
      end

      context 'members' do
        it 'should transform and populate member fields' do
          subject[:pay_now_transfer_payload][:members].each do |member|
            original_member = members.detect {|m| m[:hbx_id] == member[:exchange_assigned_member_id]}
            transformed_member = member
            ssn = AcaEntities::Operations::Encryption::Decrypt.new.call({ value: original_member[:demographics][:encrypted_ssn] }).value!
            sex = AcaEntities::PayNow::CareFirst::Types::SexofIndividualTerminologyTypeMap[original_member[:demographics][:gender]]
            relationship = AcaEntities::PayNow::CareFirst::Types::PaynowMemberRelationshipCodeMap[original_member[:relationship_to_primary]]
            expect(transformed_member).to have_key(:exchange_assigned_member_id)
            expect(transformed_member[:exchange_assigned_member_id]).to eq original_member[:hbx_id]
            expect(transformed_member).to have_key(:birth_date)
            expect(transformed_member[:birth_date]).to eq original_member[:demographics][:dob].gsub('-', '')
            expect(transformed_member).to have_key(:sex)
            expect(transformed_member[:sex]).to eq sex
            expect(transformed_member).to have_key(:ssn)
            expect(transformed_member[:ssn]).to eq ssn
            expect(transformed_member).to have_key(:relationship)
            expect(transformed_member[:relationship]).to eq relationship
            expect(transformed_member).to have_key(:is_subscriber)
            expect(transformed_member[:is_subscriber]).to eq original_member[:is_subscriber]
            expect(transformed_member).to have_key(:member_name)
            expect(transformed_member[:member_name]).to have_key(:person_given_name)
            expect(transformed_member[:member_name][:person_given_name]).to eq original_member[:person_name][:first_name]
            expect(transformed_member[:member_name]).to have_key(:person_middle_name)
            expect(transformed_member[:member_name]).to have_key(:person_surname)
            expect(transformed_member[:member_name][:person_surname]).to eq original_member[:person_name][:last_name]
            expect(transformed_member[:member_name]).to have_key(:person_full_name)
            expect(transformed_member[:member_name]).to have_key(:person_name_prefix_text)
            expect(transformed_member[:member_name]).to have_key(:person_name_suffix_text)
          end
        end
      end

      context 'primary' do
        it 'should transform and populate primary fields' do
          primary = subject[:pay_now_transfer_payload][:primary]
          expect(subject[:pay_now_transfer_payload]).to have_key(:primary)
          expect(primary).to have_key(:exchange_assigned_member_id)
          expect(primary).to have_key(:member_name)
          expect(primary[:member_name]).to have_key(:person_given_name)
          expect(primary[:member_name][:person_given_name]).to eq member[:person_name][:first_name]
          expect(primary[:member_name]).to have_key(:person_middle_name)
          expect(primary[:member_name]).to have_key(:person_surname)
          expect(primary[:member_name][:person_surname]).to eq member[:person_name][:last_name]
          expect(primary[:member_name]).to have_key(:person_full_name)
          expect(primary[:member_name]).to have_key(:person_name_prefix_text)
          expect(primary[:member_name]).to have_key(:person_name_suffix_text)
        end
      end
    end

    context 'when ssn is nil' do
      before do
        additional_info_payload[:coverage_and_members][:members].first[:demographics][:encrypted_ssn] = nil
      end

      subject { described_class.transform(additional_info_payload) }

      it 'should set ssn field to nil in output hash' do
        output_ssn = subject[:pay_now_transfer_payload][:members].first[:member][:ssn]
        expect(output_ssn).to eq nil
      end
    end
  end
end