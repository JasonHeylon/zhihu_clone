// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var question_show_page = function(){
  if ($('body').data('controller') == "questions" && $('body').data('action') == "show") {
    var editor = new Simditor({
      textarea: $('#txtNewAnswer')
    });

  }
};

$(document).ready(question_show_page);
$(document).on('page:load', question_show_page);
