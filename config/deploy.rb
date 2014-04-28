set :application, "flappy"
set :scm, "git"
set :repository, "https://github.com/uldza/flappy-bird-reborn.git"
set :branch, "master"
set :deploy_to, "/home/uldza/apps/flappy"
set :deploy_via, :remote_cache
set :copy_strategy, :checkout
set :keep_releases, 5
set :use_sudo, false
set :copy_compression, :bz2
set :normalize_asset_timestamps, false
set :document_root, "/home/uldza/apps/flappy"
set :ssh_options, {:forward_agent => true}
set :user, "deploy"
 
role :app, "192.165.67.169"
 
namespace :deploy do
    task :start, :roles => :app do
        run "sudo restart #{application} || sudo start #{application}"
    end
 
    task :stop, :roles => :app do
        run "sudo stop #{application}"
    end
 
    task :restart, :roles => :app do
        start
    end
 
    task :npm_install, :roles => :app do
        run "cd #{release_path} && npm install"
    end
end
 
after "deploy:update", "deploy:cleanup"
after "deploy:update_code", "deploy:npm_install"
