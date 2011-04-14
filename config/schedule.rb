set :output,  "/home/parlio/parlio_app/shared/log/cron.log"

every 1.day, :at => '1:00 am' do
  runner "Updater.all"
end
