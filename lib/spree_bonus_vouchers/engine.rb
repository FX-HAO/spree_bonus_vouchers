module SpreeBonusVouchers
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_bonus_vouchers'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    initializer "spree_bonus_vouchers.register.payment_methods" do |app|
      app.config.spree.payment_methods << Spree::PaymentMethod::BonusVoucher
    end

    initializer "spree_bonus_vouchers.register.permitted_attributes" do
      Spree::PermittedAttributes.source_attributes << {:bonus_voucher_ids => []}
    end

    config.to_prepare &method(:activate).to_proc
  end
end
