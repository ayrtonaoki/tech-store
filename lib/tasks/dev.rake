namespace :dev do
  desc "Config development environment"
  task setup: :environment do
    if Rails.env.development?
      set_setup_task("Dropping database") { %x(rails db:drop) }
      set_setup_task("Creating database") {%x(rails db:create) }
      set_setup_task("Migrating database") { %x(rails db:migrate) }
      %x(rails dev:add_categories)
      %x(rails dev:add_products)
    else
      puts "Task can only be used on development environment"
    end
  end

  desc "Create categories"
  task add_categories: :environment do
    set_setup_task("Creating categories") do
      categories = [
        {
          name: 'Hardware'
        },
        {
          name: 'Smartphones'
        },
        {
          name: 'Video Games'
        }
      ]

      categories.each do |category|
        Category.find_or_create_by!(category)
      end
    end
  end

  desc "Create productsw"
  task add_products: :environment do
    set_setup_task("Creating products") do
      products = [
        {
          name: 'Apple iPhone 11 Pro Max',
          description: '6.5-inch Super Retina XDR OLED display, 12MP TrueDepth front camera',
          price: 1099.00,
          amount: 10,
          category_id: Category.where(name: "Smartphones")[0].id
        },
        {
          name: 'Nintendo Switch Neon Red Blue',
          description: 'This model includes battery life of approximately 4.5 to 9 hours',
          price: 441.26,
          amount: 20,
          category_id: Category.where(name: "Video Games")[0].id
        },
        {
          name: 'Intel Core i9-9900K',
          description: '8 Cores up to 5.0GHz Unlocked LGA1151 300 Series 95W',
          price: 509.00,
          amount: 5,
          category_id: Category.where(name: "Hardware")[0].id
        }
      ]

      products.each do |product|
        Product.find_or_create_by!(product)
      end
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
