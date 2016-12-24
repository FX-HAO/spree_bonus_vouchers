$ ->
  ($ 'form.edit_order').on('submit', (e) ->
    vouchers_amount = ($ '.spree_bonus_vouchers').reduce (a, b) ->
      a + $(this).attr('amount')
    , 0
      alert vouchers_amount
  )
