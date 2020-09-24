class Playlist < ActiveRecord::Base
    has_many :items, dependent: :destroy
    has_many :subscriptions, dependent: :destroy
    belongs_to :user
end
