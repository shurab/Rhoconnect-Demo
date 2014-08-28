# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
class Product
  # include Rhom::PropertyBag

  # 1. Use fixed schema:
  include Rhom::FixedSchema
  set :schema_version, '1.0'

  # Uncomment the following line to enable sync with Product.
  enable :sync

  #add model specific code here

  # 2. Use fixed schema:
  property :id, :integer
  property :name, :string
  property :brand, :string
  property :price, :string
  property :quantity, :string
  property :sku, :string

  property :created_at, :date #translate to integer type
  property :updated_at, :date #translate to integer type

end
