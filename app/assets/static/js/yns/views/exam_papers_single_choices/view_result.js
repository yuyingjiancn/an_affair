$(function () {
    window.yns.views.viewInit[window.yns.router.manageExamPapersSingleChoicesViewResult.name] = function () {
        var rightAnswers = _.sortBy(rightAnswersServer, function(a) { return a.orderNum });
        var rightAnswersHash = {};
        _.each(rightAnswers, function(item) {
            rightAnswersHash[item.epscId] = {answer: item.answer, right: 0, wrong: 0};
        });


        var studentsAnswers = _.map(_.sortBy(studentsAnswersServer, function (s) { return s.studentNumber }), function (a) {
           var result = eval(a.result);
           result = _.map(result, function (r) {
               r.right = r.answer == rightAnswersHash[r.epscId].answer;
               return r;
           });
            var countBy = _.countBy(result, function(item){
              return item.right ? "right" : "wrong";
            });

            var score = 0;
            if(countBy.right){
                score = (countBy.right / result.length * 100 ).toFixed(2);
            }

           return { examResultId: a.examResultId, studentNumber: a.studentNumber, studentName: a.studentName, result: result, score: score };
        });

        _.each(studentsAnswers, function(s) {
            var result = s.result;
            _.each(result, function(r) {
                r.right ? rightAnswersHash[r.epscId].right ++ : rightAnswersHash[r.epscId].wrong ++;
            });
        });

        _.each(rightAnswers, function(ra) {
           ra.averageScore = (rightAnswersHash[ra.epscId].right / (rightAnswersHash[ra.epscId].right + rightAnswersHash[ra.epscId].wrong) * 100).toFixed(2);
        });

        var studentsAverageScore =
            (_.reduce(studentsAnswers, function (memo, s) {return memo + parseFloat(s.score) }, 0) / studentsAnswers.length).toFixed(2);

        var RightAnswersViewModel = function () {
            this.rightAnswers = rightAnswers;
            this.studentsAverageScore = studentsAverageScore;
        }

        var AnswersViewModel = function () {
            this.studentsAnswers = ko.observableArray([]);
        }





        var rightAnswersViewModel = new RightAnswersViewModel();
        var answersViewModel = new AnswersViewModel();
        ko.applyBindings(rightAnswersViewModel, $("#resultTHead")[0]);
        ko.applyBindings(rightAnswersViewModel, $("#resultTFoot")[0]);
        ko.applyBindings(answersViewModel, $("#resultTBody")[0]);

        _.each(studentsAnswers, function (s) {
            answersViewModel.studentsAnswers.push(s);
        });

        var sortByScoreStudentsAnswers = _.sortBy(studentsAnswers, function(item){ return item.score });
        var sortByNumberStudentsAnswers = _.sortBy(studentsAnswers, function(item){ return item.studentNumer });

        var numberReverse = 1;

        $("#sortByNumber").click(function () {
            numberReverse = -numberReverse;
            answersViewModel.studentsAnswers.sort(function (left, right) {
                return left.studentNumber.toString() == right.studentNumber.toString() ? 0 : ((left.studentNumber.toString() > right.studentNumber.toString()) ? numberReverse : -numberReverse);
            });
        });

        var scoreReverse = 1;

        $("#sortByScore").click(function(){
            scoreReverse = -scoreReverse;
            answersViewModel.studentsAnswers.sort(function (left, right) {
                return parseFloat(left.score) == parseFloat(right.score) ? 0 : ((parseFloat(left.score) > parseFloat(right.score)) ? -scoreReverse : scoreReverse);
            });
        });

        $("a[type='delete']").click(function () {
            var erId = parseInt($(this).attr("erId"));
            if(confirm("您确定要删除？")){
                $.ajax({
                    cache: false,
                    url: "/manage/exam-results/destroy",
                    type: "POST",
                    data: {id: erId },
                    dataType: "json",
                    success: function (data) {
                        if(data.success){
                            answersViewModel.studentsAnswers.remove(function(e) {return e.examResultId == erId });
                            alert("删除成功！");}
                        else
                            alert(data.message);
                    }
                });
            }else{
                alert("取消删除");
            }

        });
    }
});
