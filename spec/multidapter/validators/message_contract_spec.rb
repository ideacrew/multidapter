# frozen_string_literal: true

require "spec_helper"

RSpec.describe Multidapter::Validators::MessageContract do

  let(:name)                    { "UserSignup" }
  let(:title)                   { "User signup" }
  let(:summary)                 { "Action to sign a user up." }
  let(:description)             { "A longer description" }
  let(:contentType)             { "application/json" }
  let(:tags)                    { [
                                    { "name": "user" },
                                    { "name": "signup" },
                                    { "name": "register" }
                                  ]
                                  }

  let(:header_type)             { "object" }
  let(:header_correlation_id)   { { description: "Correlation ID set by application", type: "string" } }
  let(:application_instance_id) { { description: "Unique identifier for a given instance of the publishing application", type: "string" } }
  let(:header_properties)       { { correlation_id: header_correlation_id, application_instance_id: application_instance_id } }
  let(:headers)                 { { type: header_type, properties: header_properties } }

  let(:payload_type)            { "object" }
  let(:user)                    { { "$ref": "#/components/schemas/userCreate" } }
  let(:signup)                  { { "$ref": "#/components/schemas/signup" } }
  let(:payload_properties)      { { user: user, signup: signup } }

  let(:correlation_id)          { { description: "Correlation ID set by application", type: "string" } }

  let(:payload)                 { { type: payload_type, properties: payload_properties } }
  let(:correlation_id)          { { description: "Default Correlation ID", location: '$message.header#/correlation_id' } }
  let(:traits)                  { [ { "$ref": "#/components/messageTraits/commonHeaders" } ] }

  let(:schema_format)           { nil }
  let(:content_type)            { nil }
  let(:external_docs)           { [] }
  let(:bindings)                { nil }
  let(:examples)                { nil }

  let(:optional_params)   { {
                              headers: headers,
                              payload: payload,
                              name: name,
                              title: title,
                              summary: summary,
                              description: description,
                              traits: traits,
                              tags: tags,

                              schema_format: schema_format,
                              content_type: content_type,
                              external_docs: external_docs,
                              bindings: bindings,
                              examples: examples,
                            }
                            }


  describe '#call' do
    context "Given empty parameters" do
      it { expect(subject.call({}).success?).to be_truthy }
    end

    context "Given valid parameters" do

      context "and optional parameters" do

        it "should successfully return all optional params as attributes" do
          result = subject.call(optional_params)

          expect(result.success?).to be_truthy
          expect(result.to_h).to eq optional_params

          expect(result[:headers]).to eq headers
          expect(result[:payload]).to eq payload
          expect(result[:name]).to eq name
          expect(result[:title]).to eq title
          expect(result[:summary]).to eq summary
          expect(result[:description]).to eq description
          expect(result[:tags]).to eq tags
          expect(result[:traits]).to eq traits

          expect(result[:schema_format]).to eq schema_format
          expect(result[:content_type]).to eq content_type
          expect(result[:external_docs]).to eq external_docs
          expect(result[:bindings]).to eq bindings
          expect(result[:examples]).to eq examples
        end
      end

    end
  end


end
