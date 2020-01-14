# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Multidapter::Operations::ParseYaml do

  subject { described_class.new }

  context 'with a stream of invalid YAML' do
    let(:invalid_io)  { 
invalid_io = <<-EOF
"content of this file\n" 
"is more like","a CSV file" 
"than a", "YML file"
EOF
  }

    let(:invalid_io_base64) { [invalid_io].pack("B*")[0] }
    let(:error_message) { "Failure(\"Parse YAML failed: (<unknown>): did not find expected <document start> at line 1 column 1\")" }

    it "should fail to load the IO string as YAML" do
      # expect(subject.call(invalid_io_base64)).to be_a(Dry::Monads::Result::Failure).and be_truthy
      # expect(subject.call(invalid_io_base64).to_s).to eq error_message
    end

  end

  context 'With an IO stream of valid YAML' do

    let(:valid_io) {
valid_io = <<-EOF
---
node:
  asyncapi: "2.0"
  info: 
    title: API spec
  channels:
EOF
    }

    let(:valid_yaml_hash) { { "node" => { "asyncapi" => "2.0", "info" => { "title" => "API spec" }, "channels" => nil } } }

    it "should return success along with the input IO" do
      expect(subject.call(valid_io)).to be_a(Dry::Monads::Result::Success).and be_truthy
      expect(subject.call(valid_io).value!).to include valid_yaml_hash
    end
end
   context 'a valid IO stream with ERB' do

    let(:erb_template) {
erb_template = ERB.new <<-EOF
---
node:
  asyncapi: "2.0"
  info: 
    title: <%= erb_title_value %>
  channels:
EOF
    }
    let(:erb_title_value) { "Dark Matter" }
    let(:erb_yaml_hash) { { "node" => { "zasyncapi" => "2.0", "info" => { "title" => erb_title_value }, "channels" => nil } } }


    it "should substitute the attribute value" do
      # @erb_title_value = "Dark Matter"
      # expect(subject.call(erb_template).value!).to include erb_yaml_hash
    end

  end
end