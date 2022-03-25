class AddLocationToPeople < ActiveRecord::Migration[6.0]
  def change
    add_reference :people, :location, foreign_key: true

  end
end
