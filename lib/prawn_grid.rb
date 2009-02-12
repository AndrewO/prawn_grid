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
    @boxes ||= {}
    @boxes[args] ||= if args.empty?
      @grid
    else
      g1, g2 = args
      if g1.class == Array && g2.class == Array && g1.length == 2 && g2.length == 2
        multi_box(g1, g2)
      else
        single_box(g1, g2)
      end
    end
  end
  
  class Grid
    attr_reader :pdf, :columns, :rows, :gutter
    
    def initialize(pdf, options = {})
      Prawn.verify_options([:columns, :rows, :gutter], options)
      
      @pdf = pdf
      @columns = options[:columns]
      @rows = options[:rows]
      @gutter = options[:gutter].to_f
    end

    def column_width
      @column_width ||= subdivide(pdf.bounds.width, columns)
    end
    
    def row_height
     @row_height ||= subdivide(pdf.bounds.height, rows)
    end

    private
    def subdivide(total, num)
      (total.to_f - (gutter * (num - 1).to_f)) / num.to_f
    end
  end
  
  class Box
    attr_reader :pdf
    
    def initialize(pdf, i, j)
      @pdf = pdf
      @i = i
      @j = j
    end
    
    def name
      "#{@i.to_s}, #{@j.to_s}"
    end
    
    def top_left
      @top_left ||= [((width + gutter) * @j.to_f), total_height - ((height + gutter) * @i.to_f)]
    end
    
    def top_right
      @top_right ||= [top_left[0] + width, top_left[1]]
    end
    
    def bottom_left
      @bottom_left ||= [top_left[0], top_left[1] - height]
    end
    
    def bottom_right
      @bottom_right ||= [top_left[0] + width, top_left[1] - height]
    end
    
    def total_height
      pdf.bounds.height.to_f
    end
    
    def grid
      pdf.grid
    end
    
    def width
      grid.column_width.to_f
    end
    
    def height
      grid.row_height.to_f
    end
    
    def gutter
      grid.gutter.to_f
    end
    
    def bounding_box(&blk)
      pdf.bounding_box(top_left, :width => width, :height => height, &blk)
    end
  end
  
  private
  def single_box(i, j)
    Box.new(self, i, j)
  end
end

Prawn::Document.send(:include, Prawn::Gridable)