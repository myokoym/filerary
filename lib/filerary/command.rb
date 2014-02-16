require "thor"
require "filerary/version"
require "filerary/librarian"

module Filerary
  class Command < Thor
    desc "version", "Show version number"
    def version
      puts VERSION
    end

    desc "collect FILE...", "Collect files (takes time)"
    def collect(*files)
      Filerary::Librarian.new.collect(files)
    end

    desc "search WORD", "Search for files in the collection"
    def search(word)
      puts Filerary::Librarian.new.search(word)
    end
  end
end
