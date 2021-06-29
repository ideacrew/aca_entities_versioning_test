# frozen_string_literal: true

require "spec_helper"

RSpec.describe ::AcaEntities::BenefitMarkets::BenefitSponsorCatalog do

  context "Given valid required parameters" do

    let(:contract)                { AcaEntities::BenefitMarkets::BenefitSponsorCatalogs::BenefitSponsorCatalogContract.new }

    let(:effective_date)          { Date.today.next_month }
    let(:effective_period)        { effective_date..effective_date.next_year.prev_day }
    let(:oe_start_on)             { Date.today }
    let(:open_enrollment_period)  { oe_start_on..(oe_start_on + 10) }

    let(:probation_period_kinds)  { [] }

    let(:premium_ages)            { 16..40 }

    let(:pricing_units)           { [{ name: 'name', display_name: 'Employee Only', order: 1 }] }
    let(:member_relationships)    do
      [{ relationship_name: :employee, relationship_kinds: ['self'], age_threshold: 18, age_comparison: :==, disability_qualifier: true }]
    end

    let(:pricing_model) do
      {

        name: 'name', price_calculator_kind: 'price_calculator_kind', pricing_units: pricing_units,
        product_multiplicities: [:product_multiplicities], member_relationships: member_relationships
      }
    end

    let(:contribution_unit) do
      {
        name: "Employee",

        display_name: "Employee Only",
        order: 1,
        member_relationship_maps: [relationship_name: :employee, operator: :==, count: 1]
      }
    end

    let(:contribution_model) do
      {

        title: 'title', sponsor_contribution_kind: 'sponsor_contribution_kind', contribution_calculator_kind: 'contribution_calculator_kind',
        many_simultaneous_contribution_units: true, product_multiplicities: [:product_multiplicities1, :product_multiplicities2],
        member_relationships: member_relationships, contribution_units: [contribution_unit], key: :key
      }
    end

    let(:sbc_document) do
      {
        title: 'title', creator: 'creator', publisher: 'publisher', format: 'file_format',
        language: 'language', type: 'type', source: 'source'
      }
    end

    let(:premium_tuples)   { { age: 12, cost: 227.07 } }
    let(:premium_tables)   { [{ effective_period: effective_period, premium_tuples: [premium_tuples] }] }

    let(:product) do
      {
        hios_id: '9879', hios_base_id: '34985', metal_level_kind: :silver,
        ehb: 0.9, is_standard_plan: true, hsa_eligibility: true, csr_variant_id: '01', health_plan_kind: :health_plan_kind,
        benefit_market_kind: :benefit_market_kind, application_period: effective_period, kind: :health,
        hbx_id: 'hbx_id', title: 'title', description: 'description', product_package_kinds: [:product_package_kinds],
        premium_ages: 19..60, provider_directory_url: 'provider_directory_url',
        is_reference_plan_eligible: true, deductible: '123', family_deductible: '345', rx_formulary_url: 'rx_formulary_url',
        issuer_assigned_id: 'issuer_assigned_id', network_information: 'network_information',
        nationwide: true, dc_in_network: false, sbc_document: nil, premium_tables: premium_tables, renewal_product_id: nil
      }
    end

    let(:product_packages) do
      {
        application_period: effective_period, benefit_kind: :benefit_kind, product_kind: :product_kind, package_kind: :package_kind,
        title: 'Title', products: [product], contribution_model: contribution_model, contribution_models: [contribution_model],
        assigned_contribution_model: contribution_model, description: nil, pricing_model: pricing_model
      }
    end

    let(:required_params) do
      {
        effective_date: effective_date, effective_period: effective_period, open_enrollment_period: open_enrollment_period,
        probation_period_kinds: probation_period_kinds, product_packages: [product_packages]
      }
    end

    context "with all/required params" do

      # it "contract validation should pass" do
      #   result = contract.call(required_params)
      #   expect(result.success?).to be_truthy
      # end

      # it "should create new BenefitSponsorCatalog instance" do
      #   expect(described_class.new(required_params)).to be_a AcaEntities::BenefitMarkets::BenefitSponsorCatalog
      # end
    end
  end
end
