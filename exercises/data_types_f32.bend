import Base

type Shape is Data:
  Circle{r: F32}
  Square{s: F32}

def area(x: Shape) -> F32:
  match x:
    case Circle{+r}:
      (3.1415 * r * r : F32)
    case Square{+s}:
      (s * s : F32)

def main() -> IO(Unit):
  IO.print(F32.show(area(Square{5.0})))  # => 25