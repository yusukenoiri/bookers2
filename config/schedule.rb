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

# 失敗例：1
# # Rails.rootを使用するために必要。なぜなら、wheneverは読み込まれるときにrailsを起動する必要がある
# require File.expand_path(File.dirname(__FILE__) + "/environment")
# # cronを実行する環境変数
# rails_env = Rails.env.to_sym
# # cronを実行する環境変数をセット
# set :environment, rails_env
# # cronのログの吐き出し場所。ここでエラー内容を確認する
# set :output, 'log/cron.log'
# # set :output, "#{Rails.root}/log/cron.log"

# # 24時間ごとに実行する
# # every 1.days, at: '0:00 am'
# every 1.minutes do
#   rake 'daily_mail:send_mail'
# end
# 失敗例：1 ここまで

require File.expand_path(File.dirname(__FILE__) + "/environment")
# File.expand_path('相対パス', __FILE__)__FILE__は、現在のソースファイル名を返す変数
# 現在のソースファイルを起点にするという意味？？
rails_env = Rails.env.to_sym
# Rails.envで現在の状態を確認し、文字列オブジェクト.to_symで文字列オブジェクトをシンボルに変換する
# to_symメソッドは文字列オブジェクトをシンボルに変換するメソッドのこと
# 文字列よりシンボルの方が高速に処理される特徴がある
set :environment, rails_env
# environmentをシンボルにしてsetするの？？
set :output, 'log/cron.log'
every 1.minute do
  begin
    runner "Batch::Daily.new.mail"
  rescue => e
    Rails.logger.error("aborted rails runner")
    raise e
  end
end

every 1.minutes do
  runner "Book.create_test"
end
# 簡単な例文
# every 1.day, at: '1:30 am' do
  # runner "Runner.task"
# end

