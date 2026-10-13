import Base

def square(x: U32) -> U32:
  (x * x : U32)  # => Error: x is used (consumed) more than once
        
# Solution: def square(+x: U32) -> U32: