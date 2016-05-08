class FileCoder
  attr_accessor :code, :decode
  def self.code(source_file = ARGV[0], output_file = ARGV[1])
    file = File.open(source_file, 'r')
    source = file.read
    file.close
    #source = source.gsub(/\W+/, '').downcase
    source = source.downcase
    char_arr = source.split('')
    coded_arr = Array.new
    char_arr.each do |x|
      if x.ord > 96 && x.ord < 122
        coded_arr.push (x.ord + 1).chr
      elsif x == "z"
        coded_arr.push "a"
      else
        coded_arr.push x
      end
    end
    file = File.open(output_file, 'w')
    file.puts coded_arr.join('')
    file.close
  end

  def self.decode(source_file = ARGV[0], output_file = ARGV[1])
    file = File.open(source_file, 'r')
    source = file.read
    file.close
    char_arr = source.split('')
    decoded_arr = Array.new
    char_arr.each do |x|
      if x!="a"
        decoded_arr.push (x.ord - 1).chr
      else
        decoded_arr.push "z"
      end
    end
    file = File.open(output_file, 'w')
    file.puts decoded_arr.join('')
    file.close
  end
end

FileCoder.code
