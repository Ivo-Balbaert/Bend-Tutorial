import Base

def greet(name: String) -> IO(String):
  do IO<String>:
    IO.sleep(1000)             # a side-effecting "step"
    return "Hello, " ++ name   # `return`: wraps a plain value as an IO result

def main() -> IO(Unit):
  do IO<Unit>:
    name : String <- IO.try(String, IO.get_env("USER"))  # <- : run & bind
    chan : Chan(String) <- IO.fork(String, greet(name))   # run concurrently!
    IO.print("Waiting...")
    text : String <- IO.join(String, chan)
    IO.print(text)

# => 
# Waiting...
# Hello, (value from USER)