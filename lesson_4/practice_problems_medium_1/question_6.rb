# What is the difference in the way the code works?

class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end

# There's actually no difference in the result, only in the way each example accomplishes the task. 
# And general rule is to avoid self where not required, so first option is prefered.