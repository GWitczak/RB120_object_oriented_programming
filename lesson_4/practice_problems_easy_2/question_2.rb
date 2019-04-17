class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

#  What is the result of the following:

trip = RoadTrip.new
p trip.predict_the_future

# Result of calling method perdic_the_future on trip will be string 'You will <random>' 
# Since in subclass of Oracle - RoadTrip class we redefined method choice 
# now random will be random string object form array on line 13