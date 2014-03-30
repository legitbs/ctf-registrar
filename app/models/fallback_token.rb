class FallbackToken < ActiveRecord::Base
  belongs_to :user
  
  before_create :assign_key_and_secret
  
  def as_token_string
    [key, @secret].join('-')
  end
  
  def self.find_by_token_string(token_string)
    key, secret = token_string.split('-')
    
    candidate = find_by key: key

    return nil unless candidate

    return nil unless BCrypt::Password.new(candidate.secret_digest) == secret

    return candidate
  end

  private
  def assign_key_and_secret
    self.key = slug
    @secret = slug

    self.secret_digest = BCrypt::Password.create @secret, cost: 7
  end

  def slug
    SecureRandom.random_number(36**10).to_s(36)
  end
end
