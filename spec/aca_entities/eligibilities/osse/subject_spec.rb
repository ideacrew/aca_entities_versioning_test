# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Osse::Subject do
  include_context 'eligibilities_shared_context'
  subject { described_class }

  let(:key) { URI('gid://enroll_app/Family/98765/FamilyMember/234567') }
  let(:first_name) { 'Michael' }
  let(:last_name) { 'Brady' }
  let(:is_primary) { true }
  let(:eligibility_states) { {} }

  let(:required_params) do
    {
      title: 'OSSE Eligibility',
      klass: 'FamilyMemberSubject',
      key: key
    }
  end

  let(:all_params) { required_params }

  context 'Initializing with required params' do
    it 'should pass initialize' do
      result = described_class.new(required_params)

      expect(result).to be_a described_class
    end
  end

  context "when key is missing" do
    it 'should raise Dry::Struct::Error' do
      expect do
        described_class.new(required_params.reject {|key| key == :key})
      end.to raise_error(Dry::Struct::Error, /:key is missing in Hash input/)
    end
  end
end