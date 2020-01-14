# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Multidapter::Operations::ReadFile do

  subject { described_class.new }

  context "when file doesn't exists" do
    let(:file_path)     { File.join("lib/rails/generators/multidapter/config/templates/", "xxx.yyy.zzz") }
    let(:error_message) { "No such file or directory: " + file_path }

    it "should return failure message" do
      expect(subject.call(file_path).failure?).to be_truthy
      expect(subject.call(file_path).failure.to_s).to eq error_message
    end
  end

  context 'when file exists and is readable' do
    let(:file_path)   { File.join("lib/rails/generators/multidapter/config/templates/", "multidapter.yml") }

    it "should return success with file io" do
      expect(subject.call(file_path).success?).to be_truthy
      expect(subject.call(file_path).value!).to_not be_nil
    end
  end
end
