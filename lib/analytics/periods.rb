class Periods
  attr_accessor :start_date_reporting, :end_date_reporting, :start_date_previous, :end_date_previous, :start_date_baseline, :end_date_baseline, :reporting_number_of_months, :baseline_number_of_months

#the date ranges class - holds all the dates... called on by data initialize methods
#to populate their dates...
#never really made use of the various getter aliases I made in here...

#
#   should always be initialized as $periods
#

  def initialize(start_date_reporting = Date.new, 
                 end_date_reporting = Date.new,
                 start_date_previous = Date.new,
                 end_date_previous = Date.new,
                 start_date_baseline = Date.new,
                 end_date_baseline = Date.new,
                 reporting_number_of_months = 0,
                 baseline_number_of_months = 0)

    @start_date_reporting = start_date_reporting
    @end_date_reporting = end_date_reporting
    @start_date_previous = start_date_previous
    @end_date_previous = end_date_previous
    @start_date_baseline = start_date_baseline
    @end_date_baseline = end_date_baseline
    @reporting_number_of_months = reporting_number_of_months
    @baseline_number_of_months = baseline_number_of_months
  end

  def to_s
    "(#{@start_date_reporting}, #{@end_date_reporting}, #{@start_date_previous}, #{@end_date_previous}, #{@start_date_baseline}, #{@end_date_baseline},#{@reporting_number_of_months}, #{@baseline_number_of_months})"
  end
  
  def inspect
    puts "@start_date_reporting = #{@start_date_reporting}"
    puts "@end_date_reporting = #{@end_date_reporting}"
    puts "@start_date_previous = #{@start_date_previous}"
    puts "@end_date_previous = #{@end_date_previous}"
    puts "@start_date_baseline = #{@start_date_baseline}"
    puts "@end_date_baseline = #{@end_date_baseline}"
    puts "@reporting_number_of_months = #{@reporting_number_of_months}"
    puts "@baseline_number_of_months = #{@baseline_number_of_months}"
  end
  
  def reporting
    reporting = { "start" => @start_date_reporting, "end" => @end_date_reporting}
  end
  
  def reporting_start
    @start_date_reporting
  end
  
  def reporting_end
    @end_date_reporting
  end
  
  def previous
    previous = { "start" => @start_date_previous, "end" => @end_date_previous}
  end
  
  def previous_start
    @start_date_previous
  end
  
  def previous_end
    @end_date_previous
  end
  
  def baseline
    baseline = { "start" => @start_date_baseline, "end" => @end_date_baseline}
  end
  
  def baseline_start
    @start_date_baseline
  end
  
  def baseline_end
    @end_date_baseline
  end
      
  def ranges
    ranges = { "reporting" => @reporting_number_of_months, "baseline" => @baseline_number_of_months}
  end
  
  def range_reporting
    @reporting_number_of_months
  end
  
  def range_baseline
    @baseline_number_of_months
  end
  
end