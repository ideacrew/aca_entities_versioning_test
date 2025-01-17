# frozen_string_literal: true

require "spec_helper"
require "aca_entities/pay_now/care_first"

RSpec.describe ::AcaEntities::PayNow::CareFirst::PayNowTransferPayload, dbclean: :after_each do
  let(:member_name) do
    { :person_surname => "Thomas",
      :person_given_name => "Jeff" }
  end

  let(:primary) do
    { :exchange_assigned_member_id => "1037294",
      :member_name => member_name }
  end

  let(:member) do
    { :exchange_assigned_member_id => "1037294",
      :member_name => member_name,
      :birth_date => "19740601",
      :sex => "M",
      :relationship => "18",
      :is_subscriber => true }
  end

  let(:required_params) do
    { coverage_kind: AcaEntities::PayNow::CareFirst::Types::PaynowCoverageKindType.values.first,
      primary: primary,
      members: [member] }
  end
  let(:optional_params) { {} }
  let(:all_params) { required_params.merge(optional_params) }
  let(:invalid_params) do
    { bad_key: "bad_val" }
  end

  context "invalid parameters" do
    context "with empty parameters" do
      it "should list error for every required parameter" do
        expect { described_class.new }.to raise_error(Dry::Struct::Error, /:person_surname is missing in Hash input/)
      end
    end
  end

  context "valid parameters" do
    context "with required parameters only" do
      it "should initialize" do
        expect(described_class.new(required_params)).to be_a described_class
      end

      it "should not raise error" do
        expect { described_class.new(required_params) }.not_to raise_error
      end
    end
  end
end
