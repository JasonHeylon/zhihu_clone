// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// question show start
var question_show_page = function(){
  if ($('body').data('controller') == "questions" && $('body').data('action') == "show") {
    var editor = new Simditor({
      textarea: $('#txtNewAnswer')
    });
  }
};

$(document).ready(question_show_page);
$(document).on('page:load', question_show_page);
// question show end

// question new start
var question_new_page = function(){
  if ($('body').data('controller') == "questions" && $('body').data('action') == "new") {
    var editor = new Simditor({
      textarea: $('#txtNewQuestion')
    });
  }
};

$(document).ready(question_new_page);
$(document).on('page:load', question_new_page);
// question new end

// question edit start
var question_edit_page = function(){
  if ($('body').data('controller') == "questions" && $('body').data('action') == "edit") {
    var editor = new Simditor({
      textarea: $('#txtNewQuestion')
    });
  }
};
$(document).ready(question_edit_page);
$(document).on('page:load', question_edit_page);
// question edit end