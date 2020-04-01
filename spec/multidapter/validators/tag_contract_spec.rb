# frozen_string_literal: true

require "spec_helper"

RSpec.describe Multidapter::Validators::TagContract do

  let(:name)          { "UserSignup" }
  let(:description)   { "A longer description" }
  let(:external_docs) { [] }

  let(:required_params) { { name: name } }
  let(:optional_params) { { description: description, external_docs: external_docs } }
  let(:all_params)      { required_params.merge(optional_params) }


  context "Given gapped or invalid parameters" do
    context "and parameters are empty" do
      it { expect(subject.call({}).success?).to be_falsey }
      it { expect(subject.call({}).error?(:name)).to be_truthy }
    end
  end

  context "Given valid parameters" do
    context "and required parameters only" do
      it { expect(subject.call(required_params).success?).to be_truthy }
      it { expect(subject.call(required_params).to_h).to eq required_params }
    end

    context "and required and optional parameters" do
      it { expect(subject.call(all_params).success?).to be_truthy }
      it { expect(subject.call(all_params).to_h).to eq all_params }
    end
  end


end
