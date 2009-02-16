#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), '..', 'lib', 'prawn_grid')

Prawn::Document.generate(File.join(File.dirname(__FILE__), 'show_grid.pdf')) do |p|
  p.define_grid(:columns => 5, :rows => 8, :gutter => 10)
  
  p.grid.show_all
  
  p.grid(2,4).show("FF0000")
  p.grid([3,0], [5,3]).show("0000FF")
end