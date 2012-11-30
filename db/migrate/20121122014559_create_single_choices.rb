class CreateSingleChoices < ActiveRecord::Migration
  def change
    create_table :single_choices do |t|
      t.text :content
      t.string :answer
      t.integer :category_id

      t.timestamps
    end
  end
end
