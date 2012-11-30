$(function () {
    window.yns.views.viewInit[window.yns.router.studentExamDoIt.name] = function () {

        //检查是否所有的题目都做完了
        var allDone = function () {
            var allDone = false;
            var notDoneArr = [];
            $("div[type='singleChoice']").each(function () {
                var epscId = parseInt($(this).attr("epscId"));
                var orderNum = parseInt($(this).attr("orderNum"));
                if($(this).find("input[name='radio_" + epscId + "']:checked").val() == undefined) {
                     notDoneArr.push(orderNum);
                }
            });
            if(notDoneArr.length == 0)
                allDone = true;
            return { done: allDone, notDoneArr: notDoneArr };
        }

        //根据学生选择生成提交到服务器的答案结果
        var generateResult = function () {
            var result = [];
            $("div[type='singleChoice']").each(function () {
                var epscId = parseInt($(this).attr("epscId"));
                var orderNum = parseInt($(this).attr("orderNum"));
                var answer = $(this).find("input[name='radio_" + epscId + "']:checked").val();
                result.push({ epscId: epscId, orderNum: orderNum, answer: answer });
            });
            return result;
        }

        //根据提交的结果和服务器返回的结果来生成学生做题的情况
        var generateAnswerInfo = function (rightResult) {
            $("div[type='singleChoice']").each(function () {
                var epscId = parseInt($(this).attr("epscId"));
                var answer = $(this).find("input[name='radio_" + epscId + "']:checked").val();
                var rightAnswer = _.find(rightResult, function(r) { return r.epscId == epscId }).answer;
                if( rightAnswer == answer){
                    $(this).append("<div style=\"color: #00F;\">恭喜您，选择正确</div>");
                }else{
                    $(this).append("<div style=\"color: #F00;\">正确答案是“" + rightAnswer + "”，您选择了“" + answer + "”</div>");
                }
            });
        }

        var generateAnswers = function (result) {
            $("div[type='singleChoice']").each(function () {
                var epscId = parseInt($(this).attr("epscId"));
                var answer = _.find(result, function(r) { return r.epscId == epscId }).answer;
                $(this).find("input:radio[name='radio_" + epscId + "'][value='" + answer + "']").attr("checked", true);
            });
            $("form").foundationCustomForms();
        }

        var submitResult = function(result, examPaperId) {
            $.ajax({
                cache: false,
                url: "/student/exam/submit-result",
                type: "POST",
                data: {
                    result: JSON.stringify(result),
                    exam_paper_id: examPaperId
                },
                dataType: 'json',
                success: function (data) {
                    if (data.success) {
                        alert("成绩已经成功上传到服务器");
                        generateAnswerInfo(data.answers);
                    } else {
                        alert(data.message);
                    }
                }
            });
        }



        $("#btnSubmit").click(function () {
            var done = allDone();
            if(!done.done){
                var message = "";
                $.each(done.notDoneArr, function (index, value) {
                   message += "“[" + value + "]”"
                });
                message += "小题还没完成，不能提交";
                alert(message);
                return;
            }
            var result = generateResult();
            submitResult(result, $("#iptExamPaperId").val());
        });

        var studentResult = function(examPaperId) {
            $.ajax({
                cache: false,
                url: "/student/exam/student-result",
                type: "GET",
                data: {
                    exam_paper_id: examPaperId
                },
                dataType: 'json',
                success: function (data) {
                    if (data.success) {
                        if(data.done) {
                            generateAnswers(eval(data.answers));
                            generateAnswerInfo(data.right_answers);
                            $("#btnSubmit").unbind();
                            $("#btnSubmit").hide();
                        }
                    } else {
                        alert(data.message);
                    }
                }
            });
        }

        studentResult($("#iptExamPaperId").val());

    }
});
