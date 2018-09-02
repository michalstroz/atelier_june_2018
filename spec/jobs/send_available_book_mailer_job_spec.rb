require 'rails_helper'

RSpec.describe SendAvailableBookMailerJob, type: :job do
  describe "#perform_later" do
    it "sending message to the reserver" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        SendAvailableBookMailerJob.perform_later('book')
      }.to have_enqueued_job
    end
  end
end
