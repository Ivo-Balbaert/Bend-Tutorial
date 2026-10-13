# **`length`** of a `List<U32>` with an accumulator. *(Practices recursion on lists.)*
import Base

def length(xs: List<U32>, acc: Nat) -> Nat:
  match xs:
    case Nil{}:
      acc
    case Con{h, t}:
      length(t, (1n + acc : Nat))


def main() -> IO(Unit):
  do IO<Unit>:
    ls : List<U32> = [1, 2, 3]
    IO.print(Nat.show(length(ls, 0n)))  # => 3
    ls : List<U32> = [1, 2, 3, 4, 5, 6, 7]
    IO.print(Nat.show(length(ls, 0n)))  # => 7
    ls : List<U32> = []
    IO.print(Nat.show(length(ls, 0n)))  # => 0