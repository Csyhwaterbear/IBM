with Ada.Containers.Vectors;
with Ada.Numerics.Generic_Real_Arrays;

package IBM is
	type Dimension_Count is range 2 .. 3;

	type Grid_Range is record
		Min, Max	: Float;
	end record;

	type Grid_Range_Array is array (Dimension_Count range <>) of Grid_Range;
	type Dimension_Array is array (Dimension_Count range <>) of Integer;

	type Grid(N : Dimension_Count) is tagged private;
	
	function Create_Grid(Dim : Dimension_Array; Range_Value : Grid_Range_Array) return Grid;
	procedure Free_Grid(G : in out Grid);

	-- Accessors
	function Get_Dimension(G : Grid; Index : Integer) return Integer;
	function Get_Range_Min(G : Grid; Index : Integer) return Float;
	function Get_Range_Max(G : Grid; Index : Integer) return Float;

	function Get_Data_2D(G : Grid; I, J : Natural) return Float;
	procedure Set_Data_2D(G : Grid; I, J : Natural; Value : Float);

	function Get_Data_3D(G : Grid; I, J, K : Natural) return Float;
	procedure Set_Data_3D(G : Grid; I, J, K : Natural; Value : Float);
	
	Grid_Error : exception;

private
	
	type Float_Array_2D is array (Natural range <>, Natural range <>) of Float;
	type Float_Array_3D is array (Natural range <>, Natural range <>, Natural range <>) of Float;
	type Data_Access_2D is access all Float_Array_2D;
	type Data_Access_3D is access all Float_Array_3D;
	
	type Grid (N : Dimension_Count) is tagged record
		Dims_P  : Dimension_Array(1..N);
		Range_P : Grid_Range_Array(1..N);
		case N is
			when 2 =>
				Data_2D : Data_Access_2D;
			when 3 =>
				Data_3D : Data_Access_3D;
		end case;
	end record;
end IBM;

