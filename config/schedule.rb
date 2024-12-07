require File.expand_path(File.dirname(__FILE__) + "/environment")  # rootパス取得
rails_env = ENV['RAILS_ENV'] || :development # cronを実行する環境変数(:development, :product, :test)
set :environment, rails_env # cronを実行する環境変数をセット
set :output, "#{Rails.root}/log/cron.log"

# Learn more: http://github.com/javan/whenever
every 1.day, at: '8:00 am' do
  rake '-s sitemap:refresh'
end

every 1.day, at: '12:00 am' do
  rake "db_cleanup:delete_open_ai_days"
end
