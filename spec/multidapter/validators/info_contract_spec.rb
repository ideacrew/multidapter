# frozen_string_literal: true

require "spec_helper"

RSpec.describe Multidapter::Validators::InfoContract do

  let(:title)         { "Application Title" }
  let(:version)       { "0.1.0" }

  let(:description)       { "First AsyncApi application" }
  let(:terms_of_service)  { "http://example.org/terms/" }
  let(:contact)           { {
                              name: "API Support",
                              url: "http://www.example.org/support",
                              email: "support@example.org"
                            }
                            }

  let(:license)           { {
                              "name": "Apache 2.0",
                              "url": "http://www.apache.org/licenses/LICENSE-2.0.html"
                            }
                            }

  let(:required_params)   { { title: title, version: version } }
  let(:optional_params)   { {
                              description: description,
                              terms_of_service: terms_of_service,
                              contact: contact,
                              license: license,
                            }
                            }
  let(:all_params)        { required_params.merge(optional_params) }


  context "Given gapped or invalid parameters" do
    context "and parameters are empty" do
      it { expect(subject.call({}).success?).to be_falsey }
      it { expect(subject.call({}).error?(:title)).to be_truthy }
    end

    context "and :title parameter only" do
      it { expect(subject.call({title: title}).success?).to be_falsey }
      it { expect(subject.call({title: title}).error?(:version)).to be_truthy }
    end

    context "and :version parameter only" do
      it { expect(subject.call({version: version}).success?).to be_falsey }
      it { expect(subject.call({version: version}).error?(:title)).to be_truthy }
    end
  end

  context "Given valid parameters" do
    context "and required parameters only" do
      it { expect(subject.call(required_params).success?).to be_truthy }
    end

    context "and required and optional parameters" do
      it { expect(subject.call(all_params).success?).to be_truthy }
    end
  end


end
