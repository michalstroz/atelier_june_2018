require 'rails_helper'

RSpec.describe BookReservationExpireJobJob, type: :job do
  describe "#perform_later" do
    it "book reservation expire reminder" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        BookReservationExpireJobJob.set(wait_until: Date.tomorrow.to_s).perform_later('book')
      }.to have_enqueued_job.with('book').at(Date.tomorrow.to_s)
    end
  end
end
