with Ada.Containers.Vectors;

package IBM is
	type Dimension_Type is (D2, D3);

	type Coordinate_2D is record
		X, Y	: Float;
	end record;

	type Coordinate_3D is record
		X, Y, Z	: Float;
	end record;

	type Grid_Range is record
		Min, Max	: Float;
	end record;

	type Grid_Range_Array is array (Positive range <>) of Grid_Range;

	type Positive_Array is array (Positive range <>) of Positive;

	package Coordinate_2D_Vector is new Ada.Containers.Vectors(
			Index_Type => Positive,
			Element_Type => Coordinate_2D
		);

	package Coordinate_3D_Vector is new Ada.Containers.Vectors(
			Index_Type => Positive,
			Element_Type => Coordinate_3D
		);

	type Grid (Dimension : Dimension_Type) is tagged private;

	Invalid_Dimension_Error		: exception;
	Invalid_Point_Count_Error	: exception;
	Invalid_Range_Error		: exception;

	function Create_Grid(
			Dimension	: Dimension_Type;
			Point_Counts	: Positive_Array;
			Ranges		: Grid_Range_Array
		) return Grid;


private

	type Grid_Data (Dimension : Dimension_Type) is record
		case Dimension is
			when D2 =>
				Point_Counts	: Positive_Array(1 .. 2);
				Ranges		: Grid_Range_Array(1 .. 2);
			when D3 =>
				Point_Counts	: Positive_Array(1 .. 3);
				Ranges		: Grid_Range_Array(1 .. 3);
		end case;
	end record;

	type Grid (Dimension : Dimension_Type) is tagged record
		Data : Grid_Data (Dimension);
	end record;

end IBM;
