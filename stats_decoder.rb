require_relative 'char_stats.rb'
require 'json'

class Decode
  attr_accessor :coded_stats, :uncoded_stats, :uncode_key, :decode
  def intialize
    @source_file = 'coded.txt'
    @output_file = 'decoded.txt'
  end
  def coded_stats
    coded_stats = ReadFile.new('coded.txt')
    coded_stats = coded_stats.get_stats.sort_by {|_key, value| value}.reverse.to_h
    @coded_stats = coded_stats
  end
  def uncoded_stats
    uncoded_file = File.open('stats_file.json')
    uncoded_text = uncoded_file.read
    uncoded_stats = JSON.parse(uncoded_text)
    uncoded_stats = uncoded_stats.sort_by {|_key, value| value}.reverse.to_h
    @uncoded_stats = uncoded_stats
  end
  def uncode_key
      coded_stats = self.coded_stats.keys
      uncoded_stats = self.uncoded_stats.keys
      uncode_key = Hash[coded_stats.zip uncoded_stats ]
      @uncode_key = uncode_key
  end
  def decode
    file = File.open('coded.txt', 'r')
    text = file.read
    file.close
    decoded_text = ''
    text_arr = text.split('')
    key = self.uncode_key
    text_arr.each do |x|
      if key.has_key?(x)
        symbol = key[x]
        decoded_text << symbol.to_s
      else
        decoded_text = decoded_text + x.to_s
      end
    end
      file = File.open('decoded.txt', 'w')
      file.puts decoded_text
      file.close
  end

end

a = Decode.new()
a.decode
