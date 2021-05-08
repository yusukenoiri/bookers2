# class DailyMailer < ApplicationMailer
#   def daily_mail(user)
#     require "date"
#     # Dateクラスを使うにはまずプログラムファイルの中で次の一文を記述
#     @time_now = DateTime.now
#     # Dataクラスのオブジェクトを作る
#     @user = user
#     mail to: @user.email, subject: 'Daily Mail'
# #   end
# # end


class DailyMailer < ApplicationMailer

  def daily_mail
    mail(bcc: User.pluck(:email), subject: 'Daily Mail!')
    # mailメソッドで件名と宛先を指定, mail(to: 宛先, subject: '件名')
  end
end

# 1. Gemfile追加
# gem 'whenever', require: false

# 2. ターミナル実行
# bundle install

# 3. wheneverize .
# 上のコマンドを実行すると、「config/schedule.rb」というファイルが作成される

# 4. app/mailers/'実行したいメソッドを記載'.rbを作成
# この中に実行したいメソッドを記載する、このファイルは5番で使用するbatch file用

# 5. lib/batch/'実行したいバッチ処理を記載'.rbを作成
# class Batch: :4のfile名と記載し、メソッドを継承する
# ここに定期実行したいタスク・バッチの設定する
# ここに書き込んでいる内容がscheduleで、実行されるようになる

# 6. viewのフォルダ内にメソットと同義のfileを作成
# 今回の場合は'daily_mail.html.erb'
# このfileが定期文として送信される

# 7. config/application.rb内の設定変更
# ①追加する：config.autoload_paths += %W(#{config.root}/lib)
# libはRailsで自動的にロードされないので、config/application.rbに追記してあげる必要がある

# ②追加する：config.paths.add 'lib', eager_load: true
# lib/batchファイルが読み込まれるようconfig/application.rbを編集する必要がある

# 8. config/schedule.rbの編集
# 実行したいmethodをrunnerに続けて記載
# 簡単な例文
# every 1.day, at: '1:30 am' do
  # runner "Batch::Daily.new.mail"
# end

# 9. cronにscheduleの中身を記載する
# 以下のコードを実行しcronに中身を記載する
# bundle exec whenever --update-crontab
# [write] crontab file updatedと出力されればOK
# sudo systemctl start crondを実行すると開始される

# 10. 補足
# sudo systemctl stop crond：実行をとめる
# crontab -l：cronに反映されているか確認できる
# bundle exec rails runner Batch::'batch名'.batch内のmethod名：処理実行できるか確認できる

