# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/authorized_representative_reference_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::AuthorizedRepresentativeReferenceContract, dbclean: :after_each do

  let(:required_params) { { ref: "pe123" } }

  let(:optional_params) { {} }

  let(:all_params) { required_params.merge(optional_params)}

  context 'invalid parameters' do
    context 'with empty parameters' do
      it 'should list error for every required parameter' do
        expect(subject.call({}).errors.to_h.keys).to match_array required_params.keys
      end
    end
  end

  context 'valid parameters' do
    context 'with required parameters only' do
      let(:input_params) { required_params }

      before do
        @result = subject.call(input_params)
      end

      it { expect(@result.success?).to be_truthy }
      it { expect(@result.to_h).to eq input_params }
    end

    context 'with all required and optional parameters' do
      it 'should pass validation' do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end
end
