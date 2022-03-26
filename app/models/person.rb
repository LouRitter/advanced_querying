class Person < ApplicationRecord
  belongs_to :role
  belongs_to :location
  belongs_to :manager, class_name: "Person", foreign_key: :manager_id, optional: true
  has_many :employees, class_name: "Person", foreign_key: :manager_id
  
  def self.billable
    Person.joins(:role).merge(Role.billable)
  end

  def self.search_for_manager(name)
    joins(:role).merge(Role.managers).where("people.name LIKE ?", "%#{name}%").map(&:name)
  end

  def self.managers
    joins(:role).merge(Role.managers)
  end

  def self.managed_by_and_manager(name)
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


end
