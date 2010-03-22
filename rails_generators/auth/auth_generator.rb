class AuthGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      BASEDIRS.each { |dir| m.directory dir }

      # seeds
      m.file "seeds.rb",                                       "db/seeds/auth.rb"
      # controllers
      m.file "controllers/users_controller.rb",                "app/controllers/users_controller.rb"
      m.file "controllers/user_sessions_controller.rb",        "app/controllers/user_sessions_controller.rb"
      # helpers
      m.file "helpers/users_helper.rb",                        "app/helpers/users_helper.rb"
      m.file "helpers/user_sessions_helper.rb",                "app/helpers/user_sessions_helper.rb"
      # models
      m.file "models/role.rb",                                 "app/models/role.rb"
      m.file "models/user.rb",                                 "app/models/user.rb"
      m.file "models/user_role.rb",                            "app/models/user_role.rb"
      m.file "models/user_session.rb",                         "app/models/user_session.rb"
      # views
      m.file "views/layouts/users.html.erb",                   "app/views/layouts/users.html.erb"
      m.file "views/users/_form.html.erb",                     "app/views/users/_form.html.erb"
      m.file "views/users/edit.html.erb",                      "app/views/users/edit.html.erb"
      m.file "views/users/new.html.erb",                       "app/views/users/new.html.erb"
      m.file "views/users/show.html.erb",                      "app/views/users/show.html.erb"
      m.file "views/user_sessions/new.html.erb",               "app/views/user_sessions/new.html.erb"
      # migrations
      m.file "migrations/20100322142300_create_users.rb",      "db/migrate/20100322142300_create_users.rb"
      m.file "migrations/20100322161150_create_roles.rb",      "db/migrate/20100322161150_create_roles.rb"
      m.file "migrations/20100322161209_create_user_roles.rb", "db/migrate/20100322161209_create_user_roles.rb"
      # authorization rules
      m.file "authorization_rules.rb",                         "config/authorization_rules.rb"
      # temp files, to be removed during cleanup
      m.file "controllers/application_controller.rb",          "tmp/.application_controller_methods.rb"
    end
  end

  def after_generate
    fi = File.join(File.dirname(__FILE__), 'templates/template.rb')
    system("rake", "rails:template", "LOCATION=#{fi}")
    system("rm", "tmp/.application_controller_methods.rb")
  end

  BASEDIRS = %w(
    app/controllers
    app/helpers
    app/models
    app/views/users
    app/views/user_sessions
    db/migrate
    db/seeds
    config
  )

  protected
    def banner
      <<-EOS
Creates a ...

USAGE: #{$0} #{spec.name} name
EOS
    end
end