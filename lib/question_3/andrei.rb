require_relative './andrei_related/recursiveness_strategy'

module Andrei
  def self.markov(x, y, t, options = {}, strategy = Andrei::RecursivenessStrategy)
    strategy.new(x, y, t, options).call
  end
end