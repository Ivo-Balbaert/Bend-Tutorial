import Base

def pick(b: Bool) -> String:
  match b:
    case True{}:
      "zero"
    case False{}:
      "non-zero"

def main() -> String:
  n = {5 : U32}
  pick(U32.is_eq(n, 0))  # =>  "non-zero"
