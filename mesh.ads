with Ada.Containers.Vectors;

package Mesh is
	type Coordinates is record
		X, Y, Z	: Float;
	end record;

	type Coordinates_Array is array (Positive range <>) of Coordinates;

	type Dimension_Range is record
		Start, Finish	: Float;
	end record;

	type Dimension_Spec is record
		Num_Points	: Positive;
		Range_Info	: Dimension_Range;
	end record;

	type Mesh_Specification is record
		X_Dim, Y_Dim, Z_Dim	: Dimension_Spec;
	end record;

	function Create_Mesh(Spec : Mesh_Specification) return Coordinates_Array;

	function Create_Mesh_From_Params(
		X_Point : Positive;
		Y_Point : Positive;
		Z_Point : Positive;
		X_Range : Dimension_Range;
		Y_Range : Dimension_Range;
		Z_Range : Dimension_Range) return Coordinates_Array;

	procedure Print_Mesh_Info(Coords : Coordinates_Array; Max_Points : Positive := 10);
end Mesh;
