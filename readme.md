# JSON Key Transformer Middleware

Rack middleware which transforms incoming and outgoing JSON keys to support the development of Rails JSON-based APIs.

By default, incoming JSON keys are transformed from `camelCase` to `snake_case` and outgoing JSON keys are transformed from `snake_case` to `camelCase`.

## Installation

Add this to your Gemfile:

    gem 'json_key_transformer_middleware'

Then execute:

    $ bundle install

Or, install it directly:

    $ gem install json_key_transformer_middleware

## Usage

Simply including the gem in the Gemfile for a Rails application will initialize the rack middleware which transforms incoming and outgoing JSON keys.

The primary purpose of this gem is to:

1. Transform incoming parameter names from JSON-style `camelCase` to Ruby-style `snake_case`. Clients send `camelCase` parameters, you work with `snake_case` params in your Rails controllers.
1. Transform outgoing parameter names from Ruby-style `snake_case` to JSON-style `camelCase`. When rendering a JSON response, you send a `snake_case` hash response, the client will receive a `camelCase` response.

In both cases the transformation process walks the entire incoming and outgoing data structure.

*Incoming transformation example*

From (JSON):

```
    {"paramName": "value", "paramName2": [{"paramName3": "value"}]}
```

To (Rails params):

```
    {"param_name" => "value", "param_name2" => [{"param_name3" => "value"}]}
```

*Outgoing transformation example*

From (Rails response):

```
    {"param_name" => "value", "param_name2" => [{"param_name3" => "value"}]}
```

To (JSON):

```
    {"paramName": "value", "paramName2": [{"paramName3": "value"}]}
```

## Configuration

This middleware uses the `hash_key_transformer` gem to perform deep transformation of hash keys. You can configure incoming and outgoing hash transformations. Use any of the available transformations and transformation options provided by `hash_key_transformer`.

The Railtie provides these configuration options:

* `incoming_strategy` - default value of `:transform_camel_to_underscore`.
* `incoming_strategy_options` - no options set by default.
* `outgoing_strategy` - default value of `:transform_underscore_to_camel`.
* `outgoing_strategy_options` - no options set by default.

Here is an example Rails initializer which turns on the `outgoing_strategy_options.keep_lead_underscore` option:

```ruby
# initializers/json_key_transformer_middleware.rb

Rails.application.config.json_key_transformer_middleware.outgoing_strategy_options.keep_lead_underscore = true
```

## Notes

This gem serves a very specific purpose. As such, it only targets a specific version of Rails. Over time more versions of Rails may be supported.

## License

Apache License, Version 2.0
