import Base

def choose(test: Bool, yes: U32, no: U32) -> U32:
    match test:
        case True{}:
            yes
        case False{}:
            no

def main() -> U32:
    x = {7 : U32}
    choose(U32.is_lt(x, 10), 1, 0)  # => 1