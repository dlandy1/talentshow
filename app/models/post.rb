class Post < ActiveRecord::Base
   extend FriendlyId
    friendly_id :title, use: :slugged
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, length: {minimum: 2, maximum: 45}, presence: true
  validates :kind, length: {minimum: 2, maximum: 45}, presence: true
  validates :url, :format => URI::regexp(%w(http https))
end
