class Purchase < ApplicationRecord
  belongs_to :item
  belongs_to :user, optional: true
  has_one :address
end
