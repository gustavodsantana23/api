class Profile < ApplicationRecord
	self.table_name = "professional_profile"

	has_many :exams
end
