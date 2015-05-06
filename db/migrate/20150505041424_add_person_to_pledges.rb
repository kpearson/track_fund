class AddPersonToPledges < ActiveRecord::Migration
  def up
    change_table :pledges do |t|
      t.remove  :user_id
      t.integer :nbuilder_event_id
      t.integer :nbuilder_person_id
      t.string  :name
      t.boolean :fulfilled, null: false, default: false
      t.remove :amount
      t.decimal :amount, precision: 10, scale: 2
    end
  end

  def down
    change_table :pledges do |t|
      t.remove :amount
      t.string :amount
      t.remove :fulfilled
      t.remove :name
      t.remove :nbuilder_person_id
      t.remove :nbuilder_event_id
      t.references :user, index: true, foreign_key: true
    end
  end
end
