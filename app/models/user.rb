class User < ActiveRecord::Base
  belongs_to :team
  has_one :owned_team, class_name: 'Team'
  attr_accessible :username, :email, :email_confirmation
  attr_accessible :password, :password_confirmation
  
  has_secure_password

  validates :username, :email, presence: true, uniqueness: true
  validates(:email, confirmation: true, 
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
      message: "doesn't look like an email address"
    })
  validate :owned_team_and_team_must_match

  def owner?
    participant? && (owned_team == team)
  end

  def participant?
    team && team.is_a?(Team) && team.persisted?
  end
  
  private
  def owned_team_and_team_must_match
    return unless owner?
    return if owned_team == team
    errors.add :owned_team, "must be the same as the participant team"
  end
end
