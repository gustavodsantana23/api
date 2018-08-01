class ExamSerializer < ActiveModel::Serializer
  attributes :exam_id, :ready, :animal, :animal_owner, :age_year
  attributes :age_month, :gender, :breed, :specie, :submitter
  attributes :vet_requester, :clinic_requester, :report_id
  attributes :images, :created, :finished

  def exam_id
  	object.id
  end

  def breed
  	Breed.find(object.breed_id)
  end

  def specie
  	Specie.find(object.specie_id)
  end

  def created
		object.state_update
	end

	def finished
		object.state_update
	end

  def ready
  	false
  end

  def animal
  	object.name
  end

  def animal_owner
  	if object.customer_id
  		Customer.find(object.customer_id).name
  	else
  		""
  	end
  end

  def age_year
  	object.age
  end

  def submitter
  	"submitter"
  end

  def vet_requester
  	Profile.find(object.veterinary_id)
  end

  def clinic_requester
  	if object.clinic_id
  		Profile.find(object.clinic_id)
  	end
  end

  def report_id
  	# e quando nao houver report?
  	Report.where(exam_id: object.id).last.id
  end

  def images
  	# fazer modelo de attachment file
  end
end
