# Filerary

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

```ruby
gem 'filerary'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install filerary
```

## Usage

### Collect files (takes time)

```bash
$ filerary collect FILE...
```

### Search for files in the collection (very fast!)

```bash
$ filerary search WORD
```

### Unregister not existing files in the collection

```bash
$ filerary cleanup
```

## Authors

Copyright (c) 2014  Masafumi Yokoyama (myokoym@gmail.com)

## License

This software is distributed under the GPLv3.
Please see the [LICENSE] (https://github.com/myokoym/filerary/blob/master/LICENSE.txt) file.

## Contributing

1. Fork it ( http://github.com/myokoym/filerary/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
