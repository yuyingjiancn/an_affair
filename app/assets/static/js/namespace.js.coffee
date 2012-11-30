window.yns = {
  router: {
    manageSingleChoisesCreate : { name: "manageSingleChoisesCreate", onlyPath: ///^/manage/single-choices/create$///, fullPath: -> "/manage/single-choices/create" }
    manageSingleChoisesList: { name: "manageSingleChoisesList", onlyPath: ////manage/single-choices/list/\d{1}///, fullPath: (c_id) -> "/manage/single-choices/list/" + c_id }
    manageSingleChoisesDelete: { name: "manageSingleChoisesDelete", onlyPath: ////manage/single-choices/list/\d{1}/\d{1}///, fullPath: (id, c_id) -> "/manage/single-choices/delete/" + id + "/" + c_id }
    manageSingleChoisesEdit: { name: "manageSingleChoisesEdit", onlyPath: ////manage/single-choices/edit/\d{1}///, fullPath: (id) -> "/manage/single-choices/edit/" + id }
    manageSingleChoisesUpdate: { name: "manageSingleChoisesUpdate", onlyPath: ////manage/single-choices/update///, fullPath: -> "/manage/single-choices/update" }
    manageExamPapersList: { name: "manageExamPapersList", onlyPath: ////manage/exam-papers/list///, fullPath: -> "/manage/exam-papers/list" }
    manageExamPapersSingleChoicesListByExam: { name: "manageExamPapersSingleChoicesListByExam", onlyPath: ////manage/exam-papers-single-choices/list-by-exam/\d{1}///, fullPath: (id) -> "/manage/exam-papers-single-choices/list-by-exam/" + id }
    manageExamPapersSingleChoicesViewResult: { name: "manageExamPapersSingleChoicesViewResult", onlyPath: ////manage/exam-papers-single-choices/view-result/\d{1}/\d{1}///, fullPath: (sid, eid) -> "/manage/exam-papers-single-choices/list-by-exam/" + sid + "/" + eid }
    studentExamDoIt: { name: "studentExamDoIt", onlyPath: ////student/exam/do-it/\d{1}///, fullPath: (id) -> "/student/exam/do-it/" + id }
    studentExamViewResult: { name: "studentExamViewResult", onlyPath: ////student/exam/view-result/\d{1}///, fullPath: (id) -> "/student/exam/view-result/" + id }
  }
  currentOnlyPath: window.currentOnlyPath
  questionCategories: window.questionCategories
}
