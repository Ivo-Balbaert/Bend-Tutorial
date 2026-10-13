import Base

def main() -> Array<U32> & U32:
  a = [0 : U32 * 5n]  # a new array of 5 copies of 0
  a[5] <- 42  # in-place rewrite (no copy!) — this re-binds `a`
  a[5]  # read index 5 (hands back the array + the element)
# => ([0, 0, 0, 0, 0, 42, 0, 0], 42)

# =>
SOME PROOFS FAIL
Error:
- message  : a power of two count (^d takes a depth)
Location:
3 | def main() -> Array<U32> & U32:
4>|   a = [0 : U32 * 5n]  # a new array of 5 copies of 0