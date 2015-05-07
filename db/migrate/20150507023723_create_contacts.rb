class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.integer :nbuilder_person_id, null: false

      t.timestamps null: false
    end
  end
end
