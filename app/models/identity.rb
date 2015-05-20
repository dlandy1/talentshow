class Identity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_for_oauth(auth)
    find_or_create_by(uid: auth.uid, provider: auth.provider)
  end
    def largeimage
    "http://graph.facebook.com/#{self.uid}/picture?type=large"
  end
   
  def normalimage
    "http://graph.facebook.com/#{self.uid}/picture?type=normal"
  end

  def smallimage
    "http://graph.facebook.com/#{self.uid}/picture?type=small"
  end
end
