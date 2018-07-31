class ReportSerializer < ActiveModel::Serializer
  attributes :report_id, :region, :transcript, :findings, :finished_at

  def report_id
  	object.id
  end

  def finished_at
  	object.finished
  end
end
