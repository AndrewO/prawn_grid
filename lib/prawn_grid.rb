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
    attr_reader :pdf, :columns, :rows, :gutter
    
    def initialize(pdf, options = {})
      Prawn.verify_options([:columns, :rows, :gutter], options)
      
      @pdf = pdf
      @columns = options[:columns]
      @rows = options[:rows]
      @gutter = options[:gutter]
    end

    def column_width
      subdivide(pdf.bounds.width, columns)
    end
    
    def row_height
      subdivide(pdf.bounds.height, rows)
    end

    private
    def subdivide(total, num)
      (total.to_f - (gutter.to_f * (num - 1).to_f)) / num.to_f
    end
  end
  
  class Box
    
  end
end

Prawn::Document.send(:include, Prawn::Gridable)