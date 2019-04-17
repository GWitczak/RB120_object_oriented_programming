class Banner
  attr_reader :width, :message
  

  def initialize(message, banner_width = message.size)
    @message = message
    @width = set_width(banner_width)
  end

  def set_width(banner_width)
    if banner_width < message.size || banner_width > 78
      return message.size
    else
      return banner_width
    end
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+-#{'-' * width}-+"
  end

  def empty_line
    "| #{' ' * width} |"
  end

  def message_line
    "| #{@message.center(width)} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.', 30)
puts banner

banner = Banner.new('', 70)
puts banner