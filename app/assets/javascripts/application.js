// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require jquery-tablesorter
//= require popper
//= require toastr
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

$(document).on("turbolinks:load",function(){
  // 用jquery 實作點擊事件
  $("tr[data-link]").on('click', function(){
    window.location = $(this).data("link");
  });

  $("div[data-link]").on('click', function(){
    window.location = $(this).data("link");
  });

  // 用jquery plugin - tablesorter 做排序
  $("#myTable").tablesorter( { 
    theme : "bootstrap",

    headerTemplate : "{content}{icon}",

    selectorHeaders: 'thead th.sortable'
  } );
});