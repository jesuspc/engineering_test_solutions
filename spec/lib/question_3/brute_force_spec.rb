require 'spec_helper'
require 'lib/question_3/brute_force'

describe BruteForce do
  describe "#try" do
    it "returns always a position inside the 5x5 board" do
      correct_behavior_log = [].tap do |acc|
        300.times { acc << (BruteForce.try(200).map(&:abs).max < 3) }
      end
      expect(correct_behavior_log.reduce(&:&)).to be true
    end
  end

  describe "#probabilities" do
    let(:result) { BruteForce.probabilities(step) }
    let(:step) { 3 }
    let(:delta) { 0.01 }

    it "sums 1 for probability values" do
      expect(1-delta..1+delta).to cover BruteForce.probabilities(3).values.reduce(&:+)
    end

    context "Initial state" do
      it "returns the initial state with probability 1" do
        expect(BruteForce.probabilities(0)[[0,0]]).to eq 1
      end
    end

    context "First step" do
      let(:step) { 1 }

      it "returns a hash of probabilities for each coordinate at the given step" do
        expect(acceptance 0.2, delta).to cover result[[0,0]]
        expect(acceptance 0.2, delta).to cover result[[0,1]]
        expect(acceptance 0.2, delta).to cover result[[1,0]]
        expect(acceptance 0.2, delta).to cover result[[0,-1]]
        expect(acceptance 0.2, delta).to cover result[[-1,0]]
      end
    end

    context "Second step" do
      let(:step) { 2 }

      it "returns a hash of probabilities for each coordinate at the given step" do
        expect(acceptance 0.2, delta).to cover result[[0,0]]
        expect(acceptance 0.08, delta).to cover result[[0,1]]
        expect(acceptance 0.08, delta).to cover result[[1,0]]
        expect(acceptance 0.08, delta).to cover result[[0,-1]]
        expect(acceptance 0.08, delta).to cover result[[-1,0]]
        expect(acceptance 0.04, delta).to cover result[[2,0]]
        expect(acceptance 0.04, delta).to cover result[[0,2]]
        expect(acceptance 0.04, delta).to cover result[[-2,0]]
        expect(acceptance 0.04, delta).to cover result[[0,-2]]
      end
    end

    context "Third step" do
      let(:step) { 3 }

      it "returns a hash of probabilities for each coordinate at the given step" do
        expect(acceptance 0.032, delta).to cover result[[2,0]]
      end
    end 
  end
end