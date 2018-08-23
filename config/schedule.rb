# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

env :PATH, ENV['PATH']

job_type :rbenv_rake, %Q{export PATH=/home/deploy/.rbenv/shims:/home/deploy/.rbenv/bin:/usr/bin:$PATH; eval "$(rbenv init -)"; \
                         cd :path && :environment_variable=:environment :bundle_command rake :task --silent :output }

job_type :rbenv_runner, %Q{export PATH=/home/deploy/.rbenv/shims:/home/deploy/.rbenv/bin:/usr/bin:$PATH; eval "$(rbenv init -)"; \
                         cd :path && :bundle_command :runner_command -e :environment ':task' :output }

# set :output, "/home/michal/cron_log.log"


every '1 0 * * *' do
  rbenv_rake 'mail_sending:sending_mails_before', environment: 'development'
end
