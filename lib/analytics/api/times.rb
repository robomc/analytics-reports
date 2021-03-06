class Times 
  include Arrows, StatGetters
  attr_reader :all_results
  
  def initialize
    @start_date_reporting = $periods.start_date_reporting
    @end_date_reporting = $periods.end_date_reporting
    @start_date_previous = $periods.start_date_previous
    @end_date_previous = $periods.end_date_previous
    @start_date_baseline = $periods.start_date_baseline
    @end_date_baseline = $periods.end_date_baseline
    @reporting_number_of_months = $periods.reporting_number_of_months
    @baseline_number_of_months = $periods.baseline_number_of_months
    
    @all_results = ["You need to run my methods :|"]
    
    @arbitrary = nil
    @reporting = nil
    @previous = nil
    @baseline = nil
    
    @reporting_average = nil
    @previous_average = nil
    @baseline_average = nil
    
    @list_times = Array.new
    @list_visits = Array.new
    
    @visit_totals = Visits.new
    
    @previous_change = nil
    @baseline_change = nil
  end
  
  def to_s
    "#{@all_results}, #{@arbitrary}, #{@reporting}, #{@previous}, #{@baseline}, #{@reporting_average}, #{@previous_average}, #{@baseline_average},  #{@previous_change}%, #{@baseline_change}%, arbitrary? = #{self.arbitrary?}"
  end
    
  def three_with_changes_as_averages

    self.reporting_average
    self.previous_average
    self.baseline_average
    
    @previous_change = Num.percentage_change(@previous_average, @reporting_average)
    @baseline_change = Num.percentage_change(@baseline_average, @reporting_average)
    
    @reporting_average = Num.make_seconds(@reporting_average) #rewrite as ".make_seconds!"
    @previous_average = Num.make_seconds(@previous_average)
    @baseline_average = Num.make_seconds(@baseline_average)
    
    hash = { :title => "Average times", :r =>"#{@reporting_average.strftime("%M:%S")}", 
             :p_change => Num.to_p(@previous_change), :p_value => "#{@previous_average.strftime("%M:%S")}", :p_arrow => self.arrow(@previous_change),
             :b_change => Num.to_p(@baseline_change), :b_value => "#{@baseline_average.strftime("%M:%S")}", :b_arrow => self.arrow(@baseline_change)}

    @all_results = OpenStruct.new(hash)

    @all_results
  end
  
  def reporting_average
    if @reporting_average.nil?
      @list_times = Array.new
      @list_visits = Array.new
    
      @list_visits << @visit_totals.reporting
      @list_times << self.reporting
      @reporting_average = self.make_times_average_sessions[0]
    
      @reporting_average
    end
    @reporting_average
  end
  
  def previous_average
    if @previous_average.nil?
      @list_times = Array.new
      @list_visits = Array.new

      @list_visits << @visit_totals.previous
      @list_times << self.previous
      @previous_average = self.make_times_average_sessions[0]

      @previous_average
    end
    @previous_average
  end
  
  def baseline_average
    if @baseline_average.nil?
      @list_times = Array.new
      @list_visits = Array.new

      @list_visits << @visit_totals.baseline
      @list_times << self.baseline
      
      @baseline_average = self.make_times_average_sessions[0]

      @baseline_average
    end
    @baseline_average
  end
  
  def arbitrary(start_date, end_date)
    #minor report, requires a start_date, end_date
    report = Garb::Report.new($profile.garb,
                              :start_date => start_date,
                              :end_date => end_date)

    if $profile.segment? 
      report.set_segment_id($profile.segment)
    end

    report.metrics :timeOnSite
          
    report.results.each {|thing| @arbitrary = thing.time_on_site}
    @arbitrary.to_f
  end
  
  def reporting
    if @reporting.nil?
      @reporting = self.arbitrary(@start_date_reporting, @end_date_reporting)
    end
    @reporting
  end
  
  def previous
    if @previous.nil?
      @previous = self.arbitrary(@start_date_previous, @end_date_previous)
    end
    @previous    
  end
  
  def baseline
    if @baseline.nil?
      @baseline = self.arbitrary(@start_date_baseline, @end_date_baseline)
    end
    @baseline    
  end
  
  def up_is_nothing?
    return false
  end
  
  def up_is_good?
    return true
  end
  
  def arbitrary?
    return true
  end
  
end