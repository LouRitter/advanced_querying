class Location < ApplicationRecord
  has_many :people
  belongs_to :region
  
  def self.billable 
    joins(people: :role).merge(Role.billable).distinct
  end

  def self.order_by_region_and_location
    joins(:region).merge(Region.order_by_name).order_by_name
  end

  def self.billable_order_by_region_and_location
    Location.from(Location.billable, :locations).order_by_region_and_location
  end

  def self.order_by_name
    order(:name)
  end
  
end
