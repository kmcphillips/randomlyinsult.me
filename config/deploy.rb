## Deployment config for production
set :application, "Randomly Insult Me"
set :deploy_to, "/var/www/kevin/data/www/randomlyinsult.me"
set :user, "kevin"
set :use_sudo, false
set :keep_releases, 6

## Configure source control
set :scm, "git"
set :repository,  "git://github.com/kimos/randomlyinsult.me.git"
set :branch, "master"
set :deploy_via, :checkout
set :git_shallow_clone, 1

## Fix for requiring terminal on prod server
default_run_options[:pty] = true

## Role for production
role :web, "68.169.58.121"
role :app, "68.169.58.121"

## Tasks for deploying to Apache Passenger
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

## Symlink the production database and seed
#after "deploy", "symlink_shared_files"

task :symlink_shared_files do
  #run "ln -s #{shared_path}/log #{release_path}/log"
end

## restart the app
task :restart do
  run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
end

after "deploy:update", "deploy:cleanup"
