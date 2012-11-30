class CreateExamPapersSingleChoices < ActiveRecord::Migration
  def change
    create_table :exam_papers_single_choices do |t|
      t.integer :order_num
      t.references :exam_paper
      t.references :single_choice

      t.timestamps
    end
    add_index :exam_papers_single_choices, :order_num
    add_index :exam_papers_single_choices, :exam_paper_id
    add_index :exam_papers_single_choices, :single_choice_id
  end
end
