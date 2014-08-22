class User < ActiveRecord::Base
  has_secure_password

  validates :username, uniqueness: true
  validates :email, uniqueness: true, format: { with: /[a-zA-Z\d._%+-]+@[a-zA-Z\d.-]+\.[a-zA-Z]{2,4}/ }
  validates :password, length: { minimum: 8 }

  has_many :playlists
  has_many :tracks, through: :playlists
end
