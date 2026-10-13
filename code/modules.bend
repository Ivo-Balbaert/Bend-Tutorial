# main
import Base
import ./math.bend as M         # M.square, M.anything_else_in_math_bend
# import helpers/math.bend as M   # math.bend in subfolder helpers

def main() -> U32:
  M.square(7)     # => 49