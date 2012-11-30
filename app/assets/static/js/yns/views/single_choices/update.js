$(function () {
    var questionCategories = window.yns.questionCategories;

    window.yns.views.viewInit[window.yns.router.manageSingleChoisesUpdate.name] = function () {
        $("#questionCategoriesSelect").yRecursionSelect2({data: questionCategories });

        var ue=new UE.ui.Editor();
        ue.render('single_choice_content');
    }
});
