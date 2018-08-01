json.next ""
json.previous ""
json.results @exams do |exam|
	json.exam_id exam.id
	json.ready false
	json.animal exam.name
	if exam.customer_id?
		json.animal_owner exam.customer.name
	else
		json.animal_owner ""
	end
	json.vet_requester exam.veterinary
	json.clinic_requester exam.clinic
	json.images exam.images do |image|
		"https://s3-sa-east-1.amazonaws.com/media.cedimvet.flowify.com.br/#{image.file}"
	end
end