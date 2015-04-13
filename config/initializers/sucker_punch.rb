Rails.application.configure do
  config.active_job.queue_adapter = :sucker_punch
end

ActiveJob::Base.queue_adapter = ActiveJob::QueueAdapters::SuckerPunchAdapter
