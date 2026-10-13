import Base

type Shape is Data:
  Circle{r: U32}
  Square{s: U32}

def area(x: Shape) -> U32:
  match x:
    case Circle{+r}:
      (3 * r * r : U32)  # using 3 instead of pi, since Bend has no pi built-in
    case Square{+s}:
      (s * s : U32)

def main() -> U32:
  area(Square{5})    # => 25