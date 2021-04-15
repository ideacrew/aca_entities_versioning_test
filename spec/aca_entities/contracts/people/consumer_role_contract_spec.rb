# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::People::ConsumerRoleContract, dbclean: :after_each do

  let(:event_response) do
    [
      {
        received_at: Date.today,
        body: "response"
      }
    ]
  end

  let(:event_request) do
    [
      {
        requested_at: Date.today,
        body: "request"
      }
    ]
  end

  let!(:lawful_presence_determination) do
    {
      vlp_verified_at: Date.today,
      vlp_authority: "curam",
      vlp_document_id: nil,
      citizen_status: nil,
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
        update_reason: "Hub request",
        event_response_record: {},
        event_request_record: {} }
    ]
  end

  let!(:required_params) do
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

  context 'failure case' do
    context 'missing required param' do
      before do
        @result = subject.call(required_params.reject { |k, _v| k == :is_applying_coverage })
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
        @result = subject.call(required_params.merge(requested_coverage_start_date: nil))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('must be a date')
      end

      it 'should return error message' do
        result = subject.call(required_params.merge(vlp_documents: nil))
        expect(result.errors.messages.first.text).to eq('must be an array')
      end
    end
  end
end
