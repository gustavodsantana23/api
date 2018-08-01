class Customer < ApplicationRecord
	self.table_name = "customer_customer"

	has_many :exams
end
