
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
  client = Dcdental::Client.new # or Dcdental.new
  client.auth.get
```
### response: 
```json
{"success": true, "result": {"id": 113138, "name": "Services No Reply", "email": "services@dcdental.com", "location": 0, "department": 0, "role": 1170, "roleId": "customrole_pri_rest_service", "roleCenter": "SYSADMINCENTER", "subsidiary": 1}}
```
## Customer Endpoints
### Get customer:
```ruby
  client = Dcdental::Client.new # or Dcdental.new
  client.customer.get(id)
```
### response:
```json
{"internal_id": "1487367", "entity_id": "ADVO", "email": "", "phone": "", "alt_phone": "", "fax": "", "contact": "", "alt_email": ""}
```

### Create customer:
```ruby
  client = Dcdental::Client.new # or Dcdental.new
  client.customer.create({entity_status: '16',
      entity_id: "CUST 999-999-9999", # required but can be automatically build as "CUST " + phone in format XXX-XXX-XXXX
      company_name: 'SAMPLE COMPANY NAME', # required
      phone: '999-999-9999', # required
      external_id: 1
  })
```
### response:
```json
1111111
```

### Update customer:
```ruby
  client = Dcdental::Client.new # or Dcdental.new
  client.customer.update(customer_id, { entity_status: '16' })
```
entity status
### response:
```json
1111111
```

## CustomerAddress Endpoints
### Get customer addresses list
#### by customer_id
```ruby
  client = Dcdental::Client.new # or Dcdental.new
  client.customer_address.list(customer_id: 1)
```
#### by email
```ruby
  client = Dcdental::Client.new # or Dcdental.new
  client.customer_address.list(email: 'example@mail.com')
```
This request also supports page number and page_size
```ruby
  client = Dcdental::Client.new # or Dcdental.new
  client.customer_address.list(customer_id: 1, page: 1, page_size: 5)
```
### response:
```json
[{"internal_id":null, "entity_id":null, "is_residential":null, "id":null, "default_billing":null, "default_shipping":null, "label":"363 Smith Ridge Road", "attention":"", "addressee":"Joseph DeLapa", "address1":"363 Smith Ridge Road", "address2":"", "address3":null, "city": "South Salem", "state":"NY", "zipcode":"10590", "country":null, "address_phone":"", "customer_dea_number":"", "customer_state_license_number": "036262 ", "customer_state_license_expiration":"" }]
```
### Create customer address:
```ruby
  client = Dcdental::Client.new # or Dcdental.new
  client.customer.create(customer_id: 1, address: {
      default_billing: false,   # required true/false
      default_shipping: false,  # required true/false
      label: "Label", # Free form text field representing the address record. If omitted, the value is set to the same as the addr1 field value.
      addressee: "Addressee",  # required
      attention: "Attention",  # required
      city: "City",            # required
      state: "ST",             # required
      country: "US",           # required
      zip: "99999",            # required
      addr1: "addr1",          # required
      addr2: "addr2",
      addr3: "addr3",
      addr_phone: '9999999999'
      custrecord_state_license_number: "9999"
      custrecord_state_license_expiration: ""
      custrecord_dea_number: ""
  })
```
### response:
```json
{ "entityid"=>1490168, "isresidential"=>false, "id"=>"57758181", "defaultbilling"=>true, "internalid"=>4506984, "addressid"=>"4506984", "defaultshipping"=>false, "label"=>"Label", "addrphone"=>"9999999999", "state"=>"ST", "addressee"=>"Addressee", "city"=>"City", "attention"=>"Attention", "zip"=>"99999", "country"=>"US", "addr1"=>"addr1", "addr2"=>"addr2", "addr3"=>"addr3"}
```

### Update customer address:
```ruby
  client = Dcdental::Client.new # or Dcdental.new
  client.customer.create(customer_id: 1, address_id: 1, address: {
      default_billing: false,
      default_shipping: false,
      label: "Label", # Free form text field representing the address record. If omitted, the value is set to the same as the addr1 field value.
      addressee: "Addressee",
      attention: "Attention",
      city: "City",
      state: "ST",
      country: "US",
      zip: "99999",
      addr1: "addr1",
      addr2: "addr2",
      addr3: "addr3",
      addr_phone: '9999999999'
      custrecord_state_license_number: "9999"
      custrecord_state_license_expiration: ""
      custrecord_dea_number: ""
  })
