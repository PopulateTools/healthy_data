![example workflow](https://github.com/PopulateTools/healthy_data/actions/workflows/build.yml/badge.svg)

# HealthyData
HealthyData is tool to test the integrity of the data in your database. It will run a set of rules for each table and column and check if the result is the expected. If not, it will create a record for each rule that does not comply.

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

## Setup

You must define the rules for each table inside a YML and initialize `HealthyData` with its location such as:

```ruby
HealthyData.setup do |config|
  config.item_rules_file_location = Rails.root.join("config/healthy_data.yml")
end
```

The content of the file must be something like this:

```yaml
---
- model_name: Item
  sql_query: 'SELECT * FROM items'
  rules:
    - name: "number_attribute_in_range"
      args:
        attribute: amount
        min_amount: 1
        max_amount: 300
    - name: "date_attribute_is_past"
      args:
        attribute: start_date
```

- `model_name`: The model from the table. If the rules are not met for a certain element, the process will create records with a polymorphic relation to the element.
- `sql_query`: THe scope of elements on which we want to check the integrity of data.

For each rule:

- `name`: Name of the rule in snake case. Must exists in the predefined set of the gem or [you can create your own](#creating-your-own-rules).
- `args`: (optional) A list of arguments that differs from rule to rule. Each rule may need knowledge about what attributes are relevant in each case. Other rules may need extra configuration. For example, consider the rule `number_attribute_in_range`, where we want to know if a value in a certain column is within a range. Since the rule is generic, we will need the name of the `attribute` we are checking. We will also need the max (`max_amount`) and min values (`min_amount`) of our ranges.

The rules are defined inside the app [item rules folder](lib/healthy_data/items/rules).

### Creating your own rules

You can create your own rules and link them in your yml config file. The have to inherit from [HealthyData::Items::Rules::Base](lib/healthy_data/items/rules/base.rb) and define two private methods:

- `#check_passes?`: Will return a boolean indicating if the item has the appropiate data or not.
- `#result`: When failing to comply the rule, it provides an explanation on why the check failed that is added in the result record.

## Usage inside a Rails App

For any model defined in the config file, run:

```ruby
HealthyData.run("ModelName")
```

You can also (optionally) put `has_healthy_data` to the model class to add a `healthy_data_item_checks` has_many relation with the checks.

## Usage as a CLI

To run the checks:

```bash
$ healthy-data item rules_path db_path model_name,...
```

- `rules_path`: The path of the rules file
- `db_path`: The path of a yml file with the configuration of the database where the process will take place. The config file structure must be the same as [the hash ActiveRecord uses to establish a connection](https://api.rubyonrails.org/classes/ActiveRecord/ConnectionHandling.html#method-i-establish_connection).

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
