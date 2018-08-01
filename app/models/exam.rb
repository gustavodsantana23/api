class Exam < ApplicationRecord
	self.table_name = "exam_exam"

	has_one :breed
	has_one :customer
	belongs_to :veterinary, class_name: 'Profile', foreign_key: 'veterinary_id'
	belongs_to :clinic, class_name: 'Profile', foreign_key: 'clinic_id'
	has_many :images, foreign_key: 'exam_id'
end
