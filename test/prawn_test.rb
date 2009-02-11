require File.join(File.dirname(__FILE__), "test_helper")

class PrawnTest < Test::Unit::TestCase
  context "Prawn grid when included in Prawn::Document" do
    setup { @pdf = Prawn::Document.new }
  
    should "allow definition of a grid" do
      @pdf.define_grid(:columns => 5, :rows => 8, :gutter => 0.1)
      assert_equal(5, @pdf.grid.columns)
      assert_equal(8, @pdf.grid.rows)
      assert_equal(0.1, @pdf.grid.gutter)
    end
  
    context "when grid is defined" do
      setup do
        @num_columns = 5
        @num_rows = 8
        @gutter = 0.1
        @pdf.define_grid(:columns => @num_columns, :rows => @num_rows, :gutter => @gutter)
      end
      
      should "compute the column width" do
        assert_equal(@pdf.bounds.width, @pdf.grid.column_width * @num_columns.to_f + @gutter * (@num_columns - 1).to_f)
      end
      
      should "compute the row height" do
        assert_equal(@pdf.bounds.height, @pdf.grid.row_height * @num_rows.to_f + @gutter * (@num_rows - 1).to_f)
      end
      
      # should "give the edges of a grid box" do
      #   assert_equal(expected, @pdf.grid(1,4).top_left)
      #   assert_equal(expected, @pdf.grid(1,4).top_right)
      #   assert_equal(expected, @pdf.grid(1,4).bottom_left)
      #   assert_equal(expected, @pdf.grid(1,4).bottom_left)
      # end
      # 
      # should "give the edges of a multiple grid boxes" do
      #   assert_equal(expected, @pdf.grid([1,3], [2,5]).top_left)
      #   assert_equal(expected, @pdf.grid([1,3], [2,5]).top_right)
      #   assert_equal(expected, @pdf.grid([1,3], [2,5]).bottom_left)
      #   assert_equal(expected, @pdf.grid([1,3], [2,5]).bottom_right)
      # end
    end
  end
end