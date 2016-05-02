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

### RGB class

```ruby
rgb = ColorCode::RGB.new(r: 255, g: 0, b: 0)
rgb.to_s # => '#ff0000'
rbg.to_hash # => { r: 255, g: 0, b: 0 }
```

### HSV class

```ruby
hsv = ColorCode::HSV.new(h: 0, s: 100, v: 100)
hsv.to_s # => '#ff0000'
hsv.to_hash # => { h: 0, s: 100, v: 100 }
```

### HSL class

```ruby
hsl = ColorCode::HSL.new(h: 0, s: 100, l: 50)
hsl.to_s # => '#ff0000'
hsl.to_hash # => { h: 0, s: 100, l: 50 }
```

### convert RGB to HSV

```ruby
rgb = ColorCode::RGB.new(r: 255, g: 0, b: 0)
rgb.to_s # => '#ff0000'
hsv = rgb.to_hsv
hsv.to_s # => '#ff0000'
```

### convert HSL to RGB

```ruby
hsv = ColorCode::HSV.new(h: 0, s: 100, v: 100)
hsv.to_s # => '#ff0000'
rgb = hsv.to_rgb
rgb.to_s # => '#ff0000'
```

### convert RGB to HSL

```ruby
rgb = ColorCode::RGB.new(r: 255, g: 0, b: 0)
rgb.to_s # => '#ff0000'
hsl = rgb.to_hsl
hsl.to_s # => '#ff0000'
```

### convert HSL to RGB

```ruby
hsl = ColorCode::HSL.new(h: 0, s: 100, l: 50)
hsl.to_s # => '#ff0000'
rgb = hsl.to_rgb
rgb.to_s # => '#ff0000'
```


## Contributing

1. Fork it ( https://github.com/shiro16/color_code/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
