class Region < ApplicationRecord
  has_many :locations

  def self.order_by_name
    order(:name)
  end
end
