require "thor"
require "filerarian/version"
require "filerarian/obj"

module Filerarian
  class Command < Thor
    desc "version", "Show version number"
    def version
      puts VERSION
    end

    desc "collect FILE...", "Collect files (takes time)"
    def collect(*files)
      Filerarian::Obj.new.collect(files)
    end

    desc "search WORD", "Search for files in the collection"
    def search(word)
      puts Filerarian::Obj.new.search(word)
    end
  end
end
