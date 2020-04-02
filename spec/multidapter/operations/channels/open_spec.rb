# frozen_string_literal: true
require "spec_helper"

RSpec.describe Multidapter::Operations::Channels::Open do

  let(:channel_id)          { :user_enrollments }
  let(:channel_item)        { { subscribe: { summary: 'A customer enrolled' } } }
  let(:channel_instance)    { Multidapter::Operations::Channels::Create.call({channel_id: channel_id, channel_item: channel_item}) }

  describe '#call' do
    it "should do something useful"
  end

end
