#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), '..', 'lib', 'prawn_grid')

Prawn::Document.generate(File.join(File.dirname(__FILE__), 'grid.pdf')#, 
    # :left_margin => 0,
    # :right_margin => 0,
    # :top_margin => 0,
    # :bottom_margin => 0
  ) do |p|
  p.define_grid(:columns => 5, :rows => 8, :gutter => 10)
  
  p.stroke_color = "ff0000"
  
  p.grid.rows.times do |i|
    p.grid.columns.times do |j|
      p.grid(i,j).bounding_box do
        p.text p.grid(i,j).name
        p.stroke do
          p.rectangle(p.bounds.top_left, p.bounds.width, p.bounds.height)
        end
      end
    end
  end
end