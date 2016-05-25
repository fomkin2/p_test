'use strict'

angular.module 'shopApp'

.controller('ProductController', [
  '$rootScope', '$scope', '$element', '$http',
  ($rootScope, $scope, $element, $http) ->
    $scope.addToCart = ($event) ->
      productId = angular.element($event.target).data('product-id')
      $http.post('/carts.json', cart: {
        product_id:productId, number:$scope.product.number
      }).then( ->
        $rootScope.$broadcast('cartsUpdate')
        $('#cartAdded').modal('show')
      )
      return
    $scope.numberChange = ->
      unless $scope.product.number.toString().match /^\d*$/
        $scope.product.number = lastNumber
      lastNumber = $scope.product.number
    $scope.reduce = ->
      if parseInt($scope.product.number) > 1
        $scope.product.number = parseInt($scope.product.number) - 1
      lastNumber = $scope.product.number
    $scope.increase = ->
      $scope.product.number = parseInt($scope.product.number) + 1
      lastNumber = $scope.product.number
    $scope.showCart = ->
      $('#cartAdded').modal('hide')
      setTimeout ->
        $('#shopApp').modal('show')
      , 1000
      return
    # init
    lastNumber = 1
    $scope.product = { number: 1 }
    return
])

.controller('CartMenuController', [
  '$rootScope', '$scope', 'Carts',
  ($rootScope, $scope, Carts) ->
    getCarts = ->
      Carts.get (response) ->
        $scope.carts = response.data
    $scope.delete = (cart) ->
      if confirm('确认将该产品从购物车删除吗？')
        Carts.delete cart.id, ->
          $rootScope.$broadcast('cartsUpdate')
      return false
    $scope.showCart = ->
      $('#shopApp').modal('show')
      return
    # init
    $scope.carts = []
    $scope.$on 'cartsUpdate', (event) ->
      getCarts()
    getCarts()
    return
])

.controller('CartsController', [
  'Modal', '$rootScope', '$scope', 'Carts', 'Profile', '$filter'
  (Modal, $rootScope, $scope, Carts, Profile, $filter) ->
    getCarts = ->
      Carts.get (response) ->
        $scope.carts = response.data
    $scope.priceAmount = ->
      $filter('cartsAmount')($scope.carts)
    $scope.reloadModal = ->
      Modal.reload()
    $scope.formFilled = ->
      $scope.comment.qqwechat.trim() != '' && $scope.comment.phone.trim() != ''
    $scope.commentChange = ->
      $rootScope.comment = $scope.comment
    $scope.delete = (cart) ->
      if confirm('确认将该产品从购物车删除吗？')
        Carts.delete cart.id, ->
          $rootScope.$broadcast('cartsUpdate')
      return false
    $scope.plus = (cart) ->
      Carts.plus cart.id, ->
        $rootScope.$broadcast('cartsUpdate')
      return
    $scope.minus = (cart) ->
      return if cart.number == 1
      Carts.minus cart.id, ->
        $rootScope.$broadcast('cartsUpdate')
      return
    #init
    $scope.comment = {next_exam:'', notice:'', phone:'', qqwechat:''}
    if $rootScope.comment and Object.keys($rootScope.comment).length > 0
      $scope.comment = $rootScope.comment
    else
      $rootScope.comment = $scope.comment
    $scope.carts = []
    $scope.$on 'cartsUpdate', (event) ->
      getCarts()
    getCarts()
    return
])

.controller('CartConfirmController', [
  'Modal', '$rootScope', '$scope', 'Carts', '$http',
  (Modal, $rootScope, $scope, Carts, $http) ->
    getCarts = ->
      Carts.get (response) ->
        $scope.carts = response.data
    $scope.reloadModal = ->
      Modal.reload()
    $scope.placeOrder = ->
      $http({
        method: 'POST',
        url: '/orders',
        data: $.param({'comment': JSON.stringify($scope.comment)}),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'}
      }).then ->
        $rootScope.$broadcast('cartsUpdate')
        window.location = '#/orders'
        Modal.reload()
    #init
    $scope.comment = $rootScope.comment
    $scope.carts = []
    getCarts()
    return
])

.controller('OrdersController', [
  'Modal', '$scope', '$http',
  (Modal, $scope, $http) ->
    $scope.reloadModal = ->
      Modal.reload()
    #init
    $scope.order = {}
    $scope.orders = []
    $http.get('/orders.json').success (data, status) ->
      $scope.orders = data
])

.controller('OrderDetailController', [
  'Modal', '$filter', '$scope', '$routeParams', '$http',
  (Modal, $filter, $scope, $routeParams, $http) ->
    $scope.reloadModal = ->
      Modal.reload()
    #init
    $scope.order = {}
    $http.get("/orders/#{$routeParams.orderId}.json").success (data, status) ->
      $scope.order = data
      $scope.order.logs = $filter('orderBy')(
        $scope.order.logs, 'created_at'
      )
])
