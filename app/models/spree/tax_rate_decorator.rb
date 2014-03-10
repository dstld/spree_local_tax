Spree::TaxRate.class_eval do
  def adjust(order)
    label = create_label(order)
    if included_in_price
      if Zone.default_tax.contains? order.tax_zone
        order.line_items.each do |line_item|
          amount = calculator.compute(line_item)
          unless amount == 0
            line_item.adjustments.create(
              order: order,
              amount: amount,
              source: line_item,
              originator: self,
              label: label,
              mandatory: false,
              state: "closed",
              included: true
            )
          end
        end
      else
        amount = -1 * calculator.compute(order)
        label = Spree.t(:refund) + label

        order.adjustments.create(
          order: order,
          amount: amount,
          source: order,
          originator: self,
          state: "closed",
          label: label
        )
      end
    else
      amount = calculator.compute(order)
      unless amount == 0
        order.adjustments.create(
          order: order,
          amount: amount,
          source: order,
          originator: self,
          state: "closed",
          label: label
        )
      end
    end
  end

  private

  def create_label(order)
    local = Spree::Calculator::LocalTax.find_local_tax(order.tax_address)
    amount = local.present? ? local.local : 0
    label = ""
    label << (name.present? ? name : tax_category.name) + " "
    label << (show_rate_in_label? ? "#{amount * 100}%" : "")
  end
end
