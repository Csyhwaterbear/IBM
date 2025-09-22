with Ada.Text_IO;
with Ada.Numerics;

use Ada.Text_IO;

package body Mesh is

	function Create_Mesh(Spec : Mesh_Specification) return Coordinates_Array is
		Total_Points	: constant Positive := Spec.X_Dim.Num_Points * Spec.Y_Dim.Num_Points * Spec.Z_Dim.Num_Points;

		Result		: Coordinates_Array(1 .. Total_Points);
		Index 		: Positive := 1;

		X_Step : constant Float := (Spec.X_Dim.Range_Info.Finish - Spec.X_Dim.Range_Info.Start) / Float(Spec.X_Dim.Num_Points - 1);
	 	Y_Step : constant Float := (Spec.Y_Dim.Range_Info.Finish - Spec.Y_Dim.Range_Info.Start) / Float(Spec.Y_Dim.Num_Points - 1);
		Z_Step : constant Float := (Spec.Z_Dim.Range_Info.Finish - Spec.Z_Dim.Range_Info.Start) / Float(Spec.Z_Dim.Num_Points - 1);
	begin
		for Z_Index in 0 .. Spec.Z_Dim.Num_Points-1 loop
			for Y_Index in 0 .. Spec.Y_Dim.Num_Points-1 loop
				for X_Index in 0 .. Spec.Z_Dim.Num_Points-1 loop
					Result(Index) := (
						X => Spec.X_Dim.Range_Info.Start + Float(X_Index) * X_Step,
						Y => Spec.Y_Dim.Range_Info.Start + Float(Y_Index) * Y_Step,
						Z => Spec.Z_Dim.Range_Info.Start + Float(Z_Index) * Z_Step
						);
					Index := Index + 1;
				end loop;
			end loop;
		end loop;
		return Result;
	end Create_Mesh;

	function Create_Mesh_From_Params(
		X_Point : Positive;
		Y_Point : Positive;
		Z_Point : Positive;
		X_Range : Dimension_Range;
		Y_Range : Dimension_Range;
		Z_Range : Dimension_Range) return Coordinates_Array is
		Spec : Mesh_Specification := (
			X_Dim => (Num_Points => X_Point, Range_Info => X_Range),
			Y_Dim => (Num_Points => Y_Point, Range_Info => Y_Range),
			Z_Dim => (Num_Points => Z_Point, Range_Info => Z_Range)
			);
	begin
		return Create_Mesh(Spec);
	end Create_Mesh_From_Params;

	procedure Print_Mesh_Info(Coords : Coordinates_Array; Max_Points : Positive := 10) is
	begin
		Put_Line("Mesh Information:");
		Put_Line("Total points: " & Positive'Image(Coords'Length));
		Put_Line("");

		if Coords'Length > 0 then
			Put_Line("First few points:");
			for I in Coords'First..Coords'First + Positive'Min(Max_Points - 1, Coords'Length - 1) loop
				Put_Line("Point" & Positive'Image(I) & ": (" & Float'Image(Coords(I).X) & ", " & Float'Image(Coords(I).Y) & ", " & Float'Image(Coords(I).Z) & ")");
			end loop;
			 
			if Coords'Length > Max_Points then
				Put_Line("...");
				Put_Line("Last point:" & Positive'Image(Coords'Last) & ": (" & Float'Image(Coords(Coords'Last).X) & ", " & Float'Image(Coords(Coords'Last).Y) & ", " & Float'Image(Coords(Coords'Last).Z) & ")");
			end if;
		end if;
		Put_Line("");
	end Print_Mesh_Info;
end Mesh;
