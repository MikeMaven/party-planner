class PartyInvite < ActiveRecord::Base
  belongs_to :party
  belongs_to :friend
end
