import Base

def double(+x: U32) -> U32:
  (x + x : U32)

def main() -> IO(Unit):
  do IO<Unit>:
    IO.print(U32.show(double(3)))  # => 6