class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.string :account
      t.string :password

      t.timestamps
    end
  end
end