```
### response:
```json
{ "entityid"=>1490168, "isresidential"=>false, "id"=>"57758181", "defaultbilling"=>true, "internalid"=>4506984, "addressid"=>"4506984", "defaultshipping"=>false, "label"=>"Label", "addrphone"=>"9999999999", "state"=>"ST", "addressee"=>"Addressee", "city"=>"City", "attention"=>"Attention", "zip"=>"99999", "country"=>"US", "addr1"=>"addr1", "addr2"=>"addr2", "addr3"=>"addr3"}
```
This endpoint also supports partial update: 
```ruby
  client = Dcdental::Client.new # or Dcdental.new
  client.customer.create(customer_id: 1, address_id: 1, address: { city: "City" })
```
Response will be the same as for general update

## Product Endpoints
### Get products list
#### by internal id
```ruby
  client = Dcdental::Client.new # or Dcdental.new
  client.product.list(item_id: 1)
```
#### by array of ids
```ruby
  client = Dcdental::Client.new # or Dcdental.new
  client.product.list(item_id: [1, 22])
```
This request also supports page number and page_size
```ruby
  client = Dcdental::Client.new # or Dcdental.new
  client.product.list(page: 1, page_size: 5)
```
### response:
```json
[{"manufacturer":"3", "dcd_id":"24155", "dcd_item": "516-31642", "description":"Impregum Penta Medium Body Refill", "active_promotion":"Buy 4 Get 1 Free! (Manufacturer Fulfilled)", "availability":"Green", "pricing_unitprice": "369.40", "schein_code":"3784898", "abc":"3", "dea_required":false, "item_image_thumb":"http://www.dcdental.com/images/270118323234.01.png?resizeid=5", "item_image_full":"http://www.dcdental.com/images/270118323234.01.png", "category_lvl_i":"Impression Material", "category_lvl_ii": "Polyether", "category_lvl_iii":"Impregum" }]
```
## Sales Orders Endpoints
### Get Orders list
#### by customer id
```ruby
  client = Dcdental::Client.new # or Dcdental.new
  client.order.list(customer_id: 1)
```
#### by email
```ruby
  client = Dcdental::Client.new # or Dcdental.new
  client.order.list(email: 'customer@email.com')
```
### by transaction_id
```ruby
  client = Dcdental::Client.new # or Dcdental.new
  client.order.list(transaction_id: '3345CO')
```
#### by pagination
```ruby
  client = Dcdental::Client.new # or Dcdental.new
  client.order.list(page: 1, page_size: 50) # or
  client.order.list(page: 1) # default page_size is 50
  # or get first page
  client.order.list
```
### response:
```json
[{ "internal_id": "52859885", "order_type": "", "tran_date": "11/24/2020", "tran_id": "1099512SO", "entity":"504649", "memo": "", "amount": "101.61","tracking_numbers": "1Z460RY40394704213", "status_ref": "fullyBilled", "ship_date": "11/24/2020", "shipping_cost": ".00", "tax_total": "5.11", "tracking_number_links": [{"tracking_number": "1Z460RY40394704213", "link": "http://wwwapps.ups.com/WebTracking/track?track=yes&trackNums=1Z460RY40394704213" }]}]
```
### Get Order
```ruby
  client = Dcdental::Client.new # or Dcdental.new
  client.order.by_by(1)
```
### response:
```json
{"internal_id": "53068225", "tran_date": "12/24/2020", "tran_id": "1107915SO", "entity": "1103644", "other_ref_num": "123457.0", "total": "8557.95", "status": "Pending Approval", "ship_date": "12/24/2020", "shipping_cost": "0.00", "tax_total": "0.00", line_items: [{ "line": "1", "line_unique_key": "188580698", "item": "24155", "item_display": "516-31642", "description": "Impregum Penta Medium Body Refill", "is_closed": false, "quantity": 50, "quantity_backordered": "", "quantity_billed": 0, "quantity_committed": 0, "quantity_full_filled": 0, "rate": 170.98, "amount": 8549, "custcol_item_manufacturer": "3M", "custcolcustcol_notes": "Sample notes here EC" }]
```
### Create order
```ruby
    order_params = {
      payload_ID, # original system id, for synchronization purposes
      entity, # required. Dcdental customer id
      tran_date, # required. Order transaction date format MM/DD/YYYY
      other_ref_num, # required. Purchase Order number
      memo, # note of the order
      ship_address_list, # required. Dcdental Ship address id
      bill_address_list, # required. Dcdental Bill address id
      items [ # required
        itemid, # required. Dcdental product id
        quantity, # required
        rate,     # required. Unit price
        custcolcustcol_notes # notes
      ]
    }
```
### response:
```
1111111
```
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dcdental.

## License


The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
