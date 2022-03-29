class Person < ApplicationRecord
  belongs_to :role
  belongs_to :location
  belongs_to :manager, class_name: "Person", foreign_key: :manager_id, optional: true
  has_many :employees, class_name: "Person", foreign_key: :manager_id
  
  def self.billable
    joins(:role)
    .merge(Role.billable)
  end

  def self.search_for_manager(name)
    joins(:role)
    .merge(Role.managers)
    .where("people.name LIKE ?", "%#{name}%")
    .map(&:name)
  end

  def self.managers
    joins(:role)
    .merge(Role.managers)
  end

  def self.not_managed_by(name)
    Person.
    joins(<<-SQL).
      LEFT JOIN people managers
      ON managers.id = people.manager_id
    SQL
    where(
      "managers.id != ? OR managers.id IS NULL", 
     Person.find_by!(name: name) 
    )
  end

  def self.order_by_age 
    order(age: :desc)
  end


end
