class Blacklist
  attr_accessor :content

  def initialize(word)
    @content = word
  end

  class << self
    def is_blacklisted?(word)
      word == @content
    end
  end
end
