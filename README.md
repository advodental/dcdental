
# Dcdental

  

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/dcdental`. To experiment with that code, run `bin/console` for an interactive prompt.

  

TODO: Delete this and the text above, and describe your gem

  

## Installation

  

Add this line to your application's Gemfile:

  

```ruby

gem  'dcdental'

```


And then execute:


$ bundle


Or install it yourself as:


$ gem install dcdental


## Usage


TODO: Write usage instructions here


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Configuration

```ruby

Dcdental.configure  do |config|
  config.realm = 'realm here'
  config.consumer_key = 'consumer key here'
  config.consumer_secret = 'consumer secret here'
  config.token_id = 'token here'
  config.token_secret = 'token secret here'
  config.base_url = 'base url here'  # Production or Sandbox
end

```
## Auth Endpoints

```ruby
  client = Dcdental::Client.new
  client.auth.get
```
### response: 
```json
{"success": true, "result": {"id": 113138, "name": "Services No Reply", "email": "services@dcdental.com", "location": 0, "department": 0, "role": 1170, "roleId": "customrole_pri_rest_service", "roleCenter": "SYSADMINCENTER", "subsidiary": 1}}
```
## Customer Endpoints
### Get customer:
```ruby
  client = Dcdental::Client.new
  client.customer.get({id})
```
### response:
```json
{"success": true, "result": [{"internalid": "1487367", "entityid": "ADVO", "email": "", "phone": "", "altphone": "", "fax": "", "contact": "", "altemail": ""}]}
```
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dcdental.

## License


The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
