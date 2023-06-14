class Holiday
  attr_reader :name,
              :deactivated
  
  def initialize(data)
    @name = data(:localName)
    @date = data(:date)
  end
end