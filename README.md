# Argentinian::Validations

[![Gem Version](https://badge.fury.io/rb/crf.svg)](https://badge.fury.io/rb/crf)
[![Build Status](https://travis-ci.org/alebian/argentinian-validations.svg)](https://travis-ci.org/alebian/argentinian-validations)
[![Code Climate](https://codeclimate.com/github/alebian/argentinian-validations/badges/gpa.svg)](https://codeclimate.com/github/alebian/argentinian-validations)
[![Test Coverage](https://codeclimate.com/github/alebian/argentinian-validations/badges/coverage.svg)](https://codeclimate.com/github/alebian/argentinian-validations/coverage)

This gem provides classes to validate personal information specific to Argentina like CUIT or CBU.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'argentinian-validations'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install argentinian-validations

## Usage

```ruby
require 'argentinian/validations'

valid_cbu = '2850590940090418135201'
validator = Argentinian::Validations::Cbu.new(valid_cbu)
validator.valid? #=> true
validator.validate! #=> "2850590940090418135201"

invalid_cbu = '1850590940090418135201'
validator = Argentinian::Validations::Cbu.new(invalid_cbu)
validator.valid? #=> false
validator.validate! #=> *** Argentinian::Validations::Cbu::AccountError Exception

valid_cuit = '30707026851'
validator = Argentinian::Validations::Cuit.new(valid_cuit)
validator.valid? #=> true
validator.validate! #=> "30707026851"

invalid_cuit = '20707026851'
validator = Argentinian::Validations::Cuit.new(invalid_cuit)
validator.valid? #=> false
validator.validate! #=> *** Argentinian::Validations::Cuil::InvalidNumberError Exception
```

### Usage in Rails

It is very useful to use the custom validators provided by Rails:

```ruby
# app/validators/cbu_validator.rb
class CbuValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    validator = Argentinian::Validations::Cbu.new(value)
    record.errors.add(attribute, validator.errors.first) unless validator.valid?
  end
end
```

And then in your model:

```ruby
# app/models/my_model.rb
class MyModel < ApplicationRecord
  validates :number, cbu: true
end
```

## Development

After checking out the repo, run `bundle install` to install dependencies.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Run rubocop (`bundle exec rubocop Gemfile lib spec`)
5. Run rspec (`bundle exec rspec`)
6. Push your branch (`git push origin my-new-feature`)
7. Create a new Pull Request
