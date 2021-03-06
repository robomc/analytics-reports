class Format
  attr_reader :green_up, :green_down, :red_up, :red_down, :grey_up, :grey_down, :equals
  attr_accessor :collector    #
                              # Don't access the report data from this getter, it is only there
                              # for slipping in literal report content in extreme cases
                              # Use $collector.output of $collector.your_formatting_child_class instead
                              #

  def initialize

    #make sure there is a collector object, if not, make one

    if !defined? $collector
      $display << "The collector is not defined. I am instantiating it now..."
      $collector = OpenStruct.new
      $collector.output = String.new #this is so there is always an easy compatible print method in report classes
                                    # you dump output in here always, in your finish method
    end

    @collector = String.new #this is the local collector
                            #to 'go global', run self.finish

    #set values for arrows

    @green_up = "green_up"
    @green_down = "green_down"
    @red_up = "red_up"
    @red_down = "red_down"
    @grey_up = "grey_up"
    @grey_down = "grey_down"
    @equals = "equals"
  end

  def finish
    $display.tell_user "Putting output in to $collector. Access with $collector.output"
    $collector.output = @collector
  end

end

