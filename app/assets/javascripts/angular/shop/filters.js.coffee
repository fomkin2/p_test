angular.module 'shopApp'

.filter('cartsAmount', ->
  (carts) ->
    return 0 if carts.length == 0
    carts.reduce((p, n) ->
      parseInt(p) + n.price * n.number
    , 0)
)

.filter('ordersByUid', ->
  (orders, uid) ->
    return [] if orders.length == 0
    return orders unless uid
    orders.filter (o) ->
      o.uid.indexOf(uid) != -1
)

.filter('ordersPriceToInt', ->
  (orders) ->
    orders.map (o) ->
      o.price = parseInt(o.price)
      o
)

.filter('logCommentText', ['$sce', ($sce) ->
  (commentObj) ->
    if typeof commentObj == 'string'
      return $sce.trustAsHtml commentObj
    if typeof commentObj == 'number'
      return $sce.trustAsHtml commentObj.toString()
    text = ''
    for item of commentObj
      text += "#{item}: #{commentObj[item]}<br/>"
    $sce.trustAsHtml text
])

.filter('logCommentObj', ->
  (comment, key = null) ->
    return '' unless comment
    try
      commentObj = JSON.parse(comment)
    catch
      return comment
    return commentObj[key] if key
    commentObj
)

.filter('priceAsInt', ->
  (price) ->
    return unless price
    parseInt(price)
)

.filter('orderAmount', ->
  (order) ->
    return unless order
    return unless order.products
    sum = 0
    for product in order.products
      sum += parseInt(product.price) * product.number
    sum
)
