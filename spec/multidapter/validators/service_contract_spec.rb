# frozen_string_literal: true

require "spec_helper"

RSpec.describe Multidapter::Validators::ServiceContract do

  let(:asyncapi)      { "2.0" }
  let(:id)            { :adapter_id }

  let(:title)         { "Adapter Title" }
  let(:version)       { "0.1.0" }
  let(:info)          { { title: title, version: version } }

  let(:channel_id)    { "email_notices" }
  let(:channels)      { [{channel_id: channel_id}] }

  let(:servers)       { [] }
  let(:components)    { [] }
  let(:tags)          { [] }
  let(:external_docs) { [] }

  let(:required_params) { { asyncapi: asyncapi, info: info, channels: channels } }
  let(:optional_params) { { id: id, servers: servers, components: components, tags: tags, external_docs: external_docs } }
  let(:all_params)      { required_params.merge(optional_params) }


  context "Given gapped or invalid parameters" do
    context "and parameters are empty" do
      it { expect(subject.call({}).success?).to be_falsey }
      it { expect(subject.call({}).error?(:asyncapi)).to be_truthy }
    end

    context "and :asyncapi parameter only" do
      it { expect(subject.call({asyncapi: asyncapi}).success?).to be_falsey }
      it { expect(subject.call({asyncapi: asyncapi}).error?(:channels)).to be_truthy }
      it { expect(subject.call({asyncapi: asyncapi}).error?(:info)).to be_truthy }
    end

    context "and :info parameter only" do
      it { expect(subject.call({info: info}).success?).to be_falsey }
      it { expect(subject.call({info: info}).error?(:channels)).to be_truthy }
      it { expect(subject.call({info: info}).error?(:asyncapi)).to be_truthy }
    end

    context "and :channels parameter only" do
      it { expect(subject.call({channels: channels}).success?).to be_falsey }
      it { expect(subject.call({channels: channels}).error?(:asyncapi)).to be_truthy }
      it { expect(subject.call({asyncapi: asyncapi}).error?(:info)).to be_truthy }
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
