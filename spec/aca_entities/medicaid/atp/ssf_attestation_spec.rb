# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/not_incarcerated_indicator'
require 'aca_entities/medicaid/atp/ssf_attestation'

RSpec.describe ::AcaEntities::Medicaid::Atp::SsfAttestation, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { non_perjury_indicator: true,
        not_incarcerated_indicators: [{metadata: nil, value: true}],
        information_changes_indicator: false
      }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error, /:non_perjury_indicator is missing in Hash input/)
    end
  end
end
