class VotesManager

  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def vote!
    REDIS.multi do
       REDIS.incr post_vote_key
       REDIS.sadd post_voters_key, user.id
    end
    true
  end

  def remove_vote!
    REDIS.multi do
      REDIS.decr post_vote_key
      REDIS.srem post_voters_key, user.id
    end
    true
  end

  def already_voted?
    REDIS.sismember post_voters_key, user.id
  end

  def votes_count
     REDIS.get(post_vote_key).to_i
  end

  def voters
    REDIS.smembers(post_voters_key)
  end

  def post_vote_key
    "post:#{post.id}:votes"
  end

  def post_voters_key
    "post:#{post.id}:voters"
  end


end