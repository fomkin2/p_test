'use strict'

angular.module 'shopApp'

.factory('Profile', ['$http', ($http) ->
  return {
    get: (success, failed) ->
      $http.get('/profile.json').then success, failed
  }
])

.factory('Carts', ['$http', ($http) ->
  return {
    get: (success, failed) ->
      $http.get('/carts.json').then success, failed
    delete: (cartId, success, failed) ->
      $http.delete("/carts/#{cartId}.json").then success, failed
    plus: (cartId, success, failed) ->
      $http.patch("/carts/plus/#{cartId}.json").then success, failed
    minus: (cartId, success, failed) ->
      $http.patch("/carts/minus/#{cartId}.json").then success, failed
  }
])

.factory('Modal', ->
  return {
    # reload modal to fix scroll problem
    reload: ->
      $('#shopApp').modal('hide')
      setTimeout ->
        $('#shopApp').modal('show')
      , 1000
      return
  }
)
