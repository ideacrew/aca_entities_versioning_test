# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/mitc_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::Contracts::RelationshipContract do
  let(:required_params) do
    { other_id: 100, attest_primary_responsibility: 'Y', relationship_code: '01' }
  end

  context 'valid params' do
    it { expect(subject.call(required_params).success?).to be_truthy }
    it { expect(subject.call(required_params).to_h).to eq required_params }
  end

  context 'relationship_code 17 for relationship kind parents_domestic_partner' do
    let(:input_params) { { other_id: 100, attest_primary_responsibility: 'Y', relationship_code: '17' } }

    before do
      @result = subject.call(input_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should return success' do
      expect(@result.to_h).to eq(input_params)
    end
  end

  context 'invalid params' do
    context 'with no parameters' do
      it 'should list error for every required parameter' do
        result = subject.call({})
        expect(result.success?).to be_falsey
        expect(result.errors.to_h.keys).to match_array required_params.keys
      end
    end
  end
end
