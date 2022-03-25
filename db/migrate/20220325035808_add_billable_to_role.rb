class AddBillableToRole < ActiveRecord::Migration[6.0]
  def change
    add_column :roles, :billable, :boolean, null: false, default: true
  end
end
