class CreateExamPapers < ActiveRecord::Migration
  def change
    create_table :exam_papers do |t|
      t.string :name
      t.boolean :editable

      t.timestamps
    end
  end
end
