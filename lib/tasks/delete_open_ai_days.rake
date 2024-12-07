namespace :db_cleanup do
  desc 'Delete all records from open_ai_days table'
  task delete_open_ai_days: :environment do
    OpenAiDay.delete_all
    Rails.logger.info "All records in open_ai_days table were deleted at #{Time.current}."
  end
end
