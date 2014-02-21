require "thor"
require "filerary/version"
require "filerary/librarian"

module Filerary
  class Command < Thor
    desc "version", "Show version number"
    def version
      puts VERSION
    end

    desc "list", "List filenames in the collection"
    def list
      puts Filerary::Librarian.new.list
    end

    desc "collect FILE...", "Collect files (takes time)"
    def collect(*files)
      Filerary::Librarian.new.collect(files)
    end

    desc "search WORD", "Search for files in the collection"
    def search(word)
      puts Filerary::Librarian.new.search(word)
    end

    desc "cleanup", "Remove deleted files in the collection"
    def cleanup
      Filerary::Librarian.new.cleanup
    end

    desc "remove", "Remove a file in the collection"
    def remove(path)
      Filerary::Librarian.new.remove(path)
    end
  end
end
