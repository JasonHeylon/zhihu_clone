// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require module
//= require hotkeys
//= require simditor
//= require faye
//= require_tree .

window.App = { 
	user_id: ''
};


App.InitFayeClient = function(){
  var faye_client = new Faye.Client('http://localhost:9090/faye')
  faye_client.subscribe('/notifications_count/' + App.user_id, function(data){
    // alert(data["title"] + data['count']);
    $('#badgeNotification').html(data['count']);
    document.title = "您有新消息!  - 知乎clone";
  });
};

$(function(){
  App.InitFayeClient();

});