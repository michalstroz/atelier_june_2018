require 'rails_helper'

RSpec.describe BorrowBookMailerJob, type: :job do
  describe "#perform_later" do
    it "sending message after taking the book" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        BorrowBookMailerJob.perform_later('book', 'user')
      }.to have_enqueued_job
    end
  end
end
