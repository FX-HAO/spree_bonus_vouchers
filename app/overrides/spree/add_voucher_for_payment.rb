# Deface::Override.new(
#   virtual_path:  'spree/checkout/_payment',
#   name:          'add_pay_by_voucher',
#   insert_after:  '#payment-methods, [data-hook="payment-methods"]',
#   partial:       'spree/checkout/payment/voucher_code.html.erb'
# )