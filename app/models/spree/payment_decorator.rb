module Spree
  Payment.class_eval do
    def build_source
      return unless new_record?
      if source_attributes.present? && source.blank? && payment_method.try(:payment_source_class)
        if payment_method.payment_source_class == Spree::BatchBonusVoucher
          batch_bonus_voucher = BatchBonusVoucher.create
          batch_bonus_voucher.vouchers << source_attributes[:bonus_voucher_ids].map { |bonus_voucher_id| BonusVoucher.find_by_id(bonus_voucher_id) }
          self.source = batch_bonus_voucher
        else
          self.source = payment_method.payment_source_class.new(source_attributes)
          self.source.payment_method_id = payment_method.id
          self.source.user_id = self.order.user_id if self.order
        end
      end
    end
  end
end
