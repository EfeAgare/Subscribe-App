class ReadFile

  def initialize()
    @list = []
  end

  def read(number)
    File.foreach(File.dirname(__FILE__) + "/input_files/input_#{number}.txt") do |line|
       @list << line
    end
    @list
  end
end