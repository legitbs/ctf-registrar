class Reset < ActiveRecord::Base
  belongs_to :user

  include BCrypt

  before_create :set_keys

  EXPIRATION = 2.hours

  scope :live, -> { not_expired.where(consumed_at: nil, 
                                      disavowed_at: nil) }
  scope :expired, -> { where('created_at < ?', EXPIRATION.ago) }
  scope :not_expired, -> { where('created_at >= ?', EXPIRATION.ago) }

  def token
    key.chars.zip(@secret.chars).join
  end

  def self.find_by_token(token_string)
    begin
      key, secret = token_string.chars.each_slice(2).to_a.transpose.map(&:join)
      candidate = self.live.where(key: key).first
    rescue
      return nil
    end

    return nil unless candidate && (candidate.secret == secret)
    
    return candidate
  end

  def secret
    Password.new self.digest
  end

  def self.change_password!(token, password, password_confirm)
    reset = find_by_token token
    reset.change_password! password, password_confirm
  end

  def change_password!(password, password_confirm)
    raise "Expired" if expired?
    user.password = password
    user.password_confirmation = password_confirm
    user.save!
      
    self.consumed_at = Time.now
    self.save
  end

  def expired?
    created_at < EXPIRATION.ago
  end

  private
  def set_keys
    self.key = random_dingus
    @secret = random_dingus
    self.digest = Password.create @secret, cost: 7
  end

  def random_dingus
    extender = 36 ** 25
    random = SecureRandom.random_number(36**24)
    (extender + random).to_s(36)
  end
end
