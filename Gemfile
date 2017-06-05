source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

gem 'rails-observers'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'jquery-ui-rails'

# Jquery Datatables
gem 'jquery-datatables-rails' #, git: 'git://github.com/rweng/jquery-datatables-rails.git'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'bootstrap-sass', '3.1.1'

# authentication
gem 'devise'

# authorization
gem 'cancan'

gem 'bootstrap-datepicker-rails', '~> 1.3.0.2'

gem 'active_link_to'

gem 'whenever', :require => false

group :devutility do
  #gem "mysql2"
  #gem "distribute", '0.4.2', :git => 'http://githuben.intranet.mckinsey.com/AppDev/distribute.git'
  #gem "crypto",'0.0.4', :git => 'http://githuben.intranet.mckinsey.com/AppDev/crypto.git'
  gem 'capistrano' , '2.9.0'
  gem 'rvm-capistrano', :require => false
end

group :development do
  gem 'sqlite3'
end

group :production do
  gem 'rails_12factor'
  gem 'pg'
end

# importing excel
gem 'roo'

gem 'iconv'

gem 'rubyzip', '<1.0.0'
gem 'acts_as_xlsx'
gem 'axlsx_rails'

# image uploading
gem 'paperclip'

group :development do
	gem 'better_errors'
	gem 'letter_opener'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0'
  gem 'factory_girl_rails'
end
group :test do
  gem 'faker'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
end
group :doc do
  gem 'sdoc', require: false
end
