class CalculationsController < ApplicationController



  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]
    @text_lc = @text.downcase
    @special_word_lc = @special_word.downcase

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ", "").length

    @word_count = @text.split.length

    @occurrences = @text_lc.split.count(@special_word_lc)
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f
    @monthlyrate = @apr/1200
    @months = @years * 12

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = @principal * (@monthlyrate+(@monthlyrate/(((1+@monthlyrate)**@months)-1)))
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @seconds/(365.25*24*60*60)
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    @median = (@sorted_numbers[(@numbers.length - 1) / 2] + @sorted_numbers[@numbers.length / 2]) / 2.0

    def sum(list_of_numbers)
     running_total = 0
     list_of_numbers.each do |number|
       running_total = running_total + number
                          end
     return running_total
    end

    @sum = @numbers.sum

    @mean = @sum/@numbers.length

    squared_deltas = []

    @numbers.each do |number|
      delta_squared = (number - @mean) **2
      squared_deltas.push(delta_squared)
    end

    @variance = squared_deltas.sum/@count

    @standard_deviation = @variance ** 0.5

    mode = 0
    mode_counter = 0

    @numbers.each do |number|
      frequency = @numbers.count(number)
      if frequency > mode_counter
        mode = number
        mode_counter = frequency
      end
    end

    @mode = mode
  end
end
