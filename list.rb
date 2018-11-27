class List
  attr_reader :first_name, :last_name, :scope_id, :email
  def initialize(attributes = {})
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @scope_id = attributes[:scope_id]
    @email = attributes[:email]
  end
end
