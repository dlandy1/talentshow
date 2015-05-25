 if Rails.env == "development"
    REDIS =Redis.new
  end
