# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/types'
require 'aca_entities/medicaid/atp/role_of_person_reference'
require 'aca_entities/medicaid/atp/ssf_primary_contact'

RSpec.describe ::AcaEntities::Medicaid::Atp::SsfPrimaryContact, dbclean: :after_each do

  describe 'with valid arguments' do

    let(:required_params) do
      {
        role_reference: { ref: "a-person-id" },
        contact_preference: "Email"
      }
    end

    let(:optional_params) { {} }

    let(:all_params) { required_params.merge(optional_params) }

    context 'invalid parameters' do
      context 'with empty parameters' do
        it 'should list error for every required parameter' do
          expect { described_class.new }.to raise_error(Dry::Struct::Error, /:ref is missing in Hash input/)
        end
      end

      context 'with optional parameters only' do
        it 'should list error for every required parameter' do
          expect { described_class.new(optional_params) }.to raise_error(Dry::Struct::Error, /:role_reference is missing in Hash input/)
        end
      end
    end

    context 'valid parameters' do
      context 'with required parameters only' do
        it 'should initialize' do
          expect(described_class.new(required_params)).to be_a described_class
        end

        it 'should not raise error' do
          expect { described_class.new(required_params) }.not_to raise_error
        end
      end

      context 'with all required and optional parameters' do
        it 'should initialize' do
          expect(described_class.new(required_params)).to be_a described_class
        end

        it 'should not raise error' do
          expect { described_class.new(required_params) }.not_to raise_error
        end
      end
    end
  end
end
