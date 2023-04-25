# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/pay_now/care_first'

RSpec.describe ::AcaEntities::PayNow::CareFirst::Contracts::MemberContract, dbclean: :after_each do
  let(:member_name) do
    { :person_surname => "Thomas",
      :person_given_name => "Jeff" }
  end
  let(:required_params) do
    { :exchange_assigned_member_id => "1037294",
      :member_name => member_name,
      :birth_date => "19740601",
      :sex => "M",
      :relationship => "18",
      :is_subscriber => true }
  end
  let(:optional_params) do
    { :ssn => "999121212" }
  end
  let(:all_params) do
    required_params.merge(optional_params)
  end
  let(:invalid_params) do
    { bad_key: 'bad_val' }
  end

  context 'invalid parameters' do
    context 'with empty parameters' do
      it 'should list error for every required parameter' do
        expect(subject.call({}).errors.to_h.keys).to match_array required_params.keys
      end
    end
  end

  context 'valid parameters' do
    context 'with required and optional parameters' do
      it 'should initialize' do
        expect(described_class.new(all_params)).to be_a described_class
      end

      it 'should not raise error' do
        expect { described_class.new(all_params) }.not_to raise_error
      end
    end
  end
end