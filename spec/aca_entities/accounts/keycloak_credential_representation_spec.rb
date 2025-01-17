# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::KeycloakCredentialRepresentation do
  subject { described_class }

  it 'with no arguments it should create a new instance' do
    result = subject.new

    expect(
      result
    ).to be_a AcaEntities::Accounts::KeycloakCredentialRepresentation
    expect(result.to_h).to eq Hash.new
  end
end
