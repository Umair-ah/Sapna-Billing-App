class Invoice < ApplicationRecord
  has_many :items, inverse_of: :invoice, dependent: :destroy
  accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true

  validates :number, :date, :to, presence: true


  after_create :calc_total_amt
  after_update :calc_total_amt


  def calc_total_amt
    update_column :total_amount, items.map(&:amount).sum
  end
end