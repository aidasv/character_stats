require 'json'

class ReadFile
  attr_accessor :file, :text, :word_hsh
    def initialize(file_name)
      @file = File.open(file_name, 'r')
      @text = @file.read
    end

    def text_to_hash
      @text = @text.chomp.downcase
      @text.gsub!(/[^a-zA-Z]/, '')
      @word_hsh = Hash.new(0)
      @text = @text.split('')
      @count_all = @text.length
      @text.each {|x| word_hsh[x] += 1}
      return @word_hsh
    end

    def get_stats
      @stats = Hash.new(0)
      self.text_to_hash.each{ |k,v| @word_hsh[k] = (v.to_f * 100 / @count_all.to_f).round(3) }
      @word_hsh.sort.to_h
    end
  end

  #  a=ReadFile.new(ARGV[0])
    #file = File.open(ARGV[1], 'w')
    #file.puts a.get_stats.to_json
    #file.close
