class Item < ApplicationRecord
  belongs_to :invoice

  validates :description, :quantity, :rate, presence: true
  
  after_create :calc_amt
  after_update :calc_amt
  

  

  def calc_amt
    update_column :amount, (self.rate * self.quantity)
  end
end
