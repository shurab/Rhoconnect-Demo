require 'json'
require 'rest_client'

class Product < Rhoconnect::Model::Base
  def initialize(source)
    # Backend rails server is running locally:
    #@base = 'http://localhost:3000/products'

    # Backend rails server is running omn Heroku:
    @base = 'http://rhostore.herokuapp.com/products'
    super(source)
  end

  def login
    puts "Product#login ..."
  end

  def query(params=nil)
    rest_result = RestClient.get("#{@base}.json").body
    raise Rhoconnect::Model::Exception.new("Error connecting!") if rest_result.code != 200
    parsed = JSON.parse(rest_result)

    puts "Product#query: "
    puts parsed
    # =>
    # {"product"=>{"brand"=>"Samsung", "created_at"=>"2014-03-13T00:23:09Z", "id"=>1, "name"=>"Galaxy S5", "price"=>"$199.99", "quantity"=>"100", "sku"=>"ABC", "updated_at"=>"2014-03-13T00:34:07Z"}}
    # {"product"=>{"brand"=>"Apple", "created_at"=>"2014-03-13T00:27:28Z", "id"=>2, "name"=>"iPhone 5S ", "price"=>"$299.99", "quantity"=>"11", "sku"=>"XYZ", "updated_at"=>"2014-03-13T00:27:28Z"}}
    # {"product"=>{"brand"=>"Google", "created_at"=>"2014-03-13T00:35:33Z", "id"=>3, "name"=>"Nexus 5", "price"=>"$99.99", "quantity"=>"5", "sku"=>"POIUYT", "updated_at"=>"2014-03-13T00:35:33Z"}}


    @result = {}
    parsed.each do |item|
      @result[item["product"]["id"].to_s] = item["product"]
    end if parsed
    puts "@result: "
    puts @result
    # =>
    # {"1"=>{"brand"=>"Samsung", "created_at"=>"2014-03-13T00:23:09Z", "id"=>1, "name"=>"Galaxy S5", "price"=>"$199.99", "quantity"=>"100", "sku"=>"ABC", "updated_at"=>"2014-03-13T00:34:07Z"},
    #  "2"=>{"brand"=>"Apple", "created_at"=>"2014-03-13T00:27:28Z", "id"=>2, "name"=>"iPhone 5S ", "price"=>"$299.99", "quantity"=>"11", "sku"=>"XYZ", "updated_at"=>"2014-03-13T00:27:28Z"},
    #  "3"=>{"brand"=>"Google", "created_at"=>"2014-03-13T00:35:33Z", "id"=>3, "name"=>"Nexus 5", "price"=>"$99.99", "quantity"=>"5", "sku"=>"POIUYT", "updated_at"=>"2014-03-13T00:35:33Z"}}
  end

  def create(create_hash)
    puts "Product#create: create_hash: #{create_hash}"
    # =>
    # Product.create: create_hash: {"brand"=>"Google", "name"=>"Nexus 5", "price"=>"$99.99", "quantity"=>"5", "sku"=>"POIUYT"}

    res = RestClient.post(@base, :product => create_hash)
    puts res
    # =>
    # <?xml version="1.0" encoding="UTF-8"?>
    # <product>
    #   <brand>Google</brand>
    #   <created-at type="datetime">2014-03-13T00:35:33Z</created-at>
    #   <id type="integer">3</id>
    #   <name>Nexus 5</name>
    #   <price>$99.99</price>
    #   <quantity>5</quantity>
    #   <sku>POIUYT</sku>
    #   <updated-at type="datetime">2014-03-13T00:35:33Z</updated-at>
    # </product>
    puts "#{res.headers[:location]}.json"
    # =>
    # http://localhost:3000/products/3.json

    # After create we are redirected to the new record.
    # We need to get the id of that record and return
    # it as part of create so rhoconnect can establish a link
    # from its temporary object on the client to this newly
    # created object on the server
    body = RestClient.get("#{res.headers[:location]}.json").body
    puts "body: #{body}"
    # =>
    # body: {"product":{"brand":"Google","created_at":"2014-03-13T00:35:33Z","id":3,"name":"Nexus 5",
    #  "price":"$99.99","quantity":"5","sku":"POIUYT","updated_at":"2014-03-13T00:35:33Z"}}

    # JSON.parse(
    #     RestClient.get("#{res.headers[:location]}.json").body
    #   )["product"]["id"]
    JSON.parse(body)["product"]["id"]
  end

  def update(update_hash)
    puts "Product#update: #{update_hash}"
    # =>
    # Product.update: {"quantity"=>"100", "id"=>"1"}
    obj_id = update_hash['id']
    update_hash.delete('id')
    RestClient.put("#{@base}/#{obj_id}",:product => update_hash)
  end

  def delete(delete_hash)
    puts "Product#delete: #{delete_hash}"
    # =>
    # {"brand"=>"...", "created_at"=>"2014-03-13T21:41:55Z", "name"=>"...", "price"=>"...", "quantity"=>"...", "sku"=>"...", "updated_at"=>"2014-03-13T21:41:55Z", "id"=>"4"}

    RestClient.delete("#{@base}/#{delete_hash['id']}")
  end

  def logoff
    puts "Product#logoff."
  end

  def store_blob(object,field_name,blob)
    # TODO: Handle post requests for blobs here.
    # make sure you store the blob object somewhere permanently
    raise "Please provide some code to handle blobs if you are using them."
  end
end