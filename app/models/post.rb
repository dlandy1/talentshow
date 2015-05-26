class Post < ActiveRecord::Base
   extend FriendlyId
    friendly_id :title, use: :slugged
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, length: {minimum: 2, maximum: 45}, presence: true
  validates :kind, length: {minimum: 2, maximum: 45}, presence: true
  validates :url, :format => URI::regexp(%w(http https))


    def voters
      vote_manager = VotesManager.new(nil,self)
      voters = []
      vote_manager.voters.each do |u|
        voters.push(User.find(u).name)
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
