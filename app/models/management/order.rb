class Management::Order < Order
  def self.support_status current_status
    case current_status
    when 'CREATED'
      return {
        '已取消' => 'CANCELED',
        '已支付' => 'PAID',
      }
    when 'PAID'
      return {
        '已发货' => 'DELIVERED',
      }
    when 'AFTER_SALE_REQUESTED'
      return {
        '售后完成' => 'AFTER_SALE_FINISHED',
        '售后完成' => 'REFUNDED',
      }
    else
      return false
    end
  end

  def update_price price, admin_id, comment
    raise 'price must great than 0' if price <= 0
    admin = find_admin admin_id
    raise 'update failed' unless self.update price: price
    self.orders_logs.create(
      status: self.status,
      admin: admin,
      comment: "#修改价格:¥#{price}#" + comment
    )
  end

  def set_status status, admin_id, comment
    case status
    when 'CANCELED'
      require_status = 'CREATED'
    when 'PAID'
      require_status = 'CREATED'
    when 'DELIVERED'
      require_status = 'PAID'
    when 'AFTER_SALE_FINISHED'
      require_status = 'AFTER_SALE_REQUESTED'
    when 'REFUNDED'
      require_status = 'AFTER_SALE_REQUESTED'
    end
    if require_status
      check_comment comment
      admin = find_admin admin_id if admin_id
      check_status require_status
      return self.orders_logs.create status: status, admin: admin, comment: comment
    end
  end

  private

  def check_status status_should_be
    if self.status != status_should_be
      raise "order status must #{status_should_be}"
    end
  end

  def find_admin admin_id
    raise 'admin_id is required' if admin_id.blank?
    @admin = Admin.find(admin_id)
  end

  def check_comment comment
    raise 'comment is required' if comment.blank?
  end
end
