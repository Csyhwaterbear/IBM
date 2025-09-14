package body IBM is

	function Create_Grid(Dim : Natural; Range_Value : Grid_Range_Array) return Grid is

		N : constant Dimension_Count := Dimension_Count(Dim'Length);
	
	begin
		
		if N not in 2 .. 3 then
			raise Grid_Error with "Only accept 2D and 3D grid";
		end if;

		if Range_Value'Length /= Integer(N) then
			raise Grid_Error with "Mismatch between range and Dimension";
		end if;
		
		declare
			Result : Grid(N);
		begin
			for I in 1 .. N loop
				Result.Dims_P(I) := Dim(I);
			end loop;

			for I in 1 .. N loop
				Result.Range_P(I) := Range_Value(I);
			end loop;

			case N is
				when 2 =>
					Result.Data_2D := new Float_Array_2D(1..Dim(1), 1..Dim(2));
					Result.Data_2D.all := (others => (others => 0.0));
				when 3 =>
					Result.Data_3D := new Float_Array_3D(1..Dim(1), 1..Dim(2), 1..Dim(3));
					Result.Data_3D.all := (others => (others => (others => 0.0)));
			end case;

			return Result;
		end;
	end Create_Grid;

	procedure Free_Grid(G : in out Grid) is
	begin
		case G.N is
			when 2 =>
				if G.Data_2D /= null then
					declare
						Temp : Data_Access_2D := G.Data_2D;
					begin
						G.Data_2D := null;
						Free(Temp);
					end;
				end if;
			when 3 =>
				if G.Data_3D /= null then
					declare
						Temp : Data_Access_3D := G.Data_3D;
					begin
						G.Data_3D := null;
						Free(Temp);
					end;
				end if;
		end case;

	end Free_Grid;
	
	function Get_Dimension(G : Grid; Index : Integer) return Integer is
	begin
		If Index > Index(G.N) then
			raise Grid_Error with "Out of Index";
		end if;
		return G.Dims_P(Index);
	end Get_Dimension;

	function Get_Range_Min(G : Grid; Index : Integer) return Float is
	begin
		If Index > Index(G.N) then
			raise Grid_Error with "Out of Index";
		end if; 
		return G.Dims_P(Index).Min;
	end Get_Range_Min;

	function Get_Range_Max(G : Grid; Index : Integer) return Float is
	begin
		If Index > Index(G.N) then
			raise Grid_Error with "Out of Index";
		end if; 
		return G.Dims_P(Index).Max;
	end Get_Range_Max;

	function Get_Data_2D(G : Grid; I, J :Natural) return Float is
	begin
		if G.N /= 2 then
			raise Grid_Error with "This method is for 2D grid only";
		end if;
		return G.Data_2D(I, J);
	end Get_Data_2D;

	procedure Set_Data_2D(G : Grid; I, J :Natural; Value : Float) is
	begin
		if G.N /= 2 then
			raise Grid_Error with "This method is for 2D grid only";
		end if;
		G.Data_2D(I, J) := Value;
	end Set_Data_2D;

	function Get_Data_3D(G : Grid; I, J, K :Natural) return Float is
	begin
		if G.N /= 3 then
			raise Grid_Error with "This method is for 3D grid only";
		end if;
		return G.Data_3D(I, J, K);
	end Get_Data_3D;

	procedure Set_Data_3D(G : Grid; I, J, K :Natural; Value : Float) is
	begin
		if G.N /= 3 then
			raise Grid_Error with "This method is for 3D grid only";
		end if;
		G.Data_3D(I, J, K) := Value;
	end Set_Data_3D;

end IBM;
