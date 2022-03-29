class Location < ApplicationRecord
  has_many :people
  belongs_to :region
  
  def self.billable 
    joins(people: :role)
    .merge(Role.billable)
    .distinct
  end

  def self.order_by_region_and_location
    joins(:region)
    .merge(Region.order_by_name)
    .order_by_name
  end

  def self.billable_order_by_region_and_location
    from(Location.billable, :locations)
    .order_by_region_and_location
    # joins(
    #   "INNER JOIN (" +
    #     Location.
    #       joins(people: :role).
    #       where(roles: { billable: true }).
    #       distinct.
    #       to_sql +
    #     ") billable_locations " \
    #     "ON locations.id = billable_locations.id"
    # ).
    # joins(:region).
    # merge(Region.order(:name)).
    # order(:name)
  end

  def self.order_by_name
    order(:name)
  end
  
end
