with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

with BufferPC;
package body Consumidor is
   task body TConsumidor is
      x : Integer;
   begin
      loop
         BufferPC.TBuffer.ext (x);
         Put ("Consumiendo el numero ");
         Put (x);
         New_Line (1);
      end loop;
   end TConsumidor;
end Consumidor;
