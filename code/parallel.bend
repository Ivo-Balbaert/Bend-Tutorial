import Base

def pow2(+d: Nat) -> U32:
  match d:
    case 0n:
      1
    case 1n+p:
      a b = pow2(p) pow2(p)  # <-- the parallel call!
      (a + b : U32)

def main() -> IO(Unit):
  do IO<Unit>:
    IO.print(U32.show(pow2(20n)))  # calculates 2**20 on the CPU
    IO.print(U32.show(pow2!(20n)))  # calculates 2**20 on the GPU
# => 
# 1048576    
# 1048576