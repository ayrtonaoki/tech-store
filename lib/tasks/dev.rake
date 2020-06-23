namespace :dev do
  desc "Config development environment"
  task setup: :environment do
    if Rails.env.development?
      set_setup_task("Dropping database") { %x(rails db:drop) }
      set_setup_task("Creating database") {%x(rails db:create) }
      set_setup_task("Migrating database") { %x(rails db:migrate) }
      set_setup_task("Seeding database") { %x(rails db:seed) }
    else
      puts "Task can only be used on development environment"
    end
  end
  private
    def set_setup_task(message)
      spinner = TTY::Spinner.new("[:spinner] #{message}")
      spinner.auto_spin
      yield
      spinner.success('... Done!')
    end
end
