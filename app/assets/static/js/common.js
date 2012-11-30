//= require js/json2

//= require js/knockout-2.2.0
//= require js/jquery-1.8.2

//= require js/jquery_ujs

//= require js/underscore-1.4.2.js

//= require js/yyj-custom

//= require foundation-3.2.2/javascripts/jquery.foundation.mediaQueryToggle
//= require foundation-3.2.2/javascripts/jquery.foundation.forms
//= require foundation-3.2.2/javascripts/jquery.foundation.reveal
//= require foundation-3.2.2/javascripts/jquery.foundation.orbit
//= require foundation-3.2.2/javascripts/jquery.foundation.navigation
//= require foundation-3.2.2/javascripts/jquery.foundation.buttons
//= require foundation-3.2.2/javascripts/jquery.foundation.tabs
//= require foundation-3.2.2/javascripts/jquery.foundation.tooltips
//= require foundation-3.2.2/javascripts/jquery.foundation.accordion
//= require foundation-3.2.2/javascripts/jquery.placeholder
//= require foundation-3.2.2/javascripts/jquery.foundation.alerts
//= require foundation-3.2.2/javascripts/jquery.foundation.topbar
//= require foundation-3.2.2/javascripts/jquery.foundation.joyride
//= require foundation-3.2.2/javascripts/jquery.foundation.clearing
//= require foundation-3.2.2/javascripts/jquery.foundation.magellan
//= require foundation-3.2.2/javascripts/app

//= require js/base

//= require js/namespace
//= require js/yns/validations/init

//= require js/yns/ko/init
//= require js/yns/ko/reservationModel
//= require js/yns/ko/reservationViewModel

//= require js/yns/views/init
//= require js/yns/views/single_choices/create
//= require js/yns/views/single_choices/edit
//= require js/yns/views/single_choices/update
//= require js/yns/views/single_choices/list

//= require js/yns/views/exam_papers/list

//= require js/yns/views/exam_papers_single_choices/list_by_exam
//= require js/yns/views/exam_papers_single_choices/view_result

//= require js/yns/views/student/exam/do_it
//= require js/yns/views/student/exam/view_result

$(function () {
    $("a[href='#']").click(function(e){e.preventDefault()});
    var route = _.find(window.yns.router, function (r) { return r.onlyPath.test(window.yns.currentOnlyPath) });
    if(route) {
        if(yns.views.viewInit[route.name]){
            yns.views.viewInit[route.name]();
        }
    }

});