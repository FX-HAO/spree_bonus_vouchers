Spree.user_class.class_eval do
  has_many :spree_bonus_vouchers, :foreign_key => 'user_id', :class_name => 'Spree::BonusVoucher'
end
