# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Events::EventResponse, dbclean: :after_each do

  let(:input_params) do
    {
      received_at: DateTime.now,
      body: "response"
    }
  end

  describe 'with valid arguments' do

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
