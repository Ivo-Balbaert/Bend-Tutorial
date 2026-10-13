import Base

def adder(k: U32) -> U32 -> U32:
  x => (x + k : U32)

def main() -> U32:
  add2 = adder(2)
  add5 = adder(5)
  add5(add2(add2(1)))  # => 8    # => Error
# because (1 + 2) + 5 = 8

# =>
SOME PROOFS FAIL
Error:
- expected : add2
- observed : add2 (consumed more than once)
Location: main
6 | def main() -> U32:
7>|   add2 = adder(2)
  |   ^^^^
8 |   add5 = adder(5)