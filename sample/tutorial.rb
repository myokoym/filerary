require "filerary"

filerary = Filerary::Librarian.new

base_dir = File.join(File.dirname(__FILE__), "..")
filerary.collect(Dir.glob("#{base_dir}/*"))

p filerary.search("require")
p filerary.search("Windows")
