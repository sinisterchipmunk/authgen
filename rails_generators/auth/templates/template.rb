def read_tempfile(path)
  File.read(File.join(File.dirname(__FILE__), "tmp", ".#{path}"))
end

# gem dependencies: authlogic and declarative_authorization
gem 'authlogic'
gem 'declarative_authorization'

# Add methods and configuration to ActionController
lines = File.read(File.join(RAILS_ROOT, "app/controllers/application_controller.rb")).to_a
File.open(File.join(RAILS_ROOT, "app/controllers/application_controller.rb"), "w") do |fi|
  lines.each do |line|
    fi.puts line
    if line[/class(\s+)ApplicationController/]
      fi.puts read_tempfile("application_controller_methods.rb")
    end
  end
end

# routes: /users, /account, /user_session, /login, /logout
route 'map.resource :user_session'
route 'map.resource :account, :controller => "users"'
route 'map.resources :users'
route 'map.login "login", :controller => "user_sessions", :action => "new"'
route 'map.logout "logout", :controller => "user_sessions", :action => "destroy"'
route 'map.register "register", :controller => "users", :action => "new"'

# run migrations
if yes?("Run migrations?")
  rake "db:migrate"

  # seeds: add roles to DB
  File.open(File.join(RAILS_ROOT, "db/seeds.rb"), "a") do |f|
    f.puts "require File.join(File.dirname(__FILE__), '/seeds/auth')"
  end

  # seed the DB
  if yes?("Seed the database?")
    rake "db:seed"
  end
end
