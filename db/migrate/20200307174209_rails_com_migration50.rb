class RailsComMigration50 < ActiveRecord::Migration[6.0]

  def change











































































































































    add_reference :packages, :user































































  end

end