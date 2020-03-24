# frozen_string_literal: true
require "spec_helper"

RSpec.describe Multidapter::Adapters::Amqp::Operations::ConnectServer do

  let(:url)               { "amqp://127.0.0.1" }
  let(:protocol)          { :amqp }
  let(:protocol_version)  { "0.9.1" }
  let(:description)       { "RabbitMQ server" }
  let(:security_scheme)   { { type: :user_password, description: "simple authentication" } }
  let(:security)          { security_scheme }

  let(:server)            { {
                              url: url,
                              protocol: protocol,
                              protocol_version: protocol_version,
                              description: description,
                              security: security,
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

end
