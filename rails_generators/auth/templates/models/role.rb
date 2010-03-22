class Role < ActiveRecord::Base
  has_many :user_roles, :dependent => :destroy
  has_many :users, :through => :user_roles

  validates_presence_of :name, :caption
  validates_uniqueness_of :name, :caption
end
