# Alyssa looked at the code and spotted a mistake. "This will fail when update_quantity is called", she says.
# Can you spot the mistake and how to address it?

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end

# That's because only getter method for quantity instance variable is created and on line 14
# we are trying to use setter method to reasign quantity value but it not exists, so instead of this
# Ruby will treat quantity as a new local variable that won't change instance variable quantity value.
# To do this correctly we would have to define setter method for quantity instance variable and add prefix
# self. or @ before that instance variable name.