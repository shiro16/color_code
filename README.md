# ColorCode

simple handle the color code

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'color_code'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install color_code

## Usage

RGB class

```ruby
rgb = ColorCode::RGB.new(r: 255, g: 0, b: 0)
rgb.to_s # => '#ff0000'
rbg.to_hash # => { r: 255, g: 0, b: 0 }
```

HSL class

```ruby
hsl = ColorCode::HSL.new(h: 0, s: 100, l: 50)
hsl.to_s # => '#ff0000'
hsl.to_hash # => { h: 0, s: 100, l: 50 }
```

convert RGB to HSL

```ruby
rgb = ColorCode::RGB.new(r: 255, g: 0, b: 0) 
rgb.to_s # => '#ff0000'
hsl = rgb.to_hsl
hsl.to_s # => '#ff0000' 
```

convert HSL to RGB

```ruby
hsl = ColorCode::HSL.new(h: 0, s: 100, l: 50) 
hsl.to_s # => '#ff0000'
rgb = hsl.to_rgb
rgb.to_s # => '#ff0000'
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/color_code/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
