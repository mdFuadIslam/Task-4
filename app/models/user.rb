class User < ApplicationRecord
  # Add this validation to your User model
  #default_scope -> { where(status: 'active') }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
end
