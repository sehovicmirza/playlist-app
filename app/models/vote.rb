class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  validates :item, uniqueness: { scope: :user, message: "User can vote only once per item." }
end
