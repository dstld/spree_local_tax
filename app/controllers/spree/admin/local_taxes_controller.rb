module Spree
  module Admin
    class LocalTaxesController < ResourceController
      def index
        @local_taxes = Spree::LocalTax.all.order(:zip)
      end
    end
  end
end
