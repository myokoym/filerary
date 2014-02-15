require "fileutils"
require "grn_mini"
require "poppler"
require "spreadsheet"

module Filerarian
  class Obj
    def initialize
      db_dir = File.join(File.expand_path("~"), ".filerarian", "db")
      FileUtils.mkdir_p(db_dir)

      db_path = File.join(db_dir, "filerarian.db")
      GrnMini.create_or_open(db_path)

      @files = GrnMini::Hash.new("Files")
    end

    def collect(paths)
      paths = [paths] if paths.is_a?(String)

      paths.each do |path|
        path = File.expand_path(path)

        next unless File.file?(path)
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

    private
    def read_content(path)
      text = nil

      if text?(path)
        text = File.open(path).read
      elsif pdf?(path)
        text = read_pdf(path)
      elsif xls?(path)
        text = read_xls(path)
      else
        text = path
      end

      text
    end

    def text?(path)
      File.open(path).read.valid_encoding? && /\.tar\z/i !~ path
    end

    def pdf?(path)
      /\.pdf\z/i =~ path
    end

    def xls?(path)
      /\.xls\z/i =~ path
    end

    def read_pdf(path)
      text = ""
      document = Poppler::Document.new(path)
      document.each do |page|
        text << page.get_text
      end
      text
    end

    def read_xls(path)
      text = ""
      Spreadsheet.client_encoding = Encoding.find("locale")
      book = Spreadsheet.open(path)
      book.worksheets.each do |worksheet|
        worksheet.rows.each do |row|
          text << row.join << "\n"
        end
      end
      text
    end
  end
end