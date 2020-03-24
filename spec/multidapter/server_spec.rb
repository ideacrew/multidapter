# frozen_string_literal: true

require "spec_helper"
require 'json'
require "uri"

RSpec.describe Multidapter::Server do

  let(:url)               { URI("amqp://example.com") }
  let(:protocol)          { :amqp }
  let(:protocol_version)  { "0.9.1" }
  let(:description)       { "development environment server" }

  let(:port)              { {key: :port, value: { default: "42", description: "Customize port value"}} }
  let(:user)              { {key: :user, value: { default: 'my_user', description: "Customize user value"}} }
  let(:password)          { {key: :passwork, value: { default: 'my_secret', description: "Customize password value"}} }
  let(:variables)         { [ port, user, password ] }

  let(:required_params)   { { url: url, protocol: protocol } }
  let(:optional_params)   { {
                              protocol_version: protocol_version,
                              description:      description,
                              variables:        variables,
  } }

  let(:all_params)          { required_params.merge(optional_params) }

  describe "Entity Validation" do
    context "sending required parameters only" do

      it "should be valid" do
        result = described_class.new(required_params)

        expect(result.to_h).to eq required_params
        expect(result).to be_a Multidapter::Server
      end
    end

    context "sending all parameters" do

      it "should be valid" do
        result = described_class.new(all_params)

        expect(result.to_h).to eq all_params
        expect(result).to be_a Multidapter::Server
      end
    end
  end
end
