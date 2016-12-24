class Spree::BatchBonusVoucher < ActiveRecord::Base
  has_one :payment, as: :source
  has_many :vouchers, foreign_key: 'batch_id', class_name: "Spree::BonusVoucher", autosave: true

  def amount
    vouchers.reduce(0) { |amount, voucher| amount + voucher.amount }
  end

  def is_valid?
    vouchers.map(&:is_valid?)
  end

  def valid_amount
    valid_vouchers = vouchers.select(&:is_valid?)
    valid_vouchers.reduce(0) { |amount, voucher| amount + voucher.amount }
  end

  def purchase(amount)
    if valid_amount >= amount
      deactivate_vouchers
      return true
    else
      errors.add(:base, Spree.t(:insuffcient_amount_of_vouchers))
      return false
    end
  end

  private

  def deactivate_vouchers
    vouchers.each { |voucher| voucher.destroy }
  end
end
