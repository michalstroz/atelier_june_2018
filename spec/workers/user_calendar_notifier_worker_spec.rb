require 'rails_helper'
require 'spec_helper'

RSpec.describe UserCalendarNotifierWorker, type: :worker do
  let(:user) { User.new }
  let(:book) { Book.new }

  it { is_expected.to be_retryable true }



  it "enqueues a UserCalendarNotifier" do
   UserCalendarNotifierWorker.perform_async 'UserCalendarNotifier', true
   expect(UserCalendarNotifierWorker).to have_enqueued_sidekiq_job('UserCalendarNotifier', true)
  end

  it "schedule a UserCalendarNotifier" do
    UserCalendarNotifierWorker.perform_in 2.minutes, 'UserCalendarNotifier', true
    expect(UserCalendarNotifierWorker).to have_enqueued_sidekiq_job('UserCalendarNotifier', true).in(2.minutes)
  end
end
