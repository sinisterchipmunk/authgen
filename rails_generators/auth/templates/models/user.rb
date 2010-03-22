class User < ActiveRecord::Base
  acts_as_authentic
  has_many :user_roles, :dependent => :destroy
  has_many :roles, :through => :user_roles

  def role_symbols
    roles.all.collect { |r| r.name.to_sym }
  end
end
