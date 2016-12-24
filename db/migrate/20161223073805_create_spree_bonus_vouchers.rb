class CreateSpreeBonusVouchers < ActiveRecord::Migration
  def change
    create_table :spree_bonus_vouchers do |t|
      t.string :number, index: true
      t.integer :user_id
      t.float :amount, :default => 0, :null =>false, :precision => 8, :scale => 2
      t.date :since_date
      t.date :until_date
      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end

    add_index :spree_bonus_vouchers, :user_id
    add_foreign_key :spree_bonus_vouchers, :spree_users, column: :user_id
  end
end
