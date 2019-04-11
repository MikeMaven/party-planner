class CreateParties < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :location, null: false
    end
  end
end
