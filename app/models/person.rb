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

  def self.unbillable_salary_sum
    joins(:role)
    .where(roles: {billable: false})
    .sum(:salary)
  end

  def self.employees_count
    # joins(:employees)
    # .group("people.name")
    # .count("employees_people.id")


    #includes people with no employees
    joins("LEFT JOIN people employees ON employees.manager_id = people.id")
    .group("people.name")
    .count("employees.id")

  end

  def self.under_average_salary
    joins(
      "INNER JOIN ("+
      Person.select("location_id, AVG(salary) as average")
      .group("location_id")
      .to_sql + 
      ") salaries " \
      "ON salaries.location_id = people.location_id"
    
    ).where("people.salary < salaries.average")
  end

  def self.highest_salaries_ordered_by_name
    joins("INNER JOIN ("+
      Person.select("id, rank() OVER (ORDER BY salary DESC)")
      .to_sql + 
      ") salaries " \
      "ON salaries.id = people.id"
    ).where("salaries.rank <= 3")
    .order(:name)
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
