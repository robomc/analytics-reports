class Fop < XML
  include GoogleChart

  def bar_series(struct)
        #gets a url for a bargraph from the google charts api
        #expects an ostruct containing:

        # title, series (an array of values)

    src = GoogleChart.bar_series(struct.title, struct.data[0])

    @x.series_graph{
      @x.external_graphic(:src => src )
    }
  end
  
  def comparison(array)

    #prints a bar divided between two proportions
    #expects an array with 3, and only 3, values

    if array.length != 3
      raise "Passed the Fop.relative method an array that is the wrong length. It should be three."
    end

      #make changes to the values so one is 100, one is itself

    src = GoogleChart.comparison("#{array[0]}" + " / " + "#{array[1]}", array[2], array[0], array[1])
    
    @x.comparison_bar{
      @x.external_graphic(:src => src)
    }
  end
  

  def main_graph(struct)

    #makes the big three line graph

    #intended to make a lingraph with to flat averages
    #but could make a genuine three line graph if passed right

    #recieves ostruct containing .title (string)
    #                            .key (array of strings)
    #                            .data (an array of arrays - each array contains the data values)

    @x.linegraph{
      @x.title(struct.title)
      @x.data{
        i = 0
        struct.data.each do |data|

          @x.line(  "id"=>"#{struct.keys[i]}"  ){
           data.each do |x|
              @x.value(x)
          end
          }
          i+=1
        end
      }
    }
    
    src = GoogleChart.large_linegraph(struct.title, struct.data[0], struct.data[0], struct.data[1], struct.keys[2], struct.keys[1], struct.keys[2])
    
    @x.main_graph{
      @x.external_graphic(:src => src)
    }
  end
  
  

  def finish
    $display.tell_user "Putting fop-ready xml output in to $collector. Access with $collector.fop"
    $collector.fop = @collector.gsub('&amp;', '&') #washing out the escape sequences...
  end
  
  

end

