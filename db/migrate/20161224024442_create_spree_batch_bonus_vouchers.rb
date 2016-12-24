class CreateSpreeBatchBonusVouchers < ActiveRecord::Migration
  def change
    create_table :spree_batch_bonus_vouchers do |t|
      t.timestamps null: false
    end

    add_column :spree_bonus_vouchers, :batch_id, :integer
    add_foreign_key :spree_bonus_vouchers, :spree_batch_bonus_vouchers, column: :batch_id
  end
end
