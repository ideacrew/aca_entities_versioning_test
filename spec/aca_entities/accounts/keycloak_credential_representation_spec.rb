# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::User do
  subject { described_class.new }

  it { expect(1).to eql(1) }
end
