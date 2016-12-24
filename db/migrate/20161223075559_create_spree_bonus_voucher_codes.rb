class CreateSpreeBonusVoucherCodes < ActiveRecord::Migration
  def change
    create_table :spree_bonus_voucher_codes do |t|
      t.string :code, index: true
      t.date :expiration, index: true
      t.float :amount, :default => 0, :null =>false, :precision => 8, :scale => 2
      t.integer :valid_days
      t.integer :remaining_times

      t.timestamps null: false
    end

    add_column :spree_bonus_vouchers, :voucher_code_id, :integer
    add_foreign_key :spree_bonus_vouchers, :spree_bonus_voucher_codes, column: :voucher_code_id
  end
end
