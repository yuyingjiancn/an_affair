$(function () {
    var questionCategories = window.yns.questionCategories;

    window.yns.views.viewInit[window.yns.router.manageSingleChoisesEdit.name] = function () {
        $("#questionCategoriesSelect").yRecursionSelect2({data: questionCategories });
        $("#single_choice_content").text($("#single_choice_content").text().replace("\\\\","\\"));
        var ue=new UE.ui.Editor();
        ue.render('single_choice_content');
    }
});
