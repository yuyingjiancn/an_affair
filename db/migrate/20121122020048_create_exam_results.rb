class CreateExamResults < ActiveRecord::Migration
  def change
    create_table :exam_results do |t|
      t.text :result
      t.references :exam_paper
      t.references :student

      t.timestamps
    end
    add_index :exam_results, :exam_paper_id
    add_index :exam_results, :student_id
  end
end
