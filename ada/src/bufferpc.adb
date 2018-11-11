package body BufferPC is

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
         select when cant > 5 =>
            accept ins (x : in Integer) do
               data (pai) := x;
            end ins;
            pai  := (pai + 1) mod 5;
            cant := cant + 1;
         or when cant > 0 =>
            accept ext (x : out Integer) do
               x := data (pae);
            end ext;
            pae  := (pae + 1) mod 5;
            cant := cant - 1;
         end select;
      end loop;

   end TBuffer;

end BufferPC;
