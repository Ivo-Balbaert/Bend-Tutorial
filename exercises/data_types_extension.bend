import Base

type Shape is Data:
  Circle{r: F32}
  Rectangle{w: F32, h: F32}
  Square{s: F32}

def area(x: Shape) -> F32:
  match x:
    case Circle{+r}:
      (3.1415 * r * r : F32)
    case Rectangle{w, h}:
      (w * h: F32)
    case Square{+s}:
      (s * s : F32)

def perimeter(x: Shape) -> F32:
  match x:
    case Circle{r}:
      (2.0 * 3.1415 * r : F32)
    case Rectangle{w, h}:
      (2.0 * (w + h: F32) : F32)
    case Square{s}:
      (4.0 * s : F32)

def main() -> IO(Unit):
  do IO<Unit>:
    IO.print(F32.show(area(Square{5.0})))  # => 25
    IO.print(F32.show(area(Circle{2.5})))  # => 19.634377
    IO.print(F32.show(area(Rectangle{5.0, 2.0})))  # => 10

    IO.print(F32.show(perimeter(Square{5.0})))  # => 20
    IO.print(F32.show(perimeter(Circle{2.5})))  # => 15.7075
    IO.print(F32.show(perimeter(Rectangle{5.0, 2.0})))  # => 14