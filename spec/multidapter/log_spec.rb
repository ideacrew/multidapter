# # frozen_string_literal: true

# require "spec_helper"

# RSpec.describe Multidapter::Log do

#   context "Given logging is enabled" do
#     before { Logger.level = :debug }

#     it 'should be able to read a log message' do

#       Logger.debug "foo bar"
#       Logger.warn  "just a little warning"

#       expect(@log_output.readline).to eq "  DEBUG  multidapter : foo bar\n"
#       expect(@log_output.readline).to eq "   WARN  multidapter : just a little warning\n"
#     end

#     context "and output is set to :info level" do
#       before { Logger.level = :info }

#       it "debug level message shouldn't be logged" do
#         expect(Logger.debug("this debug message will not be output by the logger")).to be_falsey
#       end

#       it ":info level and above messages should be logged" do
#         expect(Logger.info("info level messages should be output by the logger")).to be_truthy
#         expect(Logger.trace("trace level messages should be output by the logger")).to be_truthy
#         expect(Logger.warn("warn level messages should be output by the logger")).to be_truthy
#         expect(Logger.error("error level messages should be output by the logger")).to be_truthy
#         expect(Logger.fatal("fatal level messages should be output by the logger")).to be_truthy
#       end
#     end

#   end




# # before(:each) do
# #   @test_obj = Object.new
# #   @test_obj.extend(Multidapter::Log)
# # end

# # let(:trace_logger)  { logger.trace  { "Dispatching message (#{LogText.message_data(message_data)})" } }
# # let(:info_logger)   { logger.info   { "Message dispatched (#{LogText.message_data(message_data)})" } }

# # context "submitting a log message" do
# #   it "creates a log message" do
# #     expect(@test_obj.logger.trace { "Take one for the gipper" })
# #   end
# # end

# end
