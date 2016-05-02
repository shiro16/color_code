require 'spec_helper'

describe ColorCode::HSV do
  let(:hue) { rand(360) }
  let(:saturation) { rand(100) }
  let(:value) { rand(100) }

  describe '#initialize' do
    context 'parameter code' do
      subject { ColorCode::HSV.new('#ff0000') }

      it { expect(subject.h).to eq(0) }
      it { expect(subject.s).to eq(100) }
      it { expect(subject.v).to eq(100) }
    end

    context 'parameter hsv' do
      subject { ColorCode::HSV.new(h: hue, s: saturation, v: value) }

      it { expect(subject.h).to eq(hue) }
      it { expect(subject.s).to eq(saturation) }
      it { expect(subject.v).to eq(value) }
    end

    context 'hsv over some velue' do
      subject { ColorCode::HSV.new(h: 361, s: 101, v: 101) }

      it { expect{ subject }.to raise_error(ArgumentError) }
    end
  end

  describe '#to_s' do
    subject { ColorCode::HSV.new(h: 0, s: 100, v: 100).to_s }

    it { expect(subject).to eq('#ff0000') }
  end

  describe '#to_a' do
    subject { ColorCode::HSV.new(h: hue, s: saturation, v: value).to_a }

    it { expect(subject).to eq([hue, saturation, value])}
  end

  describe '#to_hash' do
    subject { ColorCode::HSV.new(h: hue, s: saturation, v: value).to_hash }

    it { expect(subject).to eq({h: hue, s: saturation, v: value}) }
  end

  describe '#to_rgb' do
    subject { ColorCode::HSV.new(h: 0, s: 100, v: 100).to_rgb }

    it { expect(subject.r).to eq(255) }
    it { expect(subject.g).to eq(0) }
    it { expect(subject.b).to eq(0) }
  end

  context 'private methods' do
    describe '#convert_rgb' do
      it 'hue 0-59' do
        hsv = ColorCode::HSV.new(h: 30, s: 50, v: 50)
        expect(hsv.send(:convert_rgb)).to eq([128, 96, 64])
      end

      it 'hue 60-119' do
        hsv = ColorCode::HSV.new(h: 90, s: 50, v: 50)
        expect(hsv.send(:convert_rgb)).to eq([96, 128, 64])
      end

      it 'hue 120-179' do
        hsv = ColorCode::HSV.new(h: 150, s: 50, v: 50)
        expect(hsv.send(:convert_rgb)).to eq([64, 128, 96])
      end

      it 'hue 180-239' do
        hsv = ColorCode::HSV.new(h: 210, s: 50, v: 50)
        expect(hsv.send(:convert_rgb)).to eq([64, 96, 128])
      end

      it 'hue 240-299' do
        hsv = ColorCode::HSV.new(h: 270, s: 50, v: 50)
        expect(hsv.send(:convert_rgb)).to eq([96, 64, 128])
      end

      it 'hue 300-359' do
        hsv = ColorCode::HSV.new(h: 330, s: 50, v: 50)
        expect(hsv.send(:convert_rgb)).to eq([128, 64, 96])
      end
    end
  end
end
