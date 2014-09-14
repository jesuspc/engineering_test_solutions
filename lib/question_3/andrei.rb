require_relative './andrei_related/recursiveness_strategy'
require_relative './andrei_related/iterative_strategy'

module Andrei
  def self.markov(x, y, t, options = {})
    strategy = options.fetch :strategy, Andrei::RecursivenessStrategy
    strategy.new(x, y, t, options).call
  end
end