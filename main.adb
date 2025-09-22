with Ada.Text_IO; use Ada.Text_IO;
with Mesh; use Mesh;

procedure Main is
	-- Your specified input: ((24,32,36),((0,1),(-1,1),(-1,0)))
	X_Point: constant Positive := 24;
	Y_Point: constant Positive := 32;
	Z_Point: constant Positive := 36;
	
	X_Range : constant Dimension_Range := (Start => 0.0, Finish => 1.0);
	Y_Range : constant Dimension_Range := (Start => -1.0, Finish => 1.0);
	Z_Range : constant Dimension_Range := (Start => -1.0, Finish => 0.0);
	
	Mesh_Coords : Coordinates_Array(1 .. X_Point * Y_Point * Z_Point);
begin
	Put_Line("3D Mesh Generator Example");
	Put_Line("=========================");
	Put_Line("Specification:");
	Put_Line("X: " & Positive'Image(X_Point) & " points from " & Float'Image(X_Range.Start) & " to " & Float'Image(X_Range.Finish));
	Put_Line("Y: " & Positive'Image(Y_Point) & " points from " & Float'Image(Y_Range.Start) & " to " & Float'Image(Y_Range.Finish));
	Put_Line("Z: " & Positive'Image(Z_Point) & " points from " & Float'Image(Z_Range.Start) & " to " & Float'Image(Z_Range.Finish));
	Put_Line("");
	
	-- Generate the mesh
	Mesh_Coords := Create_Mesh_From_Params(
		X_Point, Y_Point, Z_Point,
		X_Range, Y_Range, Z_Range
	);
	
	-- Display information about the generated mesh
	Print_Mesh_Info(Mesh_Coords, 5);
	
	-- Additional examples
	Put_Line("Additional Examples:");
	Put_Line("===================");
	
	-- Example 1: Smaller mesh for demonstration
	declare
		Small_Mesh : Coordinates_Array := Create_Mesh_From_Params(
			3, 2, 2, (0.0, 1.0), (-1.0, 1.0), (-1.0, 0.0)
		);
	begin
		Put_Line("Small mesh (3x2x2):");
		Print_Mesh_Info(Small_Mesh, 12); -- Show all points
	end;
	
	-- Example 2: Using the structured approach
	declare
		Custom_Spec : Mesh_Specification := (
			X_Dim => (Num_Points => 4, Range_Info => (0.0, 3.0)),
			Y_Dim => (Num_Points => 3, Range_Info => (-2.0, 2.0)),
			Z_Dim => (Num_Points => 2, Range_Info => (-1.0, 1.0))
		);
		Custom_Mesh : Coordinates_Array := Create_Mesh(Custom_Spec);
	begin
		Put_Line("Custom specification mesh (4x3x2):");
		Print_Mesh_Info(Custom_Mesh, 8);
	end;
	
end Main;
