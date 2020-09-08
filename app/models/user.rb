class User < ActiveRecord::Base
  has_many :user_playlists
  has_many :playlists, through: :user_playlists
end
