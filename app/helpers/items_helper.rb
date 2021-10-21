module ItemsHelper
  def confirm_sould_out(item_instance)
    Order.exists?(item_id: item_instance.id)
  end
end
