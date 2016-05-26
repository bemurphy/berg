source "https://rubygems.org"

ruby "2.3.0"

gem "rake"

# Web framework
gem "puma"
gem "dry-component", git: "https://github.com/timriley/dry-component", branch: "import-containers-for-import-module" # temporary
gem "dry-web", git: "https://github.com/dry-rb/dry-web", branch: "master"
gem "rack_csrf"
gem "shotgun"

# Database persistence
gem "pg"
gem "rom", git: "https://github.com/rom-rb/rom"
gem "rom-mapper", git: "https://github.com/rom-rb/rom-mapper"
gem "rom-repository", git: "https://github.com/rom-rb/rom-repository"
gem "rom-sql", git: "https://github.com/rom-rb/rom-sql"
gem "rom-support", git: "https://github.com/rom-rb/rom-support"

# Background jobs
gem "que"

# Application dependencies
gem "babosa"
gem "bcrypt"
gem "dry-equalizer"
gem "dry-result_matcher"
gem "dry-transaction"
gem "dry-types", git: "https://github.com/dryrb/dry-types", branch: "master"
gem "dry-logic", git: "https://github.com/dryrb/dry-logic", branch: "master"
gem "dry-validation", git: "https://github.com/dryrb/dry-validation", branch: "master"
gem "formalist", git: "https://github.com/icelab/formalist", branch: "master"
gem "i18n"
gem "redcarpet"
gem "slim"
gem "transproc", git: "https://github.com/solnic/transproc"

# 3rd party services
gem "bugsnag"
gem "postmark"

group :development, :test do
  gem "faker"
  gem "guard-rspec", require: false
  gem "pry-byebug"
  gem "foreman"
end

group :test do
  gem "capybara", require: false
  gem "capybara-screenshot", require: false
  gem "codeclimate-test-reporter", require: nil
  gem "database_cleaner"
  gem "inflecto"
  gem "poltergeist"
  gem "rspec"
  gem "site_prism"
end
