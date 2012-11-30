$(function () {
    var questionCategories = window.yns.questionCategories;

    window.yns.views.viewInit[window.yns.router.manageExamPapersSingleChoicesListByExam.name] = function () {
        $("a[type='changeOrderNum']").click(function () {
            $this = $(this);
            var epscId = parseInt($this.attr("epscId"));
            var orderNum = $this.next().find("input").val();
            $.ajax({
                cache: false,
                url: "/manage/exam-papers-single-choices/update-order-num",
                type: "POST",
                data: {id: epscId, order_num: orderNum },
                dataType: "json",
                success: function (data) {
                    if(data.success){
                        $this.next().next().find("span[type='orderNum']").text(data.order_num);
                        alert("修改成功");}
                    else
                        alert(data.message);
                }
            });
        });
    }
});
