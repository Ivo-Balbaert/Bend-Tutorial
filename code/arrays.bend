import Base

def main() -> Array<U32> & U32:
  a = [0 : U32 * 8n]  # a new array of 8 copies of 0
  a[5] <- 42  # in-place rewrite (no copy!) — this re-binds `a`
  a[5]  # read index 5 (hands back the array + the element)
# => ([0, 0, 0, 0, 0, 42, 0, 0], 42)