class User <ApplicationRecord 
  validates_presence_of :email, uniqueness: true, presence: true
  validates_presence_of :name, presence: true
  validates_presence_of :password 
  validates_presence_of :password_confirmation
  validates_confirmation_of :password
  validates_uniqueness_of :email
  has_many :viewing_parties

  has_secure_password
end 