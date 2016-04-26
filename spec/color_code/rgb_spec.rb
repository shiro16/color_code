require 'spec_helper'

describe ColorCode::RGB do
  let(:red) { rand(255) }
  let(:green) { rand(255) }
  let(:blue) { rand(255) }

  describe '#initialize' do
    context 'parameter code' do
      subject { ColorCode::RGB.new('#ff1001') }

      it { expect(subject.r).to eq(255) }
      it { expect(subject.g).to eq(16) }
      it { expect(subject.b).to eq(1) }
    end

    context 'parameter rbg' do
      subject { ColorCode::RGB.new(r: red, g: green, b: blue) }

      it { expect(subject.r).to eq(red) }
      it { expect(subject.g).to eq(green) }
      it { expect(subject.b).to eq(blue) }
    end

    context 'rgb over 255' do
      subject { ColorCode::RGB.new(r: 256, g: 256, b: 256) }

      it { expect{ subject }.to raise_error(ArgumentError) }
    end
  end

  describe '#to_s' do
    subject { ColorCode::RGB.new(r: 255).to_s }

    it { expect(subject).to eq('#ff0000') }
  end

  describe '#to_a' do
    subject { ColorCode::RGB.new(r: red, g: green, b: blue).to_a }

    it { expect(subject).to eq([red, green, blue]) }
  end

  describe '#to_hash' do
    subject { ColorCode::RGB.new(r: red, g: green, b: blue).to_hash }

    it { expect(subject).to eq({ r: red, g: green, b: blue }) }
  end

  describe '#to_hsl' do
    subject { ColorCode::RGB.new(r: 255).to_hsl }

    it { expect(subject.to_rgb.to_s).to eq('#ff0000') }
    it { expect(subject.h).to eq(0) }
    it { expect(subject.s).to eq(100) }
    it { expect(subject.l).to eq(50) }
  end

  context 'private methods' do
    describe '#parse_code' do
      subject { ColorCode::RGB.new.send(:parse_code, code) }

      context 'code is match' do
        let(:code) { '#fF0000' }

        it { expect(subject).to eq([255, 0, 0]) }
      end

      context 'code does not match' do
        let(:code) { '#GG0000' }

        it { expect{ subject }.to raise_error(ArgumentError) }
      end
    end

    describe '#h' do
      subject { rgb.send(:h) }

      context 'rgb all the same value' do
        let(:rgb) { ColorCode::RGB.new }

        it { expect(subject).to eq(0) }
      end

      context 'max value r' do
        let(:rgb) { ColorCode::RGB.new(r: 150, g: 100, b: 100) }

        it { expect(subject).to eq(0) }
      end

      context 'max value g' do
        let(:rgb) { ColorCode::RGB.new(r: 100, g: 150, b: 100) }

        it { expect(subject).to eq(120) }
      end

      context 'max value b' do
        let(:rgb) { ColorCode::RGB.new(r: 100, g: 100, b: 150) }

        it { expect(subject).to eq(240) }
      end
    end

    describe '#hsl_s' do
      subject { rgb.send(:hsl_s) }

      context 'converge under 128' do
        let(:rgb) { ColorCode::RGB.new(r: 150, g: 100, b: 100) }

        it { expect(subject).to eq(20) } 
      end

      context 'converge over 128' do
        let(:rgb) { ColorCode::RGB.new(r: 255, g: 255, b: 255) }

        it { expect(subject).to eq(0) } 
      end
    end

    describe '#l' do
      subject { ColorCode::RGB.new(r:255).send(:l) }

      it { expect(subject).to eq(50) }
    end

    describe '#max' do
      subject { ColorCode::RGB.new(r: 1, g: 2, b: 3).send(:max) }

      it { expect(subject).to eq(3) }
    end

    describe '#min' do
      subject { ColorCode::RGB.new(r: 1, g: 2, b: 3).send(:min) }

      it { expect(subject).to eq(1) }
    end
  end
end
