import Base

def pick(b: Bool, a: U32, c: U32) -> U32:
    match b:
        case True{}:
            a
        case False{}:
            c

def main() -> U32:
    x = {7 : U32}
    pick(U32.is_lt(x, 10), 1, 2)  # => 1