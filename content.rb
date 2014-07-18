require './blacklist'
class Content
  attr_accessor :document
  attr_accessor :blacklisted_objects
  def initialize(document_file, blacklist_file)
    @blacklisted_objects = []
    build_blacklist_objects(blacklist_file)
    @document = document_file
  end

  def build_blacklist_objects(blacklist_file)
    blacklist_file = File.open(blacklist_file, 'rb')
    puts "reading from line"
    blacklist_file.each_line do |line|
      elements = line.tr(%q{"'}, '').chomp('\n').split(",").map(&:strip)
      elements.each do |element|
        black_object = Blacklist.new(element)
        @blacklisted_objects << black_object
      end
    end
  end

end
