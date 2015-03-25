require 'spec_helper'

describe ColorCode::HSL do
  let(:hue) { rand(360) }
  let(:saturation) { rand(100) }
  let(:luminance) { rand(100) }

  describe '#initialize' do
    context 'parameter code' do
      subject { ColorCode::HSL.new('#ff0000') }

      it { expect(subject.h).to eq(0) }
      it { expect(subject.s).to eq(100) }
      it { expect(subject.l).to eq(50) }
    end

    context 'parameter hsl' do
      subject { ColorCode::HSL.new(h: hue, s: saturation, l: luminance) }

      it { expect(subject.h).to eq(hue) }
      it { expect(subject.s).to eq(saturation) }
      it { expect(subject.l).to eq(luminance) }
    end

    context 'hsl over some velue' do
      subject { ColorCode::HSL.new(h: 361, s: 101, l: 101) }

      it { expect{ subject }.to raise_error(ArgumentError) }
    end
  end

  describe '#to_s' do
    subject { ColorCode::HSL.new(h: 0, s: 100, l: 50).to_s }

    it { expect(subject).to eq('#ff0000') }
  end

  describe '#to_a' do
    subject { ColorCode::HSL.new(h: hue, s: saturation, l: luminance).to_a }

    it { expect(subject).to eq([hue, saturation, luminance])}
  end

  describe '#to_hash' do
    subject { ColorCode::HSL.new(h: hue, s: saturation, l: luminance).to_hash }

    it { expect(subject).to eq({h: hue, s: saturation, l: luminance}) }
  end

  describe '#to_rgb' do
    subject { ColorCode::HSL.new(h: 0, s: 100, l: 50).to_rgb }

    it { expect(subject.r).to eq(255) }
    it { expect(subject.g).to eq(0) }
    it { expect(subject.b).to eq(0) }
  end

  context 'private methods' do
    describe '#convert_rgb' do
      context 'luminance under 50' do
        let(:luminance) { 25 }

        it 'hue 0-59' do
          hsl = ColorCode::HSL.new(h: 30, s: 50, l: luminance)
          expect(hsl.send(:convert_rgb)).to eq([96, 64, 32])
        end

        it 'hue 60-119' do
          hsl = ColorCode::HSL.new(h: 90, s: 50, l: luminance)
          expect(hsl.send(:convert_rgb)).to eq([64, 96, 32])
        end

        it 'hue 120-179' do
          hsl = ColorCode::HSL.new(h: 150, s: 50, l: luminance)
          expect(hsl.send(:convert_rgb)).to eq([32, 96, 64])
        end

        it 'hue 180-239' do
          hsl = ColorCode::HSL.new(h: 210, s: 50, l: luminance)
          expect(hsl.send(:convert_rgb)).to eq([32, 64, 96])
        end

        it 'hue 240-299' do
          hsl = ColorCode::HSL.new(h: 270, s: 50, l: luminance)
          expect(hsl.send(:convert_rgb)).to eq([64, 32, 96])
        end

        it 'hue 300-359' do
          hsl = ColorCode::HSL.new(h: 330, s: 50, l: luminance)
          expect(hsl.send(:convert_rgb)).to eq([96, 32, 64])
        end
      end

      context 'luminance over 50' do
        let(:luminance) { 75 }

        it 'hue 0-59' do
          hsl = ColorCode::HSL.new(h: 30, s: 50, l: luminance)
          expect(hsl.send(:convert_rgb)).to eq([223, 191, 159])
        end

        it 'hue 60-119' do
          hsl = ColorCode::HSL.new(h: 90, s: 50, l: luminance)
          expect(hsl.send(:convert_rgb)).to eq([191, 223, 159])
        end

        it 'hue 120-179' do
          hsl = ColorCode::HSL.new(h: 150, s: 50, l: luminance)
          expect(hsl.send(:convert_rgb)).to eq([159, 223, 191])
        end

        it 'hue 180-239' do
          hsl = ColorCode::HSL.new(h: 210, s: 50, l: luminance)
          expect(hsl.send(:convert_rgb)).to eq([159, 191, 223])
        end

        it 'hue 240-299' do
          hsl = ColorCode::HSL.new(h: 270, s: 50, l: luminance)
          expect(hsl.send(:convert_rgb)).to eq([191, 159, 223])
        end

        it 'hue 300-359' do
          hsl = ColorCode::HSL.new(h: 330, s: 50, l: luminance)
          expect(hsl.send(:convert_rgb)).to eq([223, 159, 191])
        end
      end
    end
  end
end
