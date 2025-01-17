# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibilities::ShopOsseEligibilityContract do
  let(:title) { "childcare subsidy" }
  let(:description) { "childcare subsidy eligibility" }
  let(:state_histories) do
    [
      {
        effective_on: Date.today,
        is_eligible: true,
        from_state: :draft,
        to_state: :eligible,
        transition_at: DateTime.now,
        event: :move_to_eligible
      }
    ]
  end

  let(:required_params) do
    {
      key: :shop_osse_eligibility,
      title: title,
      current_state: :initial,
      state_histories: state_histories,
      evidences: evidence_params,
      grants: grant_params
    }
  end

  let(:subject_ref) do
    URI("gid://enroll_app/BenefitSponsors/BenefitSponsorship")
  end
  let(:evidence_ref) { URI("gid://enroll_app/BenefitSponsors/Evidence") }

  let(:evidence_params) do
    [
      {
        key: :shop_osse_evidence,
        title: "childcare subsidy",
        is_satisfied: true,
        current_state: :initial,
        description: "childcare subsidy evidence",
        state_histories: [
          state_histories.first.merge(transition_at: DateTime.now)
        ],
        evidence_ref: evidence_ref,
        subject_ref: subject_ref
      }
    ]
  end

  let(:grant_params) do
    [
      {
        key: :min_employee_participation_relaxed_grant,
        title: "minimum employee rule relaxed ",
        description: "relaxed minimum number of employees",
        value:
          AcaEntities::Eligible::Value.new(
            title: "minimum employee rule relaxed",
            key: :min_employee_relaxed
          ).to_h
      }
    ]
  end

  let(:optional_params) { { description: description } }

  let(:optional_params) do
    {
      event: "mark_eligible",
      comment: "hc4cc eligibility submitted",
      reason: "childcare subsidy"
    }
  end

  let(:error_message) do
    { title: ["is missing"], state_histories: ["is missing"] }
  end

  let(:result) { double(success?: true) }

  context "Given invalid required parameters" do
    context "sending with missing parameters should fail validation with :errors" do
      let(:invalid_params) { required_params.except(:title, :state_histories) }
      it { expect(subject.call(invalid_params).failure?).to be_truthy }
      it do
        expect(subject.call(invalid_params).errors.to_h).to eq error_message
      end
    end

    context "when state histories invalid" do
      context "it should fail validation" do
        let(:state_histories) do
          [
            {
              effective_on: Date.today,
              is_eligible: true,
              from_state: :draft,
              to_state: :eligible,
              event: :move_to_eligible
            }
          ]
        end

        let(:invalid_params) { required_params }
        let(:error_message) do
          {
            state_histories: {
              0 => [
                {
                  text: "invalid state history",
                  error: {
                    transition_at: ["is missing"]
                  }
                }
              ]
            }
          }
        end

        it { expect(subject.call(invalid_params).failure?).to be_truthy }
        it do
          expect(subject.call(invalid_params).errors.to_h).to eq error_message
        end
      end
    end
  end

  context "Given valid required parameters" do
    context "with a required only" do
      it "should pass validation" do
        expect(subject.call(required_params).success?).to be_truthy
        expect(subject.call(required_params).to_h).to eq required_params
      end
    end
  end
end
