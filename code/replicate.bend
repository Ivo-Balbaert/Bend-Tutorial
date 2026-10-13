import Base

# -A: erased (gone at runtime)
#  n: affine (used at most once)
# +x: reusable (requires A to be Data)
def replicate(-A: Data, n: Nat, +x: A) -> List<A>:
  match n:
    case 0n:
      Nil{}
    case 1n+p:
      x <> replicate(A, p, x)  # "x <>" conses x onto the recursive result

def main() -> List<U32>:
  replicate(U32, 3n, 7)   # => [7, 7, 7]