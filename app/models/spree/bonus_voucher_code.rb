module Spree
  class BonusVoucherCode < ActiveRecord::Base
    before_validation :generate_code, on: :create

    has_many :spree_vouchers, :class_name => 'Spree::BonusVoucher'

    validates :code, presence: true
    validates :amount, presence: true
    validates :remaining_times, :numericality => { :greater_than_or_equal_to => 0 }

    def generate_bonus_voucher(user)
      bonus_voucher = BonusVoucher.new(amount: amount, user: user)
      if valid_days
        bonus_voucher.since_date = Date.now
        bonus_voucher.until_date = Date.now + valid_days.days
      end
      self.remaining_times -= 1
      bonus_voucher.spree_voucher_code = self
      bonus_voucher.save
      return bonus_voucher
    end

    def self.generate_voucher_code(amount, number=1, usage_times=1, valid_days=nil, expiration=nil)
      number.times do
        Spree::BonusVoucherCode.create(
          amount: amount,
          remaining_times: usage_times,
          valid_days: valid_days,
          expiration: expiration
        )
      end
    end

    private

    def generate_code
      record = true
      while record
        random = "BVC#{Array.new(9){rand(9)}.join}"
        record = self.class.where(code: random).first
      end
      self.code = random if self.code.blank?
      self.code
    end
  end
end
