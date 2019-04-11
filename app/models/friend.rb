class Friend < ActiveRecord::Base
  has_many :party_invites
  has_many :parties, through: :party_invites
  validates :first_name, presence: true
  validates :last_name, presence: true
  def name
    [first_name, last_name].join(' ')
  end
end
