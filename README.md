# Filerarian

A fulltext search tool for local files that contains text.

For example, .txt, .pdf, .xls and so on.

## Requirements

* [GrnMini](https://github.com/ongaeshi/grn_mini)
  * [Rroonga](http://ranguba.org/)
* Ruby/Poppler in [Ruby-GNOME2](http://ruby-gnome2.sourceforge.jp/)
* [Spreadsheet](https://github.com/zdavatz/spreadsheet)
* [Thor](http://whatisthor.com/)

## Installation

Add this line to your application's Gemfile:

    gem 'filerarian'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install filerarian

## Usage

### Collect files (takes time)

    $ filerarian collect FILE...

### Search for files in the collection

    $ filerarian search WORD

## License

Copyright (c) 2014  Masafumi Yokoyama

GPLv3.

See 'Licenses/gpl-3.0.txt' or 'http://www.gnu.org/licenses/gpl-3.0' for details.

## Contributing

1. Fork it ( http://github.com/myokoym/filerarian/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
