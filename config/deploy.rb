#############################################################
# Application
#############################################################

set :application, "blog_rb"
set :repository,  "git@github.com:robu/blog.rb.git"

#############################################################
# Settings
#############################################################

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

#############################################################
# Servers
#############################################################

set :user, "robert"
server "rofa.cygni.se", :app, :web, :db, :primary => true

#############################################################
# Version Control
#############################################################

set :scm, :git
set :scm_username, "robu"
set :git_enable_submodules, 1

#############################################################
# Passenger
#############################################################

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

