# frozen_string_literal: true
require "spec_helper"

RSpec.describe Multidapter::Adapters::Amqp::Operations::CreateServer do

  let(:url)               { "amqp://127.0.0.1" }
  let(:protocol)          { :amqp }
  let(:protocol_version)  { "0.9.1" }
  let(:description)       { "RabbitMQ server" }
  let(:variables)         { nil }
  let(:security)          { nil }
  let(:bindings)          { nil }

  let(:server)            { {
                              url: url,
                              protocol: protocol,
                              protocol_version: protocol_version,
                              description: description,
                              # security: security,
                              # variables: variables,
                              # bindings: bindings,
                            }
                            }

  context "With valid parameters" do

    it "should return a connection and server" do
      result = subject.call(server)

      expect(result.success?).to be_truthy
      expect(result.value!.first).to be_a Bunny::Session
      expect(Multidapter::Adapters::Amqp::Operations::Active.call(result.value!.first)).to be_truthy
      expect(result.value!.last.value!).to be_a Multidapter::Server
    end
  end

  context "With custom Variable values" do
    let(:heartbeat)         { { key: :heartbeat, value: { default: 5, description: "Customize heartbeat value"} } }
    let(:frame_max)         { { key: :frame_max, value: { default: 131_000, description: "Customize frame_max value"} } }
    let(:custom_variables)  { { variables: [heartbeat, frame_max] } } 

    let(:params)            { server.merge(custom_variables) }

    it "should replace the default options with custom values" do
      expect(subject.call(params)).to be_nil
    end
  end

  context "With Security values" do
    let(:security_scheme)   { { type: :user_password, description: "simple authentication" } }
    let(:security)          { security_scheme }

    it "should do security stuff"
  end

end
