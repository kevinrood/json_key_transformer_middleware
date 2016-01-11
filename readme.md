# JSON Key Transformer Middleware

Rack middleware which transforms incoming and outgoing JSON keys to support the development of Rails JSON-based APIs.

Incoming JSON keys are transformed from `camelCase` to `snake_case`. Outgoing JSON keys are transformed from `snake_case` to `camelCase`.

## Installation

Add this to your Gemfile:

    gem 'json_key_transformer_middleware'

Then execute:

    $ bundle install

Or, install it directly:

    $ gem install json_key_transformer_middleware

## Usage

Simply including the gem in the Gemfile for a Rails application will initialize the rack middleware which transforms incoming and outgoing JSON keys.

## Notes

This gem serves a very specific purpose. As such, it only targets a specific version of Rails. Over time more versions of Rails may be supported.

## License

Apache License, Version 2.0
