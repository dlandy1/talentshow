class Post < ActiveRecord::Base
   extend FriendlyId
    friendly_id :title, use: :slugged
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, length: {minimum: 2, maximum: 45}, presence: true
  validates :kind, length: {minimum: 2, maximum: 45}, presence: true
  validates :url, :format => URI::regexp(%w(http https))

    friendly_id :slug_candidates, use: :slugged

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :slug, uniqueness: true

  auto_html_for :url do
    html_escape
    image
    soundcloud width: "100%"
    youtube width: "100%", height: 430
    vimeo width: "100%", height: 430
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

  def slug_candidates
    [:title, [:title, :id_for_slug]]
  end

  def id_for_slug
    generated_slug = normalize_friendly_id(title)
    things = self.class.where('slug REGEXP :pattern', pattern: "#{generated_slug}(-[0-9]+)?$")
    things = things.where.not(id: id) unless new_record?
    things.count + 1
  end

  def should_generate_new_friendly_id?
    title_changed? || super
  end


    def voters
      vote_manager = VotesManager.new(nil,self)
      voters = []
      vote_manager.voters.each do |u|
        voters.push(User.find(u) )
      end
      return voters
    end

    def vote!(voting_user)
      vote_manager = VotesManager.new(voting_user, self)
      vote_manager.vote! 
      update_rank
    end

    def remove_vote!(voting_user)
      vote_manager = VotesManager.new(voting_user, self)
      vote_manager.remove_vote!
      update_rank
    end


    def already_voted?(voting_user)
      vote_manager = VotesManager.new(voting_user, self)
      vote_manager.already_voted?
    end

    def points
      vote_manager = VotesManager.new(nil, self)
      vote_manager.votes_count
    end

    def update_rank
       new_rank = self.points
   
       update_attribute(:rank, new_rank)
   end

end
