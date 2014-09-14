require 'spec_helper'
require 'lib/question_3/andrei'

describe Andrei do

  describe "#markov" do

    context "when recursive strategy" do
      let(:delta) { 0.005 }

      it "is always 0 for values in axis of 3 or more" do
        expect(Andrei.markov 0, 3, 5).to eq 0
        expect(Andrei.markov 0, 4, 5).to eq 0
        expect(Andrei.markov 0, 5, 6).to eq 0
        expect(Andrei.markov 3, 1, 5).to eq 0
      end

      context "Initial state" do
        it "returns probability 1" do
          expect(Andrei.markov 0, 0, 0).to eq 1
        end
      end

      context "First step" do
        it "returns the appropriate probabilities" do
          expect(Andrei.markov 0, 0, 1).to eq 0.2
          expect(Andrei.markov 1, 0, 1).to eq 0.2
          expect(Andrei.markov 0, 1, 1).to eq 0.2
          expect(Andrei.markov -1, 0, 1).to eq 0.2
          expect(Andrei.markov 0, -1, 1).to eq 0.2
        end
      end

      context "Second step" do
        it "returns the appropriate probabilities for a representative subset including extreme cases" do
          expect(Andrei.markov 0, 0, 2).to eq 0.2
          expect(Andrei.markov 1, 0, 2).to eq 0.08
          expect(Andrei.markov 0, 1, 2).to eq 0.08
          expect(Andrei.markov -1, 0, 2).to eq 0.08
          expect(Andrei.markov 0, -1, 2).to eq 0.08
          expect(Andrei.markov 2, 0, 2).to eq 0.04
          expect(Andrei.markov 0, 2, 2).to eq 0.04
          expect(Andrei.markov -2, 0, 2).to eq 0.04
          expect(Andrei.markov 0, -2, 2).to eq 0.04
          expect(Andrei.markov 2, 0, 2).to eq 0.04
        end
      end

      context "Third step" do
        it "returns the appropriate probabilities for a representative subset including extreme cases" do
          expect(acceptance 0.1, delta).to cover Andrei.markov 0, 0, 3
          expect(acceptance 0.025, delta).to cover Andrei.markov 2, 1, 3
          expect(acceptance 0.025, delta).to cover Andrei.markov 1, 2, 3
          expect(acceptance 0.025, delta).to cover Andrei.markov -2, 1, 3
          expect(acceptance 0.025, delta).to cover Andrei.markov 1, -2, 3
          expect(acceptance 0.032, delta).to cover Andrei.markov 2, 0, 3
          expect(acceptance 0.032, delta).to cover Andrei.markov 0, 2, 3
          expect(acceptance 0.032, delta).to cover Andrei.markov -2, 0, 3
          expect(acceptance 0.032, delta).to cover Andrei.markov 0, -2, 3
        end
      end

      context "Fourth step" do
        it "returns the appropriate probabilities for a representative subset including extreme cases" do
          expect(acceptance 0.1, delta).to cover Andrei.markov 0, 0, 4
          expect(acceptance 0.01, delta).to cover Andrei.markov 2, -2, 4
          expect(acceptance 0.025, delta).to cover Andrei.markov -2, -1, 4
        end
      end
    end

    context "when iterative strategy" do
      let(:options) { { strategy: strategy} }
      let(:strategy) { Andrei::IterativeStrategy }

      let(:delta) { 0.005 }

      it "is always 0 for values in axis of 3 or more" do
        expect(Andrei.markov 0, 3, 5, options).to eq 0
        expect(Andrei.markov 0, 4, 5, options).to eq 0
        expect(Andrei.markov 0, 5, 6, options).to eq 0
        expect(Andrei.markov 3, 1, 5, options).to eq 0
      end

      context "Initial state" do
        it "returns probability 1" do
          expect(Andrei.markov 0, 0, 0, options).to eq 1
        end
      end

      context "First step" do
        it "returns the appropriate probabilities" do
          expect(Andrei.markov 0, 0, 1, options).to eq 0.2
          expect(Andrei.markov 1, 0, 1, options).to eq 0.2
          expect(Andrei.markov 0, 1, 1, options).to eq 0.2
          expect(Andrei.markov -1, 0, 1, options).to eq 0.2
          expect(Andrei.markov 0, -1, 1, options).to eq 0.2
        end
      end

      context "Second step" do
        it "returns the appropriate probabilities for a representative subset including extreme cases" do
          expect(Andrei.markov 0, 0, 2, options).to eq 0.2
          expect(Andrei.markov 1, 0, 2, options).to eq 0.08
          expect(Andrei.markov 0, 1, 2, options).to eq 0.08
          expect(Andrei.markov -1, 0, 2, options).to eq 0.08
          expect(Andrei.markov 0, -1, 2, options).to eq 0.08
          expect(Andrei.markov 2, 0, 2, options).to eq 0.04
          expect(Andrei.markov 0, 2, 2, options).to eq 0.04
          expect(Andrei.markov -2, 0, 2, options).to eq 0.04
          expect(Andrei.markov 0, -2, 2, options).to eq 0.04
          expect(Andrei.markov 2, 0, 2, options).to eq 0.04
        end
      end

      context "Third step" do
        it "returns the appropriate probabilities for a representative subset including extreme cases" do
          expect(acceptance 0.1, delta).to cover Andrei.markov 0, 0, 3, options
          expect(acceptance 0.025, delta).to cover Andrei.markov 2, 1, 3, options
          expect(acceptance 0.025, delta).to cover Andrei.markov 1, 2, 3, options
          expect(acceptance 0.025, delta).to cover Andrei.markov -2, 1, 3, options
          expect(acceptance 0.025, delta).to cover Andrei.markov 1, -2, 3, options
          expect(acceptance 0.032, delta).to cover Andrei.markov 2, 0, 3, options
          expect(acceptance 0.032, delta).to cover Andrei.markov 0, 2, 3, options
          expect(acceptance 0.032, delta).to cover Andrei.markov -2, 0, 3, options
          expect(acceptance 0.032, delta).to cover Andrei.markov 0, -2, 3, options
        end
      end

      context "Fourth step" do
        it "returns the appropriate probabilities for a representative subset including extreme cases" do
          expect(acceptance 0.1, delta).to cover Andrei.markov 0, 0, 4, options
          expect(acceptance 0.01, delta).to cover Andrei.markov 2, -2, 4, options
          expect(acceptance 0.025, delta).to cover Andrei.markov -2, -1, 4, options
        end
      end
    end
  end

end