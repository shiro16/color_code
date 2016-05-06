require 'spec_helper'

describe ColorCode::Distance do
  let(:black) { ColorCode::RGB.new() }
  let(:white) { ColorCode::RGB.new(r: 255, g: 255, b: 255) }

  before do
    ColorCode::Distance.configure do |config|
      config.colors = [
        { id: :black, color: black },
        { id: :white, color: white }
      ]
    end
  end

  describe '.results' do
    it { expect(ColorCode::Distance.results(black)).to eq([[:black, 0.0], [:white, 441.6729559300637]]) }
    it { expect(ColorCode::Distance.results(white)).to eq([[:white, 0.0], [:black, 441.6729559300637]]) }
  end

  describe '.min' do
    it { expect(ColorCode::Distance.min(black)).to eq([:black, 0.0]) }
    it { expect(ColorCode::Distance.min(white)).to eq([:white, 0.0]) }
  end

  describe '.max' do
    it { expect(ColorCode::Distance.max(black)).to eq([:white, 441.6729559300637]) }
    it { expect(ColorCode::Distance.max(white)).to eq([:black, 441.6729559300637]) }
  end
end
