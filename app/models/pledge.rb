class Pledge < ActiveRecord::Base
  validates :amount, :numericality => {:greater_than => 0}
end
