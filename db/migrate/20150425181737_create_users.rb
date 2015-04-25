class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :first_name
      t.string :gender
      t.string :last_name
      t.string :link
      t.string :locale
      t.string :name
      t.string :token

      t.timestamps null: false
    end
  end
end
