Deface::Override.new(
  virtual_path:   'spree/checkout/_payment',
  name:           'remove_coupon_code',
  remove:         '[data-hook="coupon_code"]',
)
