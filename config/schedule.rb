# Use this file to easily define all of your cron jobs.

every :thursday, :at => '6am' do
   rake "administration:update_reminder", :environment => 'devutility' 
end

every :friday, :at => '5am' do
	rake "administration:settask_reminder", :environment => "devutility"
end

every :monday, :at => '1:30am' do
	rake "administration:submit_report", :environment => "devutility"
end