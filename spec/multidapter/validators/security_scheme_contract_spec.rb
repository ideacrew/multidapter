# frozen_string_literal: true
require "spec_helper"

RSpec.describe Multidapter::Validators::SecuritySchemeContract do

  let(:type)                { :user_password }
  let(:description)         { "Simple username/password" }
  let(:name)                { nil }
  let(:in_value)            { nil }
  let(:scheme)              { nil }
  let(:bearer_format)       { nil }
  let(:open_id_connect_url) { nil }
  let(:flows)               { nil }

  let(:required_params)   { { type: type } }
  let(:optional_params)   { {
                              description: description,
                              name: name,
                              in: in_value,
                              scheme: scheme,
                              bearer_format: bearer_format,
                              open_id_connect_url: open_id_connect_url,
                              flows: flows,
  } }

  let(:all_params)          { required_params.merge(optional_params) }

  context "validate required parameters" do
    let(:required_params_error)     { {:type=>["is missing"]} }

    context "sending no parameters should fail with :errors" do
      it { expect(subject.call({}).failure?).to be_truthy }
      it { expect(subject.call({}).errors.to_h).to eq required_params_error }
    end

    context "sending optional parameters only should fail with :errors" do
      it { expect(subject.call(optional_params).failure?).to be_truthy }
      it { expect(subject.call(optional_params).errors.to_h).to eq required_params_error }
    end

    context "sending unrecognized type value should fail with :errors" do
      let(:invalid_type)          { :unsecure_scheme }
      let(:invalid_type_params)   { { type: invalid_type } }
      let(:type_error)            { {:type=>["must be one of: user_password, api_key, x509, symmetric_encryption, asymmetric_encryption, http_api_key, http, oauth2, open_id_connect"]} }

      it { expect(subject.call(invalid_type_params).failure?).to be_truthy }
      it { expect(subject.call(invalid_type_params).errors.to_h).to eq type_error }
    end

    context "sending required parameters only should succeed" do
      it { expect(subject.call(required_params).success?).to be_truthy }
      it { expect(subject.call(required_params).to_h).to eq required_params }
    end

    context "sending all required and optional parameters should succeed" do
      it { expect(subject.call(all_params).success?).to be_truthy }
      it { expect(subject.call(all_params).to_h).to eq all_params }
    end

    context "passing in Type key as a string should succeed" do
      let(:required_params_as_string) { { "type" => type.to_s } }

      it "should coerce stringified key and value into symbol" do
        result = subject.call(required_params_as_string).to_h
        expect(result.keys).to include(:type)
        expect(result[:type]).to eq type
      end
    end

  end

end
