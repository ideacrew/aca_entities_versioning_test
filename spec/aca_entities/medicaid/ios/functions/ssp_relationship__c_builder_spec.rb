# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios/functions/ssp_relationship__c_builder'
require 'aca_entities/medicaid/ios/operations/generate_ios'
require 'aca_entities/medicaid/ios/contracts/ssp_relationship__c_contract'

RSpec.describe AcaEntities::Medicaid::Ios::Functions::SspRelationshipCBuilder, dbclean: :after_each do

  # should use more recent example payload?
  let(:family) do
    json = File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/uber_payload.json"))
    prepped_data = AcaEntities::Medicaid::Ios::Operations::GenerateIos.new.send(:prep_data, json).value!
    prepped_data[:family]
  end

  let(:application) do
    # need to use test payload that has array of applications (as opposed to single hash, or assume data prep prepares a hash)
    family[:magi_medicaid_applications]
  end

  let(:family_members_hash) do
    family[:family_members_hash]
  end

  let(:context) do
    context_hash = {
      'family.family_members_hash' => {
        name: 'family.family_members_hash',
        item: family_members_hash
      }
    }
    AcaEntities::Operations::Transforms::Context.new(context_hash)
  end

  subject do
    described_class.new.call(context)
  end

  context 'with valid family members in context' do
    it "should return an array" do
      expect(subject).to be_a(Array)
    end

    it 'should only contain valid SSPRelationshipC objects' do
      subject.each do |ssp_relationship__c|
        result = AcaEntities::Medicaid::Ios::Contracts::SSPRelationshipCContract.new.call(ssp_relationship__c)
        expect(result.success?).to be_truthy
      end
    end
  end
end