class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :handling_time

  belongs_to :user
  has_one_attached :image
  has_one :purchase

  with_options presence: true do
    validates :name, length: { maximum: 40, message: 'is too long' }
    validates :image
    validates :description, length: { maximum: 1000, message: 'is too long' }
    validates :price, numericality: { with: /\A[0-9]+\z/, message: 'は半角で入力してください。' },
                      inclusion: { in: 300..9_999_999, message: 'Out of setting range' }
  end

  with_options numericality: { other_than: 1, message: 'id Select' } do
    validates :category_id
    validates :condition_id
    validates :postage_payer_id
    validates :prefecture_id
    validates :handling_time_id
  end
end
