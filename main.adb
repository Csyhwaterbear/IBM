with IBM;
with Ada.Text_IO;
with Ada.Float_Text_IO;

procedure Main is

	use IBM;
	use Ada.Text_IO;
	use Ada.Float_Text_IO;
   
	-- 创建 2D 网格
	Dims_2D : Dimension_Array(1..2) := (10, 20);
	Ranges_2D : Grid_Range_Array(1..2) := ((Min => 0.0, Max => 1.0), (Min => 0.0, Max => 2.0));
   
	-- 创建 3D 网格
	Dims_3D : Dimension_Array(1..3) := (5, 10, 15);
	Ranges_3D : Grid_Range_Array(1..3) := ((Min => 0.0, Max => 1.0),(Min => 0.0, Max => 2.0),(Min => 0.0, Max => 3.0));
	
	Grid_2D : Grid(2);
	Grid_3D : Grid(3);

begin
	Put_Line("=== IBM Grid 示例程序 ===");
	New_Line;
	
	-- 创建 2D 网格
	Put_Line("创建 2D 网格...");
	Grid_2D := Create_Grid(Dims_2D, Ranges_2D);
	
	-- 显示 2D 网格信息
	Put_Line("2D 网格维度: " & Integer'Image(Get_Dimension(Grid_2D, 1)) &  " x " & Integer'Image(Get_Dimension(Grid_2D, 2)));
	Put("X 范围: ");
	Put(Get_Range_Min(Grid_2D, 1), Fore => 0, Aft => 2, Exp => 0);
	Put(" 到 ");
	Put(Get_Range_Max(Grid_2D, 1), Fore => 0, Aft => 2, Exp => 0);
	New_Line;
	Put("Y 范围: ");
	Put(Get_Range_Min(Grid_2D, 2), Fore => 0, Aft => 2, Exp => 0);
	Put(" 到 ");
	Put(Get_Range_Max(Grid_2D, 2), Fore => 0, Aft => 2, Exp => 0);
	New_Line;

	-- 设置和获取 2D 网格数据
	Put_Line("设置 2D 网格数据...");
	Set_Data_2D(Grid_2D, 1, 1, 42.5);
	Set_Data_2D(Grid_2D, 2, 3, 99.9);
	
	Put("Grid_2D(1,1) = ");
	Put(Get_Data_2D(Grid_2D, 1, 1), Fore => 0, Aft => 2, Exp => 0);
	New_Line;
	Put("Grid_2D(2,3) = ");
	Put(Get_Data_2D(Grid_2D, 2, 3), Fore => 0, Aft => 2, Exp => 0);
	New_Line;
	New_Line;
	
	-- 创建 3D 网格
	Put_Line("创建 3D 网格...");
	Grid_3D := Create_Grid(Dims_3D, Ranges_3D);
	
	-- 显示 3D 网格信息
	Put_Line("3D 网格维度: " & Integer'Image(Get_Dimension(Grid_3D, 1)) & " x " & Integer'Image(Get_Dimension(Grid_3D, 2)) & " x " & Integer'Image(Get_Dimension(Grid_3D, 3)));
	
	-- 设置和获取 3D 网格数据
	Put_Line("设置 3D 网格数据...");
	Set_Data_3D(Grid_3D, 1, 1, 1, 123.45);
	Set_Data_3D(Grid_3D, 2, 3, 4, 67.89);
	
	Put("Grid_3D(1,1,1) = ");
	Put(Get_Data_3D(Grid_3D, 1, 1, 1), Fore => 0, Aft => 2, Exp => 0);
	New_Line;
	Put("Grid_3D(2,3,4) = ");
	Put(Get_Data_3D(Grid_3D, 2, 3, 4), Fore => 0, Aft => 2, Exp => 0);
	New_Line;
	New_Line;
	
	-- 演示错误处理
	Put_Line("=== 错误处理演示 ===");
	begin
		-- 尝试访问越界维度
		Put_Line("尝试访问第4个维度 (应该报错):");
		declare
			Dummy : Integer := Get_Dimension(Grid_2D, 4);
		begin
			null;
		end;
	exception
		when Grid_Error =>
			Put_Line("捕获到预期错误: 维度索引越界");
	end;
   
	begin
	-- 尝试在 2D 网格上使用 3D 访问
 		Put_Line("尝试在 2D 网格上使用 3D 访问 (应该报错):");
		Set_Data_3D(Grid_2D, 1, 1, 1, 1.0);
	exception
		when Grid_Error =>
			Put_Line("捕获到预期错误: 该方法仅适用于 3D 网格");
	end;

	New_Line;
	Put_Line("=== 程序执行完成 ===");
	
	-- 清理资源
	Free_Grid(Grid_2D);
	Free_Grid(Grid_3D);

exception
	when Grid_Error =>
		Put_Line("程序执行过程中发生网格错误!");
		-- 确保资源被清理
		Free_Grid(Grid_2D);
		Free_Grid(Grid_3D);
	when others =>
		Put_Line("程序执行过程中发生未知错误!");
		Free_Grid(Grid_2D);
		Free_Grid(Grid_3D);
end Main;
