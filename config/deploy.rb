
require 'capistrano/ext/multistage'

#############################################################
# Stages
##############################################################

set :stages, %w(staging production)
set :default_stage, "production"

#############################################################
# Settings
#############################################################

set :application, "parlio"
set :keep_releases, 5

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :use_sudo, false
set :scm_verbose, true

#############################################################
# Git
#############################################################

set :scm, :git
set :branch, "master"
set :scm_user, 'railsrumble'
#set :scm_passphrase, 'trouristb0x'
set :repository, "git://github.com/probono/parlio.git"
set :deploy_via, :remote_cache


#############################################################
# Servers
#############################################################

set :user, "parlio"
set :domain, "parlio.org"
server domain, :app, :web
role :db, domain, :primary => true


#############################################################
# => Passenger
#############################################################

namespace :deploy do

  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end

end

# after "deploy", :move_dev_data_to_production
# desc "Use data extracted from http://www.parlamento.euskadi.net/ in production"
# task :move_dev_data_to_production do
#   puts "Deploying to production... removing #{deploy_to}/current/public/.htaccess"
#   run "cp #{deploy_to}/current/db/development.sqlite3 #{deploy_to}/current/db/production.sqlite3 "
# end
# 
after "deploy", "deploy:update_crontab"
namespace :deploy do
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
end

#namespace :data do
#  desc "Load data from legebiltzarra"
#  task :download do
#    puts "Loading data from legebiltzarra"
#    run "cd #{deploy_to}/#{current_dir} && " +
#        "script/runner -e production script/load_parliamentarians.rb"
#    #run "cd #{deploy_to}/current && script/runner d #{deploy_to}/current/script/load_parliamentarians.rb  && script/runner script/load_comissions.rb  && script/runner script/load_parties.rb  && script/runner script/load_topics.rb && script/runner script/load_interventions.rb"
#  end
#end