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
        @gutter = 10.0
        @pdf.define_grid(:columns => @num_columns, :rows => @num_rows, :gutter => @gutter)
      end
      
      should "compute the column width" do
        assert_equal(@pdf.bounds.width, @pdf.grid.column_width * @num_columns.to_f + @gutter * (@num_columns - 1).to_f)
      end
      
      should "compute the row height" do
        assert_equal(@pdf.bounds.height, @pdf.grid.row_height * @num_rows.to_f + @gutter * (@num_rows - 1).to_f)
      end
      
      should "give the edges of a grid box" do
        grid_width = (@pdf.bounds.width.to_f - (@gutter * (@num_columns - 1).to_f )) / @num_columns.to_f
        grid_height = (@pdf.bounds.height.to_f - (@gutter * (@num_rows - 1).to_f ))/ @num_rows.to_f
        
        exp_tl_x = (grid_width + @gutter.to_f) * 4.0
        exp_tl_y = @pdf.bounds.height.to_f - (grid_height + @gutter.to_f)

        assert_equal([exp_tl_x, exp_tl_y], @pdf.grid(1,4).top_left)
        assert_equal([exp_tl_x + grid_width, exp_tl_y], @pdf.grid(1,4).top_right)
        assert_equal([exp_tl_x, exp_tl_y - grid_height], @pdf.grid(1,4).bottom_left)
        assert_equal([exp_tl_x + grid_width, exp_tl_y - grid_height], @pdf.grid(1,4).bottom_right)
      end

      should "give the edges of a multiple grid boxes" do
        # Hand verified.  Cheating a bit.  Don't tell.
        assert_equal([330.0, 628.75], @pdf.grid([1,3], [2,5]).top_left)
        assert_equal([650.0, 628.75], @pdf.grid([1,3], [2,5]).top_right)
        assert_equal([330.0, 456.25], @pdf.grid([1,3], [2,5]).bottom_left)
        assert_equal([650.0, 456.25], @pdf.grid([1,3], [2,5]).bottom_right)
      end
    end
  end
end