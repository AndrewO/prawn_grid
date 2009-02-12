#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), '..', 'lib', 'prawn_grid')

Prawn::Document.generate(File.join(File.dirname(__FILE__), 'simple_grid.pdf')#, 
    # :left_margin => 0,
    # :right_margin => 0,
    # :top_margin => 0,
    # :bottom_margin => 0
  ) do |p|
  p.define_grid(:columns => 5, :rows => 8, :gutter => 10)
  
  p.grid.rows.times do |i|
    p.grid.columns.times do |j|
      b = p.grid(i,j)
      p.bounding_box b.top_left, :width => b.width, :height => b.height do
        p.text b.name
        p.stroke do
          p.rectangle(p.bounds.top_left, b.width, b.height)
        end
      end
    end
  end
end