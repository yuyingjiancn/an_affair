AnAffair::Application.routes.draw do

  get "/" => "student/passport#login"

  namespace :manage do
    get "passport/login" => "passport#login"
    post "passport/login" => "passport#login"

    get "passport/logout" => "passport#logout"

    get "passport/index" => "passport#index"

    get "single-choices/list/:category_id" => "single_choices#list"

    get "single-choices/create" => "single_choices#create"
    post "single-choices/create" => "single_choices#create"

    get "single-choices/edit/:id" => "single_choices#edit"
    post "single-choices/update" => "single_choices#update"

    get "single-choices/delete/:id/:category_id" => "single_choices#delete"

    post "single-choices/image-upload" => "single_choices#image_upload"

    get "exam-papers/create" => "exam_papers#create"
    post "exam-papers/create" => "exam_papers#create"

    get "exam-papers/delete/:id" => "exam_papers#delete"

    get "exam-papers/list" => "exam_papers#list"

    get "exam-papers/edit/:id" => "exam_papers#edit"
    post "exam-papers/update" => "exam_papers#update"

    post "exam-papers-single-choices/create" => "exam_papers_single_choices#create"

    get "exam-papers-single-choices/list-by-exam/:id" => "exam_papers_single_choices#list_by_exam"

    get "exam-papers-single-choices/view-result/:school_class_id/:exam_id" => "exam_papers_single_choices#view_result"

    post "exam-papers-single-choices/update-order-num" => "exam_papers_single_choices#update_order_num"

    get "exam-papers-single-choices/destroy/:id/:eid" => "exam_papers_single_choices#destroy"

    get"school-classes/list-by-exam/:exam_id" => "school_classes#list_by_exam"

    post "exam-results/destroy" => "exam_results#destroy"
  end

  namespace :student do
    get "passport/login" => "passport#login"
    post "passport/login" => "passport#login"

    get "passport/logout" => "passport#logout"

    get "exam/list" => "exam#list"
    get "exam/do-it/:id" => "exam#do_it"
    post "exam/submit-result" => "exam#submit_result"
    get "exam/view-result/:id" => "exam#view_result"

    get "exam/student-result" => "exam#student_result"
  end

end
