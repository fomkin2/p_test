json.uid         @order.uid
json.price       @order.price
json.status      @order.status
json.created_at  @order.created_at.strftime('%F %R')
json.payment_url Alipay::Service.create_partner_trade_by_buyer_url(
  out_trade_no: @order.uid,
  subject: @order.uid,
  price: @order.price,
  quantity: 1,
  logistics_type: 'DIRECT',
  logistics_fee: '0',
  logistics_payment: 'SELLER_PAY',
  return_url: "#{ENV['RETURN_URL_PREFIX']}#{@order.uid}",
  notify_url: "#{ENV['NOTIFY_URL_PREFIX']}#{@order.uid}"
)

json.logs @order.orders_logs do |log|
  json.id         log.id
  json.admin      log.admin.present?
  json.status     Order.status_text(log.status)
  json.comment    log.comment
  json.created_at log.created_at.strftime('%F %R')
end

json.products @order.orders_products do |product|
  products_images = product.product.products_images.order('ordering desc')
  json.id         product.id
  json.title      product.product.title
  json.price      product.price
  json.number     product.number
  json.cover      products_images.present? ? products_images.first.file.url : nil
  json.created_at product.created_at.strftime('%F %R')
end
