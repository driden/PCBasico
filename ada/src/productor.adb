
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;
with BufferPC;

package body Productor is
   task body TProductor is
      x : Integer;
   begin
      loop
         Producir (x);
         BufferPC.TBuffer.ins(x);
      end loop;
   end TProductor;

   procedure Producir (x : out Integer) is
      subtype Rango is Integer range 1 .. 20; -- Rango de numeros producidos
      package Random_Proc is new Ada.Numerics.Discrete_Random (Rango);
      use Random_Proc;
      G: Generator;
   begin
      Reset(G);
      x := Random (G);
      Put("Produciendo el numero ");
      Put(x);
      New_Line(1);
   end Producir;

end Productor;
