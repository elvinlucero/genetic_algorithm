# frozen_string_literal: true

require 'evopop'

# Initialize the population to be trained with good defaults.
population = Evopop::Population.new
population.population_size = 1000
population.dna_len = 2
population.max_generations = 1000
population.initial_range_min = -10_000.0
population.initial_range_max = 10_000.0
population.mutation_range_min = -10.0
population.mutation_range_max = 10.0
population.mutation_num = 10
population.crossover_params = { ordinal: (population.dna_len / 2) }.freeze
population.crossover_function = Evopop::Crossover.method(:one_point)
population.fitness_function = proc do |dna|
  Math.sin(dna[0]) + Math.cos(dna[1])
end

# Initialize the population
population.create

# Train a population for population.max_generations.
(0...population.max_generations).each do |i|
  population.train
  population.crossover
  population.mutate if i != population.max_generations - 1
end

# Sort and print out candidate with highest fitness in the last generation.
population.train
puts <<~DEBUG
  Finished #{population.max_generations} generations
  with the fittest candidate with a dna of #{population.candidates[0].dna}
  and a fitness of #{population.candidates[0].fitness}.
DEBUG
