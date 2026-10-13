# take the two parts of a List 
# and call sum on them
import Base

def sum(xs: List<U32>, +acc: U32) -> U32:
  match xs:
    case Nil{}:
      acc
    case Con{h, t}:
      a b = sum(t, (acc + h : U32)) sum(t, (acc + h : U32))
      (a + b : U32)

def main() -> U32:
  sum([1, 2, 3, 4], 0)  # => 10