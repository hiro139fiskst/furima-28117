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
    validates :name
    validates :image
    validates :description
    validates :price, format: { with: /\A[0-9]+\z/, message: 'out of setting range' }, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'half-width number' }
  end
  with_options numericality: { other_than: 1, message: 'id Select' } do
    validates :category_id, format: { with: /\A[0-9]+\z/}
    validates :condition_id, format: { with: /\A[0-9]+\z/}
    validates :postage_payer_id, format: { with: /\A[0-9]+\z/}
    validates :prefecture_id, format: { with: /\A[0-9]+\z/}
    validates :handling_time_id, format: { with: /\A[0-9]+\z/}
  end
end
