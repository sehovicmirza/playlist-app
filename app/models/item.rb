class Item < ActiveRecord::Base
  before_save :default_values
  belongs_to :playlist
  has_many :votes, dependent: :destroy
  scope :ordered_by_votes, -> { order(rank: :desc, created_at: :asc) }
  
  # TODO: Extract constant values to separate file
  YT_LINK_FORMAT = /\Ahttp(?:s?):\/\/(?:www\.)?youtu(?:be\.com\/watch\?v=|\.be\/)([\w\-\_]*)(&(amp;)?‌​[\w\?‌​=]*)?\z/

  validates :ytlink, presence: true, format: YT_LINK_FORMAT

  def uid
    ytlink.match(YT_LINK_FORMAT)[1]
  end

  private
  def default_values
    self.rank ||= 0
  end
end
