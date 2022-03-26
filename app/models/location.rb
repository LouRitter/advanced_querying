class Location < ApplicationRecord
  has_many :people
  belongs_to :region
  
  def self.billable 
    joins(people: :role).merge(Role.billable).distinct
  end

  def self.by_region_and_location
    joins(:region).merge(Region.by_name).by_name
  end

  def self.billable_by_region_and_location
    Location.from(Location.billable, :locations).by_region_and_location
  end

  def self.by_name
    order(:name)
  end
  
end
