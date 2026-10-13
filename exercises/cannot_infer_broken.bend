import Base

def main() -> U32:
   x = 100
  (x : U32)   # => 108

# =>
SOME PROOFS FAIL
Error:
- expected : an annotated term (cannot infer)
- observed : 100
Location: main
3 | def main() -> U32:
4>|    x = 100
  |        ^^^
5 |   (x : U32)   # => 108