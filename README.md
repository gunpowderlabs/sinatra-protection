# Sinatra::Protection

This gem provides a small, simple Sinatra extension that allows protecting the selected routes in your application with HTTP Basic Authentication.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sinatra-protection'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinatra-protection

## Usage for classic Sinatra apps

```ruby
require "sinatra"
require "sinatra/protection"

# optionally configure the credentials and realm

set :username, "demo" # default: "admin"
set :password, "pass" # default: "admin"
set :realm, "My Application" # default: "Restricted Area"

get "/protected" do
  protected!
  # do something that requires authentication
end

get "/" do
  # this action will not require authentication
end
```

## Usage for modular Sinatra apps

```ruby
require "sinatra"
require "sinatra/protection"

class MyApp < Sinatra::Application
  register Sinatra::Protection

  # configure and use as in the classical example
end
```

## Disabling protection

Sometimes you might want to completely disable HTTP authentication for the entire application. 
The easiest way to do it is by setting:

```ruby
set :enable_protection, false
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gunpowderlabs/sinatra-protection. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

