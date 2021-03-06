class Admin < ActiveRecord::Base
  
  acts_as_taggable
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :login
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :login, :username, :password_confirmation, :remember_me

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", {:value => login.strip.downcase}]).first
  end

end
