class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :post, presence: true
  validates :body, presence: true
  has_many :subcomments, :class_name => "Comment", :foreign_key => "parent_id", :dependent => :destroy
  belongs_to :parent_comment, :class_name => "Comment", :foreign_key => "parent_id"

  scope :parent_comments, -> { where(parent_id: nil)}
  scope :children, -> {where("parent_id IS NOT NULL")}
end
