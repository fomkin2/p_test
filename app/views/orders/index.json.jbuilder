json.array!(@orders) do |order|
  json.extract! order, :uid, :price
  json.status Order.status_text order.status
  json.created_at order.created_at.strftime('%F %R')
  json.payment_url Alipay::Service.create_partner_trade_by_buyer_url(
    out_trade_no: order.uid,
    subject: order.uid,
    price: order.price,
    quantity: 1,
    logistics_type: 'DIRECT',
    logistics_fee: '0',
    logistics_payment: 'SELLER_PAY',
    return_url: "#{ENV['RETURN_URL_PREFIX']}#{order.uid}",
    notify_url: "#{ENV['NOTIFY_URL_PREFIX']}#{order.uid}"
  )
  json.url '/orders/#{order.id}.json'
end
