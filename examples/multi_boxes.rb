#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), '..', 'lib', 'prawn_grid')

Prawn::Document.generate(File.join(File.dirname(__FILE__), 'multi_boxes.pdf')#, 
    # :left_margin => 0,
    # :right_margin => 0,
    # :top_margin => 0,
    # :bottom_margin => 0
  ) do |p|
  p.define_grid(:columns => 5, :rows => 12, :gutter => 10)
  
  p.grid.rows.times do |i|
    p.grid.columns.times do |j|
      p.grid(i,j).bounding_box do
        p.text p.grid(i,j).name
        p.stroke_color = "cccccc"
        p.stroke do
          p.rectangle(p.bounds.top_left, p.bounds.width, p.bounds.height)
        end
      end
    end
  end
  
  g = p.grid([0,0], [1,1])
  g.bounding_box do
    p.text g.name
    p.stroke_color = "333333"
    p.stroke do
      p.rectangle(p.bounds.top_left, p.bounds.width, p.bounds.height)
    end
  end

  g = p.grid([3,0], [3,3])
  g.bounding_box do
    p.text g.name
    p.stroke_color = "333333"
    p.stroke do
      p.rectangle(p.bounds.top_left, p.bounds.width, p.bounds.height)
    end
  end

  g = p.grid([5,1], [4,0])
  g.bounding_box do
    p.text g.name
    p.stroke_color = "333333"
    p.stroke do
      p.rectangle(p.bounds.top_left, p.bounds.width, p.bounds.height)
    end
  end

  g = p.grid([5,3], [4,4])
  g.bounding_box do
    p.text g.name
    p.stroke_color = "333333"
    p.stroke do
      p.rectangle(p.bounds.top_left, p.bounds.width, p.bounds.height)
    end
  end

end