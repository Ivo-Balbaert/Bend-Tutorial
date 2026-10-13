import Base
import LAWS.bend as laws

# PROOF: case analysis — base case is trivial, step case uses induction
def laws.add_zero(x):
    match x:
        case 0n:
            {==}
        case 1n+p:
            %laws.add_zero(p) : {1n+Nat.add(p, 0n) == 1n+_ : Nat}
            {==}

def main() -> {Nat.add(2n, 0n) == 2n : Nat}:
    laws.add_zero(2n)  # => {==}