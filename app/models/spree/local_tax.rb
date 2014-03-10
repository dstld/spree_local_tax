class Spree::LocalTax < ActiveRecord::Base
  belongs_to :state, :class_name => "Spree::State"
  validates :zip, :uniqueness => { scope: :state_id }

  def rate
    state.tax + local + other
  end
end
