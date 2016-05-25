# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap/transition
#= require twitter/bootstrap/alert
#= require twitter/bootstrap/modal
#= require twitter/bootstrap/button
#= require twitter/bootstrap/collapse
#= require twitter/bootstrap
#= require bootstrap
#= require angular
#= require angular-route
#= require angular-rails-templates
#= require angular/shop/app
#= require angular/shop/controllers
#= require angular/shop/services
#= require angular/shop/filters
#= require_tree ./templates

$(document).ready ->
  if window.location.href.indexOf('#/') != -1
    $('#shopApp').modal('show')
