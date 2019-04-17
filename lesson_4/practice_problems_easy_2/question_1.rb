class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

#  What is the result of calling

oracle = Oracle.new
p oracle.predict_the_future

# Result of calling method perdic_the_future will be string 'You will <random>' 
# where random is random string object from array in method choices on line 7