# frozen_string_literal: true

module Evopop
  # Public: Represents a candidate in the population.Evopop::Candidates are
  # abstracted as a simple data structure which contains the DNA and fitness
  # over the fitness function.
  class Candidate
    attr_accessor :dna, :fitness

    # Simple initialization of candidate object.
    def initialize(dna = [])
      @dna = dna
    end
  end
end
