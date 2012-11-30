class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :number
      t.string :name
      t.string :password
      t.references :school_class

      t.timestamps
    end
    add_index :students, :school_class_id
  end
end
