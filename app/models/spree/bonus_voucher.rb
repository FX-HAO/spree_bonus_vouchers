module Spree
  class BonusVoucher < ActiveRecord::Base
    acts_as_paranoid

    before_validation :generate_voucher_number, on: :create

    belongs_to :user, class_name: Spree.user_class
    belongs_to :spree_voucher_code, foreign_key: 'voucher_code_id', class_name: "Spree::BonusVoucherCode", autosave: true
    belongs_to :spree_batch_voucher, foreign_key: 'batch_id', class_name: "Spree::BatchBonusVoucher"

    validates :user, :number, presence: true
    validates :number, uniqueness: true

    def is_valid?
      deleted_at.nil? && !expired?
    end

    def expired?
      now = Time.now
      (since_date && now < since_date) || (until_date && now > until_date)
    end

    private

    def generate_voucher_number
      record = true
      while record
        random = "BV#{Array.new(9){rand(9)}.join}"
        record = self.class.where(number: random).first
      end
      self.number = random if self.number.blank?
      self.number
    end

  end
end
