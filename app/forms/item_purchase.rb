class ItemPurchase
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :address_number, :building_name, :phone_number, :price, :item_id, :user_id, :token, :purchase_id

  with_options presence: true do
    validates :token, :prefecture_id, :city, :address_number
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :phone_number, format: { with: /\A\d{11}\z/, message: 'は、ハイフン抜きで入力してください' }
  end

  def save
    @purchase_id = Purchase.create(item_id: item_id, user_id: user_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address_number: address_number, building_name: building_name, phone_number: phone_number, purchase_id: @purchase_id.id)
  end
end
