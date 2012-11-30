$(function () {
    var questionCategories = window.yns.questionCategories;

    window.yns.views.viewInit[window.yns.router.manageSingleChoisesCreate.name] = function () {
        $("#questionCategoriesSelect").yRecursionSelect({data: questionCategories });

        var ue = new UE.ui.Editor();
        ue.render("qContent");
    }
});
