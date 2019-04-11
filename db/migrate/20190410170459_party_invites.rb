class PartyInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :party_invites do |t|
      t.belongs_to :party
      t.belongs_to :friend
      t.boolean :attending, default: false

      t.timestamps null: false
    end
  end
end
