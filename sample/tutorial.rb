require "filerarian"

filerarian = Filerarian::Obj.new

base_dir = File.join(File.dirname(__FILE__), "..")
filerarian.collect(Dir.glob("#{base_dir}/*"))

p filerarian.search("require")
p filerarian.search("Windows")
