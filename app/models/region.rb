class Region < ApplicationRecord
  has_many :locations

  def self.by_name
    order(:name)
  end
end
