require "fileutils"
require "grn_mini"
require "chupa-text"
gem "chupa-text-decomposer-pdf"
gem "chupa-text-decomposer-libreoffice"

module Filerary
  class Librarian
    attr_reader :db_dir, :db_path
    def initialize(base_dir=default_base_dir)
      @db_dir = File.join(base_dir, "db")
      FileUtils.mkdir_p(@db_dir)

      @db_path = File.join(@db_dir, "filerary.db")
      GrnMini.create_or_open(@db_path)

      @files = GrnMini::Hash.new("Files")
    end

    def collect(paths)
      paths = [paths] if paths.is_a?(String)

      paths.each do |path|
        path = File.expand_path(path)

        next unless File.file?(path)
        next if /\/\.git\// =~ path
        next if @files[path] && @files[path].updated_at > File.mtime(path)

        @files[path] = {
          :content    => read_content(path),
          :updated_at => Time.now,
        }
      end
    end

    def search(word)
      result = @files.select do |record|
        record.content =~ word
      end

      result.collect {|record| record._key }
    end

    def cleanup
      @files.grn.records.each do |record|
        path = record._key
        @files.delete(path) unless File.exist?(path)
      end
    end

    private
    def default_base_dir
      File.join(File.expand_path("~"), ".filerary")
    end

    def read_content(path)
      text = nil

      ChupaText::Decomposers.load

      extractor = ChupaText::Extractor.new
      extractor.apply_configuration(ChupaText::Configuration.default)

      extractor.extract(path) do |text_data|
        text = text_data.body
      end

      return path unless text

      # TODO: I want to specify encoding in ChupaText side.
      text.force_encoding(Encoding.default_external || "UTF-8")

      text
    end
  end
end
