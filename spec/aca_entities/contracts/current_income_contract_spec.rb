# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/current_income_contract'

RSpec.describe AcaEntities::Contracts::CurrentIncomeContract,  dbclean: :after_each do

  subject do
    described_class.new.call(params)
  end

  describe 'passing valid params' do
    let(:params) do
      { most_recent_hire_date: Date.today.to_s, termination_date: Date.today.next_year.to_s }
    end

    it 'passes' do
      expect(subject).to be_success
    end
  end

  describe 'passing invalid params' do
    let(:params) do
      { most_recent_hire_date: 'Test1', termination_date: 'Test20' }
    end

    it 'should return a failure with error' do
      expect(subject.errors.to_h).to eq({ most_recent_hire_date: ['must be a date'] })
    end
  end
end