# frozen_string_literal: true
require "spec_helper"
require 'json'

RSpec.describe Multidapter::AsyncApi::Server do

  let(:url)               { "amqp://example.com" }
  let(:protocol)          { :amqp }

  let(:protocol_version)  { "0.9.1" }
  let(:description)       { "development environment server" }

  let(:variables)         { nil }
  let(:security)          { nil }
  let(:bindings)          { nil }

  let(:required_params)   { { url: url, protocol: protocol } }
  let(:optional_params)   { {
                              protocol_version: protocol_version,
                              description:      description,
                              variables:        variables,
                              security:         security,
                              bindings:         bindings,
  } }

  let(:all_params)          { required_params.merge(optional_params) }

  describe "Contract Validation" do
    let(:contract)          { Multidapter::AsyncApi::Validators::ServerContract.new }

    context "Validate Required parameters" do
      let(:required_params_error)     { {:url=>["is missing"], :protocol=>["is missing"]} }

      context "sending no parameters should fail with required parameters error" do
        it { expect(contract.call({}).failure?).to be_truthy }
        it { expect(contract.call({}).errors.to_h).to eq required_params_error }
      end

      context "sending optional parameters only should fail with required parameters error" do
        it { expect(contract.call(optional_params).failure?).to be_truthy }
        it { expect(contract.call(optional_params).errors.to_h).to eq required_params_error }
      end

      context "sending unrecognized protocol value should fail with unsupported protocol error" do
        let(:invalid_protocol)          { :zzzzz }
        let(:invalid_protocol_params)   { required_params.merge({ protocol: invalid_protocol }) }
        let(:protocol_error)            { {:protocol=>["unsupported protocol"]} }

        it { expect(contract.call(invalid_protocol_params).failure?).to be_truthy }
        it { expect(contract.call(invalid_protocol_params).errors.to_h).to eq protocol_error }
      end

      context "sending required parameters only should succeed" do
        it { expect(contract.call(required_params).success?).to be_truthy }
        it { expect(contract.call(required_params).to_h).to eq required_params }
      end
    end

    context "Validate Optional parameters" do

      context "sending all required and optional parameters should succeed" do
        it { expect(contract.call(all_params).success?).to be_truthy }
        it { expect(contract.call(all_params).to_h).to eq all_params }
      end

      context "passing URL key as a string should coerce to symbol" do
        let(:required_params_as_string) { { url: url, "protocol" => protocol.to_s } }

        it "should coerce stringified key and value into symbol" do
          result = contract.call(required_params_as_string).to_h
          expect(result.keys).to include(:protocol)
          expect(result[:protocol]).to eq protocol
        end
      end

      context "sending an invalid security value should fail with security error" do
        let(:invalid_security_scheme)   { { type: :unsecure_scheme } }
        let(:invalid_security_params)   { all_params.merge({ security: invalid_security_scheme }) }
        let(:security_error)            { { type: ["must be one of: user_password, api_key, x509, symmetric_encryption, asymmetric_encryption, http_api_key, http, oauth2, open_id_connect"] } }

        it "should return errors in metadata form: { security: [{ text: '', error: {} }] } " do
          result = contract.call(invalid_security_params)
          expect(result.failure?).to be_truthy
        end

        it { expect(contract.call(invalid_security_params).errors.to_h[:security].first[:error]).to eq security_error }
      end

      context "sending only required attributes for security" do
        let(:required_security_params)  { { type: :user_password } }
        let(:valid_security_params)     { all_params.merge({ security: required_security_params }) }

        it "should pass validation" do
          expect(contract.call(valid_security_params).success?).to be_truthy
          expect(contract.call(valid_security_params).to_h[:security]).to eq required_security_params
        end

      end

      context "sending valid Variable values should pass validation" do
        let(:port)              { { default: 42, description: "Customize port value"} }
        let(:user)              { { default: 'my_user', description: "Customize user value"} }
        let(:password)          { { default: 'my_secret', description: "Customize password value"} }
        let(:variables)         { { port: port, user: user, password: password } }
        let(:valid_variables)   { all_params.merge({ variables: variables }) }

        it "should pass validation" do
          result = contract.call(valid_variables)

          expect(result.success?).to be_truthy
          expect(result.to_h[:variables]).to include variables
        end
      end


    end
  end
end
