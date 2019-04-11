class Party < ActiveRecord::Base
  has_many :party_invites
  has_many :friends, through: :party_invites
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 20 }
  validates :location, presence: true
end
