require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.cron '0 8 * * *' do
  system("rake mail_sending:sending_mails_before")
end
