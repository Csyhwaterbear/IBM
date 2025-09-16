package body IBM is

	function Create_Grid(
			Dimension	: Dimension_Type;
			Point_Counts	: array of Positive;
			Ranges		: Grid_Range_Array
		) return Grid
	is
		Except_Dim : constant Positive := (
				case Dimension is
					when D2 => 2,
					when D3 => 3
			);

		Result	: Grid (Dimension);
	begin
		if Point_Counts'Length /= Expected_Dim then
			raise Invalid_Point_Count_Error with 
				"Expected" & Expected_Dim'Img & " point counts, got" & Point_Counts'Length'Img;
		end if;

		if Ranges'Length /= Expected_Dim then
			raise Invalid_Range_Error with 
				"Expected" & Expected_Dim'Img & " ranges, got" & Ranges'Length'Img;
		end if;

		for I in 1 .. Expected_Dim loop
			Result.Data.Point_Counts(I) := Point_Counts(Point_Counts'First + I - 1);
		end loop;

		for I in 1 .. Expected_Dim loop
			Result.Data.Ranges(I) := Ranges(Ranges'First + I - 1);
		end loop;

		return Result;

	end Create_Grid;

end IBM;
