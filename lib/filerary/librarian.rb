require "fileutils"
require "uri"
require "grn_mini"
require "chupa-text"
gem "chupa-text-decomposer-pdf"
gem "chupa-text-decomposer-libreoffice"

# TODO: I'll send pull request to ChupaText.
module URI
  class Generic
    alias :__path__ :path
    def path
      URI.decode_www_form_component(__path__, Encoding.find("locale"))
    end
  end

  def self.parse(uri)
    uri = URI.encode_www_form_component(uri)
    DEFAULT_PARSER.parse(uri)
  end
end

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

      result.collect do |record|
        record._key.force_encoding(Encoding.find("locale"))
      end
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
      text.force_encoding(Encoding.default_external)
      text.force_encoding("UTF-8") unless text.valid_encoding?

      text
    end
  end
end
