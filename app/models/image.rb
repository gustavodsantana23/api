class Image < ApplicationRecord
	self.table_name = "exam_attachmentfile"
	
	belongs_to :exam
end
