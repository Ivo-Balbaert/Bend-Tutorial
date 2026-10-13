import Base

# LAW: "for every x, x plus 0 equals x"
law add_zero:
    for x: Nat
    {Nat.add(x, 0n) == x : Nat}