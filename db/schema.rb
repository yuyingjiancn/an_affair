# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121122020048) do

  create_table "exam_papers", :force => true do |t|
    t.string   "name"
    t.boolean  "editable"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "exam_papers_single_choices", :force => true do |t|
    t.integer  "order_num"
    t.integer  "exam_paper_id"
    t.integer  "single_choice_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "exam_papers_single_choices", ["exam_paper_id"], :name => "index_exam_papers_single_choices_on_exam_paper_id"
  add_index "exam_papers_single_choices", ["order_num"], :name => "index_exam_papers_single_choices_on_order_num"
  add_index "exam_papers_single_choices", ["single_choice_id"], :name => "index_exam_papers_single_choices_on_single_choice_id"

  create_table "exam_results", :force => true do |t|
    t.text     "result"
    t.integer  "exam_paper_id"
    t.integer  "student_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "exam_results", ["exam_paper_id"], :name => "index_exam_results_on_exam_paper_id"
  add_index "exam_results", ["student_id"], :name => "index_exam_results_on_student_id"

  create_table "managers", :force => true do |t|
    t.string   "account"
    t.string   "password"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "school_classes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "single_choices", :force => true do |t|
    t.text     "content"
    t.string   "answer"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "students", :force => true do |t|
    t.string   "number"
    t.string   "name"
    t.string   "password"
    t.integer  "school_class_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "students", ["school_class_id"], :name => "index_students_on_school_class_id"

end
