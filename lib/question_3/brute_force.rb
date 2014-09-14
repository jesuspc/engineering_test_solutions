module BruteForce
  START_POINT = [0, 0]
  MAX_COORDINATE = 3
  DEFAULT_REPETITIONS = 30000

  def self.try(t)
    t.times.inject(START_POINT) do |state, _|
      state = case rand
        when 0.8..1.0 then if_able [state[0] + 1, state[1]], otherwise: state
        when 0.6..0.8 then if_able [state[0] - 1, state[1]], otherwise: state
        when 0.4..0.6 then if_able [state[0], state[1] + 1], otherwise: state
        when 0.2..0.4 then if_able [state[0], state[1] - 1], otherwise: state
        when 0.0..0.2 then state
      end
    end
  end

  def self.probabilities(t, options = {})
    repetitions = options.fetch :repetitions, DEFAULT_REPETITIONS
    accumulator = Hash.new { |hash, key| hash[key] = 0 }
   
    repetitions.times { accumulator[try t] += 1 }
    Hash[accumulator.map { |k, value| [k, value.to_f/repetitions] }]
  end

private

  def self.if_able(candidate, options = {})
    candidate.map(&:abs).max < MAX_COORDINATE ? candidate : options[:otherwise] 
  end
end