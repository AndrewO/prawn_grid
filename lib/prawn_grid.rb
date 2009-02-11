begin
  require 'rubygems'
rescue LoadError
end

require 'prawn'

module Prawn::Gridable
  def define_grid(options = {})
    @grid = Grid.new(self, options)
  end
  
  def grid(*args)
    if args == []
      @grid
    end
  end
  
  class Grid
    attr_reader :columns, :rows, :gutter
    
    def initialize(pdf, options = {})
      Prawn.verify_options([:columns, :rows, :gutter], options)
      
      @pdf = pdf
      @columns = options[:columns]
      @rows = options[:rows]
      @gutter = options[:gutter]
    end
  end
  
  class Box
    
  end
end

Prawn::Document.send(:include, Prawn::Gridable)