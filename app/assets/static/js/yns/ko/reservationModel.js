window.yns.ko.reservationModel = {};

window.yns.ko.reservationModel.QuestionCategory = function (id, name) {
    this.id = ko.observable(id);
    this.name = ko.observable(name);
}

window.yns.ko.reservationModel.HtmlQuestionCategorySelect = function (level, questionCategoryOptions) {
    this.level = ko.observable(level);
    this.questionCategoryOptions = ko.observableArray(questionCategoryOptions);
}
