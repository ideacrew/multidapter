# frozen_string_literal: true
require "spec_helper"

RSpec.describe Multidapter::Operations::Servers::Create do

  let(:url)               { URI("amqp://example.com") }
  let(:protocol)          { :amqp }
  let(:protocol_version)  { "0.9.1" }
  let(:description)       { "RabbitMQ server" }
  let(:variables)         { nil }
  let(:security)          { nil }
  let(:bindings)          { nil }

  # let(:security_scheme)   { { type: :user_password, description: "simple authentication" } }

  let(:required_params)   { { url: url, protocol: protocol } }
  let(:optional_params)   { {
                              protocol_version: protocol_version,
                              description:      description,
                              # variables:        variables,
                              # security:         security,
                              # bindings:         bindings,
  } }

  let(:all_params)        { required_params.merge(optional_params) }

  context "sending required parameters " do

    it "should create new Server instance" do
      expect(subject.call(required_params).success).to be_truthy
      expect(subject.call(required_params).value!).to be_a(Multidapter::Server)
    end

    it "should have attributes that match input params" do
      result = subject.call(required_params).value!.to_h

      expect(result[:url]).to be_a URI::AMQP
      expect(result.reject { |k,v| k == :url }).to eq required_params.reject { |k,v| k == :url }
    end 
  end

  context "sending required parameters " do

    it "should should create new Server instance" do
      expect(subject.call(required_params).success?).to be_truthy
      expect(subject.call(required_params).value!).to be_a(Multidapter::Server)
    end

    it "should have attributes that match input params" do
      result = subject.call(all_params).value!.to_h

      expect(result[:url]).to be_a URI::AMQP
      expect(result.reject { |k,v| k == :url }).to eq all_params.reject { |k,v| k == :url }
    end 
  end

  context "With custom Variable values" do
    let(:heartbeat)         { { key: :heartbeat, value: { default: "5", description: "Customize heartbeat value"} } }
    let(:frame_max)         { { key: :frame_max, value: { default: "131000", description: "Customize frame_max value"} } }
    let(:custom_variables)  { { variables: [heartbeat, frame_max] } } 
    let(:custom_params)     { all_params.merge(custom_variables) }

    it "should replace the default options with custom values" do
      result = subject.call(custom_params)
      expect(result.success?).to be_truthy
      expect(result.value!).to be_a(Multidapter::Server)
      expect(result.value!.to_h).to eq custom_params
    end
  end


end
