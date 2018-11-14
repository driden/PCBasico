with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;

procedure Main is

   procedure Producir (x : out Integer) is
      subtype Rango is Integer range 1 .. 200; -- Rango de numeros producidos
      package Random_Proc is new Ada.Numerics.Discrete_Random (Rango);
      use Random_Proc;
      G : Generator;
   begin
      Reset (G);
      x := Random (G);
   end Producir;

   task TBuffer is
      entry ins (x : in Integer);
      entry ext (x : out Integer);
   end TBuffer;

   task body TBuffer is
      data     : array (Integer range 0 .. 4) of Integer;
      pai, pae : Integer range 0 .. 4;
      cant     : Integer range 0 .. 5;
   begin
      cant := 0;
      pai  := 0;
      pae  := 0;
      data := (-1, -1, -1, -1, -1);
      loop
         select when cant < 5 =>
               accept ins (x : in Integer) do
                  data (pai) := x;
                  --Put_Line("Insertando el numero " & Integer'Image(x));
               end ins;
               pai  := (pai + 1) mod 5;
               cant := cant + 1;

         or when cant > 0 =>
               accept ext (x : out Integer) do
                  x := data (pae);
                  --Put_Line("Extrayendo el numero " & Integer'Image(x));
               end ext;
               pae  := (pae + 1) mod 5;
               cant := cant - 1;
         end select;
      end loop;

   end TBuffer;

   task type TConsumidor;
   task body TConsumidor is
      x : Integer;
   begin
      loop
         TBuffer.ext (x);
         Put_Line("Consumiendo el numero " & Integer'Image(x));
      end loop;
   end TConsumidor;

   task type TProductor is
   end TProductor;

   task body TProductor is
      x : Integer;
   begin
      loop
         Producir (x);
         Put_Line ("Produciendo el numero " & Integer'Image(x));
         TBuffer.ins (x);
      end loop;
   end TProductor;

   c1, c2, c3  : TConsumidor;
   p1, p2, p3, p4, p5 : TProductor;
begin
   null; --Espera a que terminen las tareas
end Main;
