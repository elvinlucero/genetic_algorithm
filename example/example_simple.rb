# frozen_string_literal: true

require 'evopop'

def drive(population)
  (0...population.max_generations).each do |i|
    population.train
    population.crossover
    population.mutate if i != population.max_generations - 1
  end

  population
end

population = Evopop::Population.new

drive population

# Sort and print out candidate with highest fitness in the last generation.
population.train
puts <<~DEBUG
  Finished #{population.max_generations} generations with the fittest
  candidate with a dna of #{population.candidates[0].dna} and a fitness
  of #{population.candidates[0].fitness}.
DEBUG
