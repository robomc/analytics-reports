class Array

  def average
    @total = 0

    self.each do |thing|
      @total += thing.to_f
    end

    average = @total.to_f/self.size.to_f

    average
  end

  def sum
    self.inject {|sum, x| x = x.to_f; sum + x }
  end

end

