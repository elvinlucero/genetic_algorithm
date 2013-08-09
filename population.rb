class Population
    attr_accessor :candidates, :population_size, :max_generations, :initial_range_min, :initial_range_max, :mutation_range_min, :mutation_range_max, :mutation_num, :fitness_function, :dna_len
    
    def initialize
    end


    def create
        @candidates = Array.new(@population_size) {|c| 
            candidate = Candidate.new
            candidate.dna = []
            (0...@dna_len).each {
                candidate.dna << Random.rand(@initial_range_min...@initial_range_max)
            }
            candidate
        }
    end

    def train
        average_fitness = 0
        @candidates.each { |c|
            c.fitness = fitness_function.call(c.dna)
            average_fitness = average_fitness + c.fitness
        }
        average_fitness = average_fitness/@population_size
        print "average_fitness: " << average_fitness.to_s << "\n"
        @candidates = @candidates.sort_by {|c| c.fitness}
        @candidates = @candidates.reverse
    end

    def crossover
        @candidates = @candidates.take((@population_size*0.75).to_i)
        
        new_generation = Array.new
        (0...@population_size).each {|i|
            couple = @candidates.sample(2)
            child = Candidate.new
            child.dna = [(couple[0].dna[0] + couple[1].dna[0])/2.0, (couple[0].dna[1] + couple[1].dna[1])/2.0] # Initialize the dna of the child with the parents' dna.
            new_generation << child 
        }

        @candidates = new_generation
    end

    def mutate
        mutated = @candidates.sample(MUTATION_NUM)

        mutated.each { |c|
            c.dna[0] = c.dna[0] + Random.rand(@mutation_range_min...@mutation_range_max)
            c.dna[1] = c.dna[1] + Random.rand(@mutation_range_min...@mutation_range_max)
        }
    end
end
