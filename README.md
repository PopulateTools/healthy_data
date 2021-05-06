![example workflow](https://github.com/PopulateTools/healthy_data/actions/workflows/build.yml/badge.svg)

# HealthyData
HealthyData is tool to test the integrity of the data in your database. It will run a set of predefined rules to each table and columns and check if the result is the expected. It will create a record for each rule that does not comply.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'healthy_data'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install healthy_data
```

If you are using it inside Rails you need to also run:

```bash
$ bin/rails generate healthy_data:install
```

## Rules config file

You must define the rules for each table inside a YML and initialize HealthyData with its location such as:

```ruby
HealthyData.setup do |config|
  config.item_rules_file_location = Rails.root.join("config/healthy_data.yml")
end
```

The content of the file must be something like this:

```yaml
---
- model_name: Item
  table: items
  sql_query: 'SELECT * FROM items WHERE amount > 10'
  rules:
    - name: "attribute_is_present"
      args:
        attribute: amount
    - name: "date_attribute_is_past"
      args:
        attribute: start_date
```

The rules are define inside the app [item rules folder](lib/healthy_data/items/rules).

## Creating your own rules

You can create your own rules and link them in your yml config file. The have to inherit from [HealthyData::Items::Rules::Base](lib/healthy_data/items/rules/base.rb) and define two private methods:

- `#check_passes?`: Will return a boolean indicating if the item has the appropiate data or not.
- `#result`: When failing to comply, it provides an explanation on why the check failed that is added in the record

## Usage inside a Rails App

`HealthyData.run("ModelName")`

## Usage as a CLI


## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
