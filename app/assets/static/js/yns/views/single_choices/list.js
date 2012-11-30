$(function () {
    var questionCategories = window.yns.questionCategories;

    window.yns.views.viewInit[window.yns.router.manageSingleChoisesList.name] = function () {
        $("#questionCategoriesSelect").yRecursionQuerySelect({data: questionCategories });

        $("#btnGoto").click(function () {
            window.location.href = window.yns.router.manageSingleChoisesList.fullPath($("#questionCategoriesSelect input[name='ySelectedId']").val());
        });

        $("a[type='delete']").click(function (e) {
            e.preventDefault();
            if(confirm("确定删除？")){
                window.location.href = $(this).attr("href");
            }
        });

        $("a[type='addToExamPaper']").click(function () {
            var epId = $("#selExamPaper").val();
            var qId = parseInt($(this).attr("qid"));
            $.ajax({
                cache: false,
                url: "/manage/exam-papers-single-choices/create",
                type: "POST",
                data: {eid: epId, qid: qId },
                dataType: "json",
                success: function (data) {
                    if(data.success)
                        alert("添加成功");
                    else
                        alert(data.message);
                }
            });
        });
    }
});
