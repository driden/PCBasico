package BufferPC is

   task TBuffer is
      entry ins(x: in Integer);
      entry ext(x: out Integer);
   end TBuffer;

end BufferPC;
