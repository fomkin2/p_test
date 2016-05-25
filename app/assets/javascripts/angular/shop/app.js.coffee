'use strict'

angular.module 'shopApp', ['templates', 'ngRoute']

.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/carts',
    templateUrl: 'carts/index.html'
    controller: 'CartsController'
  ).when('/carts/confirm',
    templateUrl: 'carts/confirm.html'
    controller: 'CartConfirmController'
  ).when('/orders',
    cache: false
    templateUrl: 'orders/index.html'
    controller: 'OrdersController'
  ).when('/orders/:orderId',
    cache: false
    templateUrl: 'orders/detail.html'
    controller: 'OrderDetailController'
  )
  return
])
