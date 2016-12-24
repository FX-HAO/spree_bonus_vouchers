module Spree
  class PaymentMethod::BonusVoucher < Spree::PaymentMethod
    def payment_source_class
      ::Spree::BatchBonusVoucher
    end

    def method_type
      type.demodulize.underscore
    end

    def provider
      @provider ||= self
    end

    def self.auto_capture?
      true
    end

    def purchase(amount_in_cents, source, gateway_options = {})
      if source.nil?
        ActiveMerchant::Billing::Response.new(false, "Could not find voucher: #{source.number}", {}, {})
      else
        action = ->(batch_vouchers) {
          batch_vouchers.purchase(amount_in_cents)
        }
        handle_action_call(source, action, :purchase)
      end
    end

    private

    def handle_action_call(batch_vouchers, action, action_name, auth_code=nil)
      if response = action.call(batch_vouchers)
        # note that we only need to return the auth code on an 'auth', but it's innocuous to always return
        ActiveMerchant::Billing::Response.new(true,
                                              "Successful voucher #{action_name}: #{batch_vouchers.id}",
                                              {},  {authorization: response})
      else
        ActiveMerchant::Billing::Response.new(false, batch_vouchers.errors.full_messages.join, {}, {})
      end
    end
  end
end
