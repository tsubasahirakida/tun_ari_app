namespace :ridgepole do
  desc 'Apply schema to database'
  task apply: :environment do
    run('--apply')
  end

  private

    def run(*options)
      config_file = 'config/database.yml'
      schema_file = 'Schemafile'
      rails_env   = ENV['RAILS_ENV'] || Rails.env

      base_command = "bundle exec ridgepole --config #{config_file} --env #{rails_env} --file #{schema_file}"
      full_command = [base_command, *options].join(' ')

      puts '=== run ridgepole... ==='
      puts "[Running] #{full_command}"

      system full_command
    end
end