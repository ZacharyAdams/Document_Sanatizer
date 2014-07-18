require './content'
class Sanitizer
  attr_accessor :output
  @content = nil
  @output = []
  class << self
    def start(document_file, blacklist_file)
      @content = Content.new(document_file, blacklist_file)
      sanitize_now(document_file)
    end

    def sanitize_now(document_file)
      file = document_file
      reader = File.open(file, 'rb')
      reader.each_line do |line|
        line_output = line
        black_objects = @content.blacklisted_objects
        black_objects.each do |black_object|

          if line.match(black_object.content)
            black_object.content.split(" ").each do |word|
              line_output = line_output.gsub(word, 'XXXXX')
            end
          end
        end
        @output << line_output
      end
      build_output(@output)
    end

    def build_output(sanitized_text)
      file = File.open('output.txt', 'w+')
      sanitized_text.each do |text|
        file.write(text)
      end
      file.close
    end
  end
end
