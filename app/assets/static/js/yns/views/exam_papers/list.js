$(function () {
    window.yns.views.viewInit[window.yns.router.manageExamPapersList.name] = function () {
        $("a[type='delete']").click(function (e) {
            e.preventDefault();
            if(confirm("确定删除？")){
                window.location.href = $(this).attr("href");
            }
        });
    }
});
