class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :playlists
  has_many :subscriptions
  has_many :following_playlists, through: :subscriptions, source: :playlist
  has_many :votes
  has_many :upvoted_items, through: :votes, source: :item
end
