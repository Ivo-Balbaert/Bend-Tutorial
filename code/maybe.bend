import Base

def add_strs(a: String, b: String) -> Maybe<&2, U32>:
  do Maybe<&2, U32>:
    x : U32 <- U32.read(a)  # a parse to U32 failure here short-circuits to None
    y : U32 <- U32.read(b)  # same as above
    return (x + y : U32)  # return is mandatory 

def main() -> Maybe<&2, U32>:
  add_strs("40", "2")  # => Some{42}
  # add_strs("40", "abc")  # => None{}