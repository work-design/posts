class RailsComMigration68 < ActiveRecord::Migration[6.0]

  def change


















































    add_column :carts, :lock_version, :integer
    rename_column :carts, :reduced_amount, :total_reduced_amount
    rename_column :carts, :additional_amount, :total_additional_amount
































































    remove_column :trade_promotes, :scope, :string
    rename_table :promote_buyers, :promote_carts

    remove_column :promote_carts, :buyer_type, :string
    remove_column :promote_carts, :buyer_id, :integer, scale: 8

    add_reference :promote_carts, :cart







































































































  end

end
