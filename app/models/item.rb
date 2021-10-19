class Item < ApplicationRecord
  # association ActiveHash
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :prefecture
  belongs_to :sales_status
  belongs_to :scheduled_delivery
  belongs_to :shipping_fee_status
  # association
  belongs_to :user
  has_one_attached :image

  # validation
  with_options presence: true do
    validates :image
    validates :name
    validates :info
    validates :price, numericality: { only_integer: true, message: 'is invalid. Input half-width characters' },
                      inclusion: { in: 300..9_999_999, message: 'is out of setting range' }
    with_options numericality: { other_than: 0, message: "can't be blank" } do
      validates :category_id
      validates :sales_status_id
      validates :shipping_fee_status_id
      validates :prefecture_id
      validates :scheduled_delivery_id
    end
  end
end
