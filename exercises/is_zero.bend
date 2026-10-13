import Base

def is_zero(n: U32) -> Bool:
  match n:
    case 0:
      True{}
    case _:
      False{}

def main() -> IO(Unit):
  do IO<Unit>:
    IO.print(Bool.show(is_zero(42)))  # => False
    IO.print(Bool.show(is_zero(0)))   # => True