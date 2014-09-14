require_relative './andrei'
require_relative './brute_force'

andrei_1 = Andrei.markov 0, 0, 15, strategy: Andrei::IterativeStrategy, precission: 7
brutus_1_repetitions = 100000
brutus_1 = BruteForce.probabilities(15, repetitions: brutus_1_repetitions)[[0,0]]

andrei_2 = Andrei.markov 2, 2, 60*60, strategy: Andrei::IterativeStrategy, precission: 7
brutus_2_repetitions = 10000
brutus_2 = BruteForce.probabilities(60*60, repetitions: brutus_2_repetitions)[[2,2]]

puts "=== Results ==="
puts "First question:"
puts "\t Analitical: #{andrei_1}"
puts "\t Brute force (repetitions: #{brutus_1_repetitions}): #{brutus_1}"
puts "Second question:"
puts "\t Analitical: #{andrei_2}"
puts "\t Brute force (repetitions: #{brutus_2_repetitions}): #{brutus_2}"