# Bend for Python Programmers — A Tutorial

> *"It looks like Python, it thinks like Haskell, it runs like C, and it scales
> like CUDA."* Welcome to Bend — let's take it for a spin!

If you already know basic Python (indentation, variables, functions with `def`, colons and `#` comments, 
`if`/`for`, lists, maybe a class or two) or the equivalent in another programming language, 
you have everything you need to start writing real Bend programs today. 
Bend's syntax was deliberately designed to feel like Python so that you'll feel at home immediately.

But under that friendly surface lives a very different, very exciting engine:
* It is **pure**, **functional**, and **parallel by design**. 
* It can run the same code in parallel on many CPU cores or on a GPU, with no threads, locks or kernels. 
* It can even mathematically *prove* your program code is correct.

These points are elaborated a bit more in § [1](#1-what-is-bend-and-why-should-you-care). We'll show you concrete code to experiment with
in the rest of the tutorial to illustrate them in detail.

Don't worry — we're not going to throw you into a parallel-computing,
formal-proof deep end on page one. We'll build up gently, always comparing to
the Python you already know, and by the end you'll understand what makes Bend
special and why it's worth getting excited about.
The code examples can be found in the *code* folder. 
Try-outs, tests and exercises can be found in the *exercises* folder, but only after you have tried them yourself! 
All code-files that deliberately do not compile have a name that ends in `_broken.bend`.

Welcome to Bend and let's get bending! 🙂

> The code in this tutorial was tested against version 2.0.37

Throughout the text, we'll use **Python difference #n:** to make clear some key differences between Bend and Python.
As a convention, we use `# =>` to show the output of a code line, like: # => "Hello" when "Hello" is shown on the command-line.


## Table of Contents

1. [What Is Bend, and Why Should You Care?](#1-what-is-bend-and-why-should-you-care)
2. [Installing and Exploring Bend](#2-installing-and-exploring-bend)
3. [Hello, World! — Your First Bend Program](#3-hello-world--your-first-bend-program)
4. [Basic Syntax: Variables, Numbers, and Expressions](#4-basic-syntax-variables-numbers-and-expressions)
5. [Functions: Bend's Take on `def`](#5-functions-bends-take-on-def)
6. [Collections: Lists, Tuples, and Arrays](#6-collections-lists-tuples-and-arrays)
7. [Making Your Own Data-types](#7-making-your-own-datatypes)
8. [Pattern Matching: Bend's `if`/`elif` Replacement](#8-pattern-matching-bends-ifelif-replacement)
9. [Recursion and Termination: Why Bend Has No `while`](#9-recursion-and-termination-why-bend-has-no-while)
10. [The Big One: Affine Types and Quantities](#10-the-big-one-affine-types-and-quantities)
11. [Closures and Templates](#11-closures-and-templates)
12. [Doing Things: IO, Effects, and the `do` Notation](#12-doing-things-io-effects-and-the-do-notation)
13. [Parallelism: Splitting Work Across Cores and GPUs](#13-parallelism-splitting-work-across-cores-and-gpus)
14. [Modules: Organizing Code Across Files](#14-modules-organizing-code-across-files)
15. [Laws and Proofs: Code That Can't Lie](#15-laws-and-proofs-code-that-cant-lie)
16. [The `bend` Command-Line Tool, Cheat Sheet](#16-the-bend-command-line-tool-cheat-sheet)
17. [Python ↔ Bend Quick-Reference Table](#17-python--bend-quick-reference-table)
18. [A Bend Cheat sheet](#18-a-bend-cheat-sheet)
19. [Honest limitations](#19-honest-limitations)
20. [Where to Go Next](#20-where-to-go-next)

---

## 1. What Is Bend, and Why Should You Care?

Bend is a new, young, and genuinely novel general purpose programming language. Here's the
pitch in plain terms:

- **It looks like Python.** 
Indentation-based blocks, a `def` keyword, and lightweight syntax, so reading code is easy.
- **It compiles and executes fast: it runs like C — and then like CUDA.** 
The same Bend program transpiles to one C file, plus Metal or CUDA for the GPU. 
The resulting compiled native binary is as fast as hand-written C on one CPU core. 
If no GPU is present, the program can be executed in parallel on many or all CPU cores.
When there is a GPU, the same code can automatically be executed across thousands of GPU cores 
indicated in code with a single `!`.
- **It's parallel without the pain.** 
You write a divide-and-conquer function, and Bend spreads the calls across every core it can find.
- **It behaves like Haskell/Lean.** 
It's a *pure, functional* language: once you compute a value, it never silently changes. 
Side effects such as printing, reading files and networking, are explicit and tracked by the type system.
- **It can prove that your code is correct.** 
Bend has a built-in proof system. You can write a "law" such as *"this sorting function always returns an ascending list"*
and Bend's compiler will refuse to compile until you *mathematically prove* it. 
- **It is an AI-native programming language**
It is especially aimed at a world where AI assistants write lots of code, piling up bugs and hallucinations, 
and projects grind to a halt. The result: human code auditing becomes untractable, the so-called AI Doom Loop.
Bend gives you a way to make sure the AI's code is *actually* correct by formally verifying the implementation, 
not just that it "looks right". This works for any change of the code, which makes it hack-proof.
It is the first programming language to work like that.

If you're coming from Python, think of the journey like this: Python optimizes
for *how fast you can write code*. Bend optimizes for *running the code blazingly fast* and 
*how confident you can be that the code is right*. It asks you to
be a bit more explicit (more type annotations, more discipline about how
values are reused) in exchange for guarantees Python simply cannot give you.

> **Bend is young**
> Expect occasional rough edges, and syntax may evolve
> When in doubt, run `bend guide`, which prints the guide for your installed version.
> But it's a wonderfully fun language to learn, and this tutorial will get you writing real programs fast.

---

## 2. Installing and Exploring Bend

Bend currently targets Linux and macOS, on Windows use WSL for now. 
(A Windows native version is expected in the mid-term future, either by the original developers
or external contributors.) 

Install Bend with a single shell command (similar to installing `rustup` or `uv`):

```bash
curl -fsSL https://bend-lang.com/install.sh | sh
```

That's it — you now have a `bend` command, much like `python` is a command once you install Python.
To make the command system-wide available: expand your PATH with Bend's bin directory by appending 
`export PATH="$HOME/.bend/bin:$PATH"` to your `.profile` or `.bashrc`.  

Once installed, you can ask Bend to teach you more about itself, right from the terminal:

```bash
bend version          # shows the currently installed version, for example: bend 2.0.36  
bend guide            # prints the official guide
bend base             # prints the standard library reference
bend base Type        # prints all info on type Type, for example: bend base String
bend --help           # lists every command
```

The last command shows you that `bend` is a one-file binary that contains a lot of functionality.
The command `bend update` install the latest version, without you having to uninstall the previous one.

> Hint: To ease editing Bend code in Visual Studio Code, install a VS Code extension for Bend, such as 
> Bend 2 for VS Code.
---

## 3. Hello, World! — Your First Bend Program

Create a mixed-language Hello World program ('World' is in Japanese here) called `hello.bend`:

```py
# hello.bend:
import Base

def main() -> IO(Unit):
  IO.print("Hello, 世界 from Bend!") # => Hello, 世界 from Bend!
```

Run it just like you'd run a Python script:

```bash
bend hello.bend
```

You'll see:

```
Hello, 世界 from Bend!
```

Notice the indentation (two spaces). This is mostly by convention to indicate and separate code blocks, 
but be consistent to enhance readability!  

Let's unpack this, piece by piece, because almost every part of it has a Python analogue:

| Bend                             | Python                       | Meaning                                                              |
|----------------------------------|------------------------------|----------------------------------------------------------------------|
| `import Base`                    | `import` (implicit builtins) | Loads Bend's standard library. Every Bend file starts with this.     |
| `def main() -> IO(Unit):`        | `def main():`                | Defines a function named `main`. for `-> IO(Unit)`, see below.       |
| `IO.print(...)`                  | `print(...)`                 | Prints a string.                                                     |
| `#`                              | `#`                          | Starts a comment (in a) code line.                                   |

As output, we see the string "Hello, 世界 from Bend!" printed on the screen.
The big new idea here is `-> IO(Unit)`. In Python, `print` just... prints,
whenever you call it, without any fuss. 
Bend is a *pure* language: a function is normally only allowed to compute values, not change the world (print to the
screen, write a file, make a network call). Changing the world is always input - output, in other words: IO.
To change the world, a function must *say so* in its return type (`->`), by returning something wrapped in `IO(...)`.
`Unit` is Bend's equivalent of Python's `None` which stands for: "no meaningful value, just that something happened."
Think of `IO(Unit)` as a function's way of declaring: *I perform effects (here printing) and return nothing interesting (`Unit`)*.
This is one of Bend's core differences from Python: side effects are visible in the type, not hidden inside the function body.

Now try to print two messages after one another, so we have two effects:

```py
# hello_broken.bend:
import Base

def main() -> IO(Unit):
  IO.print("Hello, 世界 from Bend!") 
  IO.print("Hello, World from Bend!") 
```

Running this code with $ bend hello_broken.bend confronts you with your first Bend error:
SOME PROOFS FAIL
Error:
- expected : 'def', 'type' or 'law'
- observed : 'I'
Location:
4 |   IO.print("Hello, 世界 from Bend!")
5>|   IO.print("Hello, World from Bend!")
  |   ^
6 |

The error message isn't terribly clear I'm afraid, it just tells you something is wrong starting at line 5.
But at least you now get acquainted with the general format of a Bend error:
- Compare observed : 'I' with what the compiler expects: expected : 'def', 'type' or 'law'
- you see the Location where the error occurred (start line 5)

What is wrong here? 
It turns out that if there is more than one IO call or IO effect, we need to add a `do IO<Unit>` at the start of the effect-block, as in:

```py
# hello_do.bend:
import Base

def main() -> IO(Unit):
  do IO<Unit>:  # start of effect-block
    IO.print("Hello, 世界 from Bend!") # => Hello, 世界 from Bend!
    IO.print("Hello, World from Bend!") # => Hello, World from Bend!
```

`do IO<Unit>:` opens an "effect block", which is a sequence of real-world actions. There is no Python equivalent for this annotation.

Remark: In a real program you'll most probably have more than one IO effect called in main(). So get used to adding a `do IO<Unit>:` line
in `main()`, it works also if there is only one effect!  

**Python difference #1:** Bend is *pure*. A function can't secretly print or read files. Anything that touches the outside world must say so in its type, with `IO`.

---

## 4. Basic Syntax: Variables, Numbers, and Expressions

To show many of Bend's features, we don't need IO. 
If main() returns only one value, it is simply shown as output.
So let's work pure! 

### Variables 

```py
# variables.bend:
import Base

def main() -> U32:  # 1 return type
  x = {100 : U32}   # 2 binding
  y = {8   : U32}
  (x + y : U32)     # 3 return value
# => 108 
```

Line 2 shows a typical *binding*: x owns (or gets) the value 100, which is of type U32.
The `: U32 ` part is a **type annotation**. `U32` is an unsigned 32-bit integer. With a minimum value of 0 and a maximum of 4294967295,
`U32` wraps around after about 4.295 billion.

The last line, `(x + y : U32)` differs from what you see in Python. There `main`'s last expression isn't special
unless you `return` it. In Bend, **the final expression in a function body is automatically its result**. This is like the last expression in a Python lambda, but it is true for *every* function body, not just lambdas.

You also note that Bend does very little *type inference* on purpose (more on why in a moment). 
So you tell the compiler: `(x + y : U32)` meaning "treat this as U32 arithmetic." 

Test it: 
Simplify the above program to the following:
```py
# cannot_infer_broken.bend
import Base

def main() -> U32:
  x = 100
  (x : U32)   # => 108
```
Try to compile it with: `$ bend cannot_infer_broken.bend`. 
You get the following error:

SOME PROOFS FAIL                                # 1
Error:
- expected : an annotated term (cannot infer)   # 2  
- observed : 100
Location: main
3 | def main() -> U32:
4>|   x = 100
  |       ^^^
5 |   (x : U32)   # => 108

Line 2 definitely shows `x` needs a type annotation! You'll get this error for any variable or expression that has no type indication.
Now correct the program (see `infer.bend`). For line 1, see § [15](#15-laws-and-proofs-code-that-cant-lie).

> **Why does Bend need so many type annotations, when Python needs almost none?**
> Python decides types *at run time* — it doesn't check your program before
> running it at all. Bend checks everything *before* running the program
> (like `mypy`, but mandatory and far deeper — it can check full mathematical
> proofs!). That deep, fast checking is only possible because Bend asks you,
> the developer, to spell out what you mean instead of letting the compiler
> guess. 
> It's a trade: a little more typing, for faster compilation and execution, much stronger
> guarantees and a very fast proof-checker.

### Numeric types

Bend has three core number types, each matching a distinct Python mental model:

- `U32` — a 32-bit unsigned integer, like `ctypes.c_uint32`, used for regular
  "counting" numbers. Literal: `42`.
- `Nat` — an unbounded natural number (0, 1, 2, ...), closest to Python's
  arbitrary-precision `int` (but positive only). Literal: `3n` (note the
  trailing `n`). Used heavily for recursion because it has a really clean
  "successor" structure (`0n`, `1n+p`, see below).
- `F32` — a 32-bit float, like a narrower Python `float`. Literal: `1.5`.

There is no 64-bit integer or double-precision float yet — a current
limitation of this young language.

### Char and String types

A Unicode character is of type Char, a literal Char value is written as `'a'`.
A text is of type String, a literal String value is written as `"hi"`.
A String is currently implemented as a linked list of characters. This is not optimal for heavy text processing: this is slow. If you need fast indexed access, use an `Array` (§ [6](#6-collections-lists-tuples-and-arrays)).

### Operators

Bend has operators like `+ - * / %` (arithmetic), `&& ||` (booleans), `++` (string
concatenation, like "Hello, " ++ name), and `< <= > >= ==` (comparisons), and they need spaces around them. 
Most of them **only work inside a type annotation** like (x + y : U32), which you can read as "compute `x + y` *as* a `U32`".
This is necessary because `+` and so on. are secretly shorthand for a method call like `U32.add(a, b)`, and Bend needs to know which type's `add` to use:

```py
(x + y : U32)     # ok: "+" is sugar for U32.add(x, y)
x + y             # error: Bend doesn't know which type's "+" to use
```

The naming pattern is `Type.verb` (`U32.add`, `Nat.show`, `F32.mul`), so you can usually guess names. 
Conversions look like `U32.to_nat`, and `U32.show` turns a U32 number into a `String`.

In Python `+` "just works", based on the runtime types of its operands. In Bend, you tell it up front.

**Python difference #2:** `==` is *not* an equality test on values, instead it appears inside types (see § [15](#15-laws-and-proofs-code-that-cant-lie)). 
Use `U32.is_eq(a, b)` (which returns a `Bool`) to see if two U32 values a and b are equal. 

---

## 5. Functions: Bend's Take on `def`
As an example, let's make an add function for the sum of two U32 integers:

```py
# adding_ints.bend:
import Base

def add(x: U32, y: U32) -> U32:
  (x + y : U32)

def main() -> U32:
  add(2, 40)  # => 42
```

Side-by-side with Python:

```py
# Python
def add(x: int, y: int) -> int:   
    return x + y

add(2, 40)  # => 42
```

Spot the differences:

- **Type annotations are mandatory** in Bend — `x: U32`, not just `x`.
   Python's annotations are just hints for humans and tools like `mypy` and can be left out.
   Bend's are enforced by the compiler before your code ever runs.

- **No `return` keyword.** As we noted in the previous section, the last expression of the function body is the
   result, always.

What they have in common:

- **Colon-and-indent blocks**, exactly like Python. No curly braces, no
   semicolons. If you can indent Python correctly, you can indent Bend
   correctly.


Top-level `def`s can be called as many times as you like, but the definition of a function
must precede the call(s) of the function (Try that out!).

Let's see what the basic types of collections look like in Bend:

---

## 6. Collections: Lists, Tuples, and Arrays

### Tuples

```pyCon{h, t} 
(a, b)          # build a pair from a and b
(a, b) = v      # destructure it into a and b
```
Tuples in Bend work exactly like Python's `(a, b) = some_pair`.

### Lists

In Python, a list is an array. In Bend, a list is a **linked list**, built from two constructors
Nil{} and Con{h, t}:

```py
[1, 2, 3, 4]        # list literal, sugar for Con{1, Con{2, ... Nil{}}}
Nil{}               # the empty list
Con{h, t}           # head h, tail t, Con constructs the pair containing h and t
h <> t              # same as Con{h, t}
```

This is same structure you'd get from Scheme/Lisp/Haskell. It is great for recursion (see § [9](#9-recursion-and-termination-why-bend-has-no-while)), but not ideal for random access (no `xs[5]` in O(1) time the way Python's `list` offers).
`Nil{}` is the empty list (like Python's `[]`), and `Con{h, t}` splits a
non-empty list into its head `h` and tail `t` — the classic "cons cell" from
functional programming, equivalent to Python's `xs[0]` and `xs[1:]`.

Here is how a list type is written in Bend: List<U32>, a List with elements of type U32. 
A trivial program that returns and shows a List:

```py
# lists.bend
import Base

def main() -> List<U32>:
  [1, 2, 3, 4]    # => [1, 2, 3, 4]
```
Typically variable names such as xs and ys are used for Lists.
You take a list apart with `match`:

```python
match xs:
  case Nil{}:
    ...             # empty
  case Con{h, t}:
    ...             # h is the first element, t is the rest
```

There is no `xs[0]` and no `len(xs)` built in. Base provides list functions, and `bend base List` prints them. 


### Arrays  

Arrays allow for in-place and safe mutations.
This is where Bend's affine system (see § [10](#10-the-big-one-affine-types-and-quantities)) pays off directly. In Python, mutating a
list is trivial but can cause subtle bugs if two variables alias the same list:

```py
# Python
a = [0] * 8      # initializing an array
b = a            # b and a point to the same list!
b[5] = 42        # a[5] is now ALSO 42 — surprise aliasing
```

An `Array<T>` is of kind `Type`, which means it has a single owner and aliasing is not 
possible by construction (we'll explain this in depth in § [10](#10-the-big-one-affine-types-and-quantities)). 
This gets you in-place mutation *with* safety guarantees.
Because there's only ever one "owner" of the array, Bend's compiler can overwrite the memory directly instead of copying the whole array first — this is how Bend gets C-like speed with none of C's manual-memory-management risk.

```py
# arrays.bend:
import Base

def main() -> Array<U32> & U32:
  a = [0 : U32 * 8n]  # a new array of 8 copies of 0
  a[5] <- 42          # in-place rewrite (no copy!) — this re-binds `a`
  a[5]                # read index 5 (hand back the array + the element)
# => ([0, 0, 0, 0, 0, 42, 0, 0], 42)
```

What happens here:
- `[0 : U32 * 8n]` creates 8 copies of `0`. The slot count is a power of two (test it!). 
  `[0 : U32^3n]`  states the same thing by depth (2³).
- `a[5] <- 42` writes in place. Because an `Array` is a `Type` (one owner), nobody else can see the old version, so no copy is needed.
Note that a write (`a[5] <- 42`) hands you back the *same* array so you can keep using it.
In Python terms, imagine `list.__setitem__` returning the list itself so you must explicitly chain or re-assign it.
- **A read like `a[5]` gives the array back next to the element**, because otherwise the array would be consumed. 
Returning a[5] gives you a tuple consisting of the array and the specific value asked for of type Array<U32> & U32, 
which is the return value of `main()`.
- Array indexes **wrap around**, so an out-of-bounds error cannot occur.
- The `a[i]` sugar assumes `Array<U32>`. For other element types, use `Array.get` / `Array.set` / `Array.clone` from Base.

---

## 7. Making Your Own Data-types

We have seen some basic data-types, such as U32, Nat; Char and String.
How do you define your own data-types in Bend?

In Python, you'd represent a shape using a class hierarchy or a tagged tuple:

```py
# Python
class Circle:
  def __init__(self, r):
    self.r = r

class Square:
  def __init__(self, s):
    self.s = s
```

In Bend, you declare a `type` (here `Shape`), declaring it with `is Data`.
Then list every possible "Shape" (which is called a constructor) it can take (see lines #1-3)
This will feel similar to Python's `Enum` combined with `dataclass`, or a Rust/Haskell-style `enum`:

```py
# data_types.bend:
import Base

type Shape is Data:   #1
  Circle{r: U32}      #2
  Square{s: U32}      #3

def area(x: Shape) -> U32: #4
  match x:            #5A
    case Circle{+r}:  #5B
      (3 * r * r : U32)     # using 3 instead of pi, since Bend has no pi built-in
    case Square{+s}:
      (s * s : U32)

def main() -> U32:
  area(Square{5})     #6 => 25
```

Key new vocabulary and what it means:

- Line #1: `type Shape is Data:` declares a new datatype called `Shape`. 
Each indented line below it (`Circle{r: U32}`, `Square{s: U32}`) is a **constructor**. 
Lines 1-3 look like a named, fixed-shape "variant." 
You build a value with (see line 6)
  `Circle{7}` or `Square{5}` (similar to calling `Circle(r=7)` in Python).
- `is Data` vs. `is Type`: this is Bend's **Kind** system, and it's new to
  Python programmers. 
    **`Data`** means "this type's values are copyable/droppable
  freely, like a plain number or string." 
    **`Type`** means "non-copyable" (more on this crucial difference in §  [10](#10-the-big-one-affine-types-and-quantities))
    For ordinary data like shapes, numbers, and enums, use `Data`.
-  Line #4: `def area(x: Shape) -> U32:` 
  There are no methods in Bend. You write functions that take the variable instance as an argument, here (x: Shape), 
  and by convention name them `Type.verb` as in  `Shape.area`.
- Line #5A-B; `match x: case Circle{+r}: ...` **unwraps** the Shape value, 
  binding `r` in the body code of the `case` to the circle's radius field.
  This is similar to Python's structural pattern matching (`match`/`case` syntax added in Python 3.10), 
  except Bend's `match` is used everywhere as we'll see below, not just for fancy cases.
  Such `case` patterns can nest, and `_` matches anything.
- The `+` in `Circle{+r}` says "I may use `r` more than once inside this
  branch", or in other words: "`r` can be copied". (again, §  [10](#10-the-big-one-affine-types-and-quantities) explains why that's even a question). 
  That only works because `Circle` and `Square` are declared to be of type `Shape`, 
  which is said to be of Kind `Data` in line #1. 
 
If you've used Python 3.10+ `match`/`case` or dataclasses with `Enum`, this
will feel comfortably familiar.
So in Bend, instead of classes, you declare **algebraic data-types**: a type with one or more constructors.
Let's now see how pattern matching is used in Bend to mimic the Python `if elif else` construct.  

*Try it out:*
It's a bit lame to use 3 for PI don't you think?
Go ahead and change U32 into F32, so that you can use 3.1415 for example as approximation for PI.
Make a `Circle{}` and call `area` on it. You'll have to print out the result with `IO`: see hello.bend above.
(Solution: see exercises\data_types_f32.bend) 

---

## 8. Pattern Matching: Bend's `if`/`elif` Replacement

Here's a fact that will surprise Python programmers: **Bend has no `if`
statement. Instead, booleans are just an ordinary two-constructor
datatype — `True{}` and `False{}` — and you branch on them with `match`,
exactly like you'd branch on `Circle`/`Square` above:

When you have to test on a variable having a certain value, Python might do:

```py
def classify(n):
  if n == 0:
    return "zero"
  else:
    return "nonzero"
```

In Bend, this is the way to do it:

```py
# classify.bend:
import Base

def pick(b: Bool) -> String:
  match b:
    case True{}:
      "zero"
    case False{}:
      "non-zero"

def main() -> String:
  n = {5 : U32}
  pick(U32.is_eq(n, 0))  # =>  "non-zero"
```

It's a little more verbose, but conceptually it's the exact same idea as
Python's structural `match`/`case`. Bend simply leans on it for *all*
conditional logic, rather than offering a separate `if`.
The `{}` after `True` and `False` matter: every constructor in Bend is written with braces, 
even when it carries no data.

A couple of extra pattern-matching superpowers worth knowing:
- **`match` can only inspect a parameter or an already-bound variable, not an arbitrary computed expression.**
  `match sum(xs, 0):` is *not allowed* —
  This is unlike Python, where you can `match` any expression. If you need to branch
  on a computed value, pass it into a small helper function and match on its
  parameter instead. 
  Example: 
  ```python
    match U32.is_eq(n, 0):   # ❌ NOT allowed
  ```
  Instead call a helper function like `pick(U32.is_eq(n, 0))` in the previous example.
  This restriction exists to support Bend's termination checker (see § [15](#15-laws-and-proofs-code-that-cant-lie)) and its proof system.

As a simple exercise, write a program that prints 1 when a given number is < 10, and 2 if it isn't.
(Hint: use a Base function of the form: `U32.abc`, see exercises\check_less_than.bend.)

- **Matching numbers directly.** 
`Nat` values pattern-match as `0n` (zero) or 1n+p` (the successor of `p`, 
i.e. "the number equal to one more than `p`"). This mirrors how you might think of `n == 0` 
vs. `n - 1` in a Python recursive function, but baked directly into Bend's match syntax:

```py
def is_even(n: Nat) -> Bool:
  match n:
    case 0n:
      True{}
    case 1n+p:
      False{}
```
- A `match` expression always lists every case.

**Python difference #3:** Instead of `if/else`, think "pattern matching", not "conditions". Python's `match` (3.10+) is the nearest cousin, and if you've used it you're ahead.

---

Now you're probably asking: how do I write a loop in Bend?


## 9. Recursion and Termination: Why Bend Has No `while`

Python loops freely:

```py
# Python
total = 0
for x in [1, 2, 3, 4]:
    total += x
```

Bend, as a pure functional language, has **no `while` loop and no `for` loop**. 
All repetition happens via **recursion**, which is when a function calls itself, as in the following example that computes the sum of all elements of a List:

```py
# sum.bend
import Base

def sum(xs: List<U32>, acc: U32) -> U32:
  match xs:
    case Nil{}:                  #1
      acc
    case Con{h, t}:              #2
      sum(t, (acc + h : U32))  

def main() -> U32:
  sum([1, 2, 3, 4], 0)    # => 10
```

The accumulator `acc` starts at 0. Whenever the List is not empty, the List is split up in a head `h` and tail `t` (line 2). `h` is then added to `acc`, and `sum` is again on `t` and the new value of `acc`.
The accumulator `acc` replaces Python's changing variable `total`. Each call hands the *new* value to the next call. The compiler also turns tail calls into real loops, so there's no stack overflow.

**Termination is mandatory**
Here's the part that really sets Bend apart: **the compiler mathematically verifies that every recursive function eventually finishes.** It does this by checking that each recursive call passes something *strictly smaller* than what it started with (here, `t` is always one element shorter than `xs`). 
This is a hard requirement, not a lint warning: a function that can't be proven to terminate simply won't compile (unless you explicitly opt out, see below).

Why such strictness? Because Bend doubles as a *proof assistant*. If a function could loop forever, it could "prove" absolutely anything (an infinite loop has no well-defined value, which breaks the logic that proofs rely on). So Bend insists: every normal function must provably finish.

Practical rules:
- **Counters are `Nat`s.** A `U32` can't be matched as "one more than something", but a `Nat` can:

```python
  match n:
    case 0n:        # zero
      ...
    case 1n+p:      # one plus p; recurse on the smaller p
      ...
```

A `Nat` is a machine word at runtime, so it's fast.
- **Put the shrinking parameter first in the function definition and call** 
Example: xs in `sum(xs: List<U32>, acc: U32)` and  `sum([1, 2, 3, 4], 0)`.
The checker reads arguments left to right, and each must be unchanged until one gets smaller. Everything after that is free.
- **No mutual recursion.** For the same soundness reasons mentioned above. Merge two functions into one with an extra argument that selects which behavior to run.
- **Servers and event loops** that "run forever" take a `Nat` argument and count down.
- If you genuinely **need unrestricted recursion** (e.g., a server's main loop, or quick prototyping), you have an escape hatch:

```py
def f?(x: A) -> T:      # the "?" suffix means "skip the termination check"
  ...
```

or the equivalent `@unsafe def f(x: A) -> T:`: it turns the check off, at the cost of Bend's proof guarantees. 
Using it is like disabling `mypy` for one function — the compiler will still check the rest of your program, 
but it prints a clear warning ("SOME PROOFS FAIL") naming every function that depends on the unchecked one. 
It's an honest, visible trade-off, not a silent one.

**Python difference #4:** no `while True`. If that feels restrictive, remember what you get in return: a function that always returns, which is what makes proofs trustworthy.

> Compared to the **Python mental model:** think of Bend's termination checker like Python's
> recursion limit, except instead of crashing at run time with
> `RecursionError`, Bend tells you *before your program ever runs* whether
> it's guaranteed to finish.
---

## 10. The Big One: Affine Types and Quantities

This is the single biggest conceptual shift from Python, so let's take it
slowly, with a concrete motivating example.

In Python, variables are just labels — you can read a variable as many times
as you want:

```py
# Python: totally ok
x = [1, 2, 3]
print(x)
print(x)
print(len(x))
```

Python lets you write `y = x + x`. Bend does not, unless you ask explicitly for it with a + prefix. 
Why? If a value is used only once, the compiler can reuse its memory in place, with no garbage collector. Bend has *no* GC. Bend is, by default, **affine**: every variable may be used **at most once**.

In the following code, x is affine, so cannot be used two times in line 1.
```py
# math_broken.bend:
import Base

def square(x: U32) -> U32:
  (x * x : U32)    #1 => Error: x is used (consumed) more than once
```

Remark: The same error would occur if we had several lines with `IO.print(x)` (try it!).
This probably feels alarming at first — "wait, I can't reuse a variable?!" —
but it's the mechanism that lets Bend do two amazing things:

1. **Mutate data in place safely**, without a garbage collector and without
   risking surprise aliasing bugs. Aliasing means: another binding exists for the same 
   value with a different name, and the value could be changed through the new name, also
   changing the value the first name points at.
2. **Run code in parallel with zero data races**, because if a value can only
   be used once, two parallel branches can *never* secretly (step on) use each
   other's data.

We can remedy this behavior (only if really needed, because you lose the advantages just stated!) by
prefixing `x` with a `+`:

```py
# math.bend:
import Base

def square(+x: U32) -> U32:
  (x * x : U32)
# =>
# ALL PROOFS CHECK
# Use - -verdict for mathematical validity.
```
There is no `def main()` in this file, because it is a module (see § [14](#14-modules-organizing-code-across-files)). That's why there is no output!
It will be called from another code file that contains a `def main()`. 
Can you now explain why the `area` function in § [7](#7-making-your-own-datatypes) had `Circle{+r}`?
(Answer: because `3 * r * r` uses `r` twice.)

### The three quantities

Every variable you introduce can be marked with a prefix that says how many times it may be used:
 
| Prefix   | Name     | Meaning                             | Python analogy           |
|----------|----------|-------------------------------------|--------------------------|
| *(none)* | affine   | Used **exactly once** (the default) | A value you `del` right after using, conceptually |
| `-x`     | erased   | Exists only for the *type checker*; deleted before your program runs | A type hint that never affects run-time behavior |
| `+x`     | reusable | May be used **any number of times**, but *only* allowed for types of kind `Data` | An ordinary Python variable, used freely |

Reusable values cost a little: Bend keeps a reference count at runtime for `+` values only.

Here is an example that makes a List with 3 times the value 7:
```py
# replicate.bend:
import Base

# -A: erased (gone at runtime), it's a Type of Kind Data
#  n: affine (used at most once)
# +x: reusable (requires A to be Data)
def replicate(-A: Data, n: Nat, +x: A) -> List<A>:
  match n:
    case 0n:
      Nil{}
    case 1n+p:
      x <> replicate(A, p, x)   
# "x <>" conses x (like Con{x, t}, onto the recursive result 

def main() -> List<U32>:
  replicate(U32, 3n, 7) # => [7, 7, 7]
```
For Cons, see §  [6](#6-collections-lists-tuples-and-arrays).

Here, `x` is marked `+`, which means it can be used more than once, exactly two
times in the following line:   `x <> replicate(A, p, x)`.
In exchange, `+` is only legal for types of kind `Data  
(your "plain old data" — numbers, enums, lists of copyable things), so
the compiler can insert an efficient reference count instead of a deep copy.

Notice: `replicate` takes the *type* `A` as an argument. This shows that Types are ordinary values in Bend, which is what **dependent types** means.

### `Data` vs. `Type`: the "can this be copied?" kind
Remember `is Data` back in Section 6? Here's the full picture:

In Bend, & stands for a quantity. 
So &1 means: use one time only, and &2 means: use two or more times .

- **`Data`** (short for `Kind(&2)`): values can be *used more than once* (`+`); they are *freely copyable*.
  Use this for ordinary data like your `Shape` example, numbers, lists of numbers, strings, and so on.
- **`Type`** (short for `Kind(&1)`): values are *strictly single-use*; they are *never copyable*. 
  Functions, closures (see §  [11](#11-closures-and-templates)), arrays, and IO handles (files, sockets) are always `Type`. 
  Bend won't let you accidentally keep two references to an open file or a mutable array,
  the same way Rust's borrow checker prevents aliasing bugs.

If you've used Rust, this will click instantly: Bend's affine system is
basically Rust's ownership model, minus the borrowing (`&`/`&mut`) part.
It is simpler, at the cost of being a little more restrictive.

If you haven't used Rust, here's the Python-flavored intuition: imagine if,
every time you passed a `list` into a function, Python "moved" it out of your
hands instead of sharing a reference — the caller could no longer use it
afterward unless the function explicitly handed it back. That's exactly what
happens with values of kind `Type` in Bend, and it's precisely what makes
things like in-place array mutation (§ [6](#6-collections-lists-tuples-and-arrays)) and 
parallelism (§ [13](#13-parallelism-splitting-work-across-cores-and-gpus)) safe.

> **Takeaway for the impatient:** when you see a simple variable with
> no prefix, it's used once. See a `+`? It can be reused, and its type must be
> `Data`. See a `-`? It only matters for the type-checker/proofs and vanishes
> at run time. That's the whole system!

**Rule of thumb for beginners:** if the compiler complains that you used a variable twice, and it's a `Data` value, add a `+` to its name (in the parameter list or in a pattern). If it's a `Type` value, restructure so it's used once, for example by passing it along and getting it back.

---
## 11. Closures and Templates

### Closures — functions as values

Just like Python, Bend functions are values you can store, pass around, and return.
In the following code you can see that `adder` is a function that takes a U32 parameter `k`, 
and returns a function:  `x => (x + k : U32)`  of type `U32 -> U32`:

```py
# closures.bend
import Base

def adder(k: U32) -> U32 -> U32:
  x => (x + k : U32)

def main() -> U32:
  add2 = adder(2)
  add5 = adder(5)
  add5(add2(1))   # => 8    (because (1 + 2) + 5 = 8)
```

`x => (x + k : U32)` is Bend's lambda syntax — directly comparable to Python's `lambda x: x + k`. 
The return type `U32 -> U32` reads as "a function from `U32` to `U32`," 
same idea as a type hint like `Callable[[int], int]`.
By calling adder with different `k`-values, you create new functions like add2 and add5, which
are in fact *closures* (sometimes also called partial applications): they take their argument value 
to define a specialized add function. For each value of `k` `adder` is called, the binary contains  
a specialized compiled function.
 
The catch is this: **a closure is affine — it can be called at most once**, even if everything it 
captured is freely reusable `Data`. (Test this out! see `closures_broken.bend`.)
Only functions declared at the top level with `def` can be called an unlimited number of times. 
This is unlike Python, where you can call the same closure as many times as you like.

### Templates — compile-time-specialized functions

To remedy that closures are affine, Bend also has **templates**, written with `~`. 
These are a bit like Python decorators that generate specialized code, or C++ templates.
The `twice` function takes a (template) function as first parameter:
 `def twice(~f: U32 -> U32, x: U32) -> U32:`

```py
# templates.bend:
import Base

# ~f: substituted at compile time, not passed at runtime
def twice(~f: U32 -> U32, x: U32) -> U32:
  f(f(x))

def main() -> U32:
  twice(~(x => (x + 1 : U32)), 40)   # => 42
```

Unlike a closure argument, a `~` argument is substituted in *at compile time*: the
compiler generates a fresh copy of `twice` for each distinct function you pass
it. So templates are functions that inline their arguments.
A `~` parameter receives *code*, which the compiler pastes in.

There's no runtime cost, and (unlike a regular closure) the inlined
function can be called as many times as needed inside `twice`. Think of it as
similar to how Python's `functools.partial` or a decorator factory generates
specialized behavior, except Bend does it fully at compile time, with zero
runtime overhead.

**Rules:** 
* template parameters come first, 
* the `~` argument must be "closed" (it can mention top-level defs, 
but not local variables of the caller), 
* and each distinct set of `~` arguments gets its own compiled copy. 
Example: Base's `List.map` is written this way (look it up!)
---

## 12. Doing Things: IO, Effects, and the `do` Notation

Pure functions can't print or call on a network, but real programs probably have to. 
Bend's answer is the `IO` type plus `do` blocks, a design borrowed from Haskell.

We touched on `IO(Unit)` in § [3](#3-hello-world--your-first-bend-program). Let's go deeper, because this is how
*all* real-world side effects work in Bend — reading input, printing,
sleeping, using networks, working with files, and so on.

```py
# greet_io.bend:
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
```

Think of a `do IO<T>: ...` block as very similar to an `async def` function
body in Python, where every effect-full call needs an explicit `await`-like
step. Here, `<-` is that "await": `name : String <- IO.try(...)` runs the
effect and binds its result to `name`, with a mandatory type annotation.
`x : T <- effect` runs an effect and names its result. 

A few new building blocks, each with a reasonably close Python/asyncio cousin:

- **`IO.try(...)`** handles a fallible effect (like Python's `try`/`except`
  wrapping an operation that may raise), exiting the program with an error if
  it fails. Fallible effects return a `Result`. `IO.try` unwraps it 
  or exits with the error, and `IO.die` exits with your own message.

- **`IO.fork` / `IO.join`** launch a concurrent computation and later wait for
  its result — exactly like Python's `asyncio.create_task()` and `await
  task`, or `concurrent.futures`.
- **`Chan`** is a channel for communicating between concurrent computations —
  similar to `asyncio.Queue` or `queue.Queue`.

- A bare effect line like `IO.print("...")` is a step whose result is `Unit`.
- `x : T = value` binds a pure value in the middle of a block.
- `return v` wraps a pure value as the do block's result.
- Handles (`File`, `Socket`, `Window`) are affine, so each effect on one **hands the handle back** next to its result.

Under the hood, a Bend program runs as one event loop, scheduling many
computations cooperatively (just like Python's `asyncio` event loop) — the
key difference is that *pure computation itself* also runs genuinely in
parallel across your CPU cores (and GPU!), not just the IO-waiting, which is
where Python's GIL (Global Interpreter Lock) would normally hold you back.

### The `do` notation isn't just for IO!

The same `do` syntax works for *any* type that defines `bind` and `pure` —
most notably `Maybe`, Bend's answer to Python's `Optional[T]` / `None`.
It gives you something like Python's early-exit on `None`, but checked:

```py
# maybe.bend:
import Base

def add_strs(a: String, b: String) -> Maybe<&2, U32>:
  do Maybe<&2, U32>:
    x : U32 <- U32.read(a)   # a parse to U32 failure here short-circuits to None
    y : U32 <- U32.read(b)   # same as above
    return (x + y : U32)     # return is mandatory 

def main() -> Maybe<&2, U32>:
  add_strs("40", "2")    # => 42
```

`Maybe` is Bend's answer to Python's `None`: a value is either `Some{x}` or `None{}`, and the type tells you which one to expect. `&2` is a quantity marker meaning "copyable", and `Maybe<U32>` is also accepted as a short form. There's no hidden `None` waiting to blow up.

If you've used Python's walrus-heavy "early return on `None`" pattern, or
Rust's `?` operator, this should click immediately: 
each `<-` line is "unwrap this, or bail out early with `None`." 
It reads almost like straight-line code, even though a failure anywhere short-circuits the whole block, comparable to chaining `.and_then(...)` calls, but far more readable.

**Concurrency** in Bend works like Node.js: one event loop interleaves computations. 
`IO.fork` starts one and returns a channel, and `IO.join` waits for the result. 
Underneath are `IO.spawn` and `Chan.new/send/recv/close`. 
Within each computation, pure code still runs in parallel on all cores.

Base includes effects for printing, environment, time, sleep, files, TCP/UDP, windows, audio and input. You can add your own through foreign C and JS imports.

Now we'll look at how Bend handles real parallelism, but let's first clarify the terms:

**What's the difference between concurrency and parallelism?**
Concurrency is the ability of a system to handle multiple tasks by rapidly switching between them. The result is that in a given time frame several tasks can advance.
Parallelism is the *simultaneous* execution of multiple tasks, typically using multiple processors or cores. It improves efficiency by dividing a task into smaller parts and executing these in parallel.

---

## 13. Parallelism: Splitting Work Across Cores and GPUs

This is Bend's headline feature, and it is delightfully simple to use. You
write ordinary **divide-and-conquer recursion**, and Bend's runtime
automatically spreads the independent branches of the computation 
across every core it can find — even your GPU.

The following program 
```py
import Base
# parallel.bend:

def pow2(+d: Nat) -> U32:
  match d:
    case 0n:
      1
    case 1n+p:
      a b = pow2(p) pow2(p)   # <-- the parallel call
      (a + b : U32)

def main() -> IO(Unit):
  do IO<Unit>:
    IO.print(U32.show(pow2(20n)))   # run this whole call tree on all CPU cores
    IO.print(U32.show(pow2!(20n)))  # calculates 2**20 on the GPU
# => 
# 1048576    
# 1048576
```

This parallel call:  `a b = pow2(p) pow2(p)` will divide the calculation over all CPU cores.
Note that neither the lhs or the rhs of this expression is a multiplication!
Consider it Bend's party trick: to run two things in parallel, write them on one line.
It simply says: compute pow2(p) and bind it to a, compute pow2(p) and bind it to b
and do this in parallel. 

The result `(a + b : U32)` is then the sum of a and b. Because a and b are equal, 
this becomes `2 * pow2(p)`.
Starting from the initial call, this becomes:  `2**20 = 2 * 2**19 = 2 * 2 * 2**18 = ... = 2 * 2 * 2 * ... * 1`. 
(here ** reads as: to the power of). The last term is 2**0 which is 1, the base case 0n. 

Notice that `d` indicates multiple use in `pow2(+d: Nat)`. This is because `p` becomes `d` 
in the next call, and `p` is used twice in the parallel call `a b = pow2(p) pow2(p)`.

## Working on the GPU

Appending `!` to a call like in `pow2!(20n)` goes a step further and runs the whole
call tree on your **GPU**, treating thousands of GPU cores exactly like CPU
cores. 
That's it: no separate GPU-specific code is needed, no CUDA kernels to write. 
It has never been that easy to use the power of GPU's!

    The `!` postfix on the function call runs this whole call tree on the GPU.

If you don't have a compatible GPU, `!` calls simply run on the CPU instead, but still in
parallel.

Compare the parallel line:

```py
a b = pow2(p) pow2(p)
```

to Python's sequential equivalent, where you'd normally write:

```py
# Python (sequential — or a lot of multiprocessing boilerplate for parallel!)
a = pow2(p)
b = pow2(p)
```

In Python, running those two calls in actual parallel requires the 
`multiprocessing` or `concurrent.futures` modules, or a C extension, plus a lot of
ceremony around shared state and the GIL. 
In Bend, **it's a tiny syntax change** — `a b = f(x) g(y)` instead of two separate lines. 
Bend *already knows*, thanks to the affine type system, that these two calls can't
possibly interfere with each other's data. No locks, no race conditions, no
shared mutable state to worry about: the type system ruled all of that out
before you even hit "compile."

Two promises you make when you write a parallel call:

1. **The calls are independent** — guaranteed automatically by Bend's affine
   type system; you don't have to prove this yourself.
2. **They take roughly the same amount of time** —*You* have to guarantee this.
   Bend's scheduler is a fork-join machine: it assigns each task to a core exactly once 
   and never moves it, so if one branch is much heavier than the other, you'll get a lopsided
   (sub-ideal) speedup. Balanced, symmetric recursion (like splitting a
   problem exactly in half, as above) is the sweet spot. 
   
        Write **balanced divide-and-conquer** code (halving a range, splitting a tree in two).

## The call to parallel execution

The simple call `bend app.bend` targets **JavaScript**, which can only run sequentially in one thread (it will ignore the ! postfix).
To Run with threads or on the GPU, you need to build the executable (here `pow2`), like this:

```bash
bend pow2.bend -o pow2    # pow2 is the executable containing machine code
./pow2 --threads 8        # runs on the CPU using 8 threads 
./pow2 --gpu 4GB          # runs on the GPU using 4 Gb GPU-memory 
```

## 14. Modules: Organizing Code Across Files

A file is a module, and you import it in your main organizing file (usually `main.bend`) with an alias.
This works just like splitting Python code into multiple files and `import`-ing between them.

Here is the example from § [10](#10-the-big-one-affine-types-and-quantities) again.   
It is the (start of) a Math module, math.bend, containing for the moment only one function square: 
```py
# math.bend
import Base

def square(+x: U32) -> U32:
  (x * x : U32)
```

This is imported in `modules.bend` as follows:

```py
# modules.bend
import Base
import ./math.bend as M     # every def  in math.bend is now M.

def main() -> U32:
  M.square(7) # => 49
```

- `import ./math.bend as M` is directly analogous to Python's `import math as m` 
(for your own local module, not the stdlib one!)
The alias (here `M`, but it could also be `math` or anything else; 
the one-letter module import name is a convention) is local to the file that imports it. 
If `math.bend` would live in a subfolder helpers, the import statement would be:
   `import helpers/math.bend as M`    
Module paths are limited to plain names (letters, digits, `_`, `-`), so keep file names simple. 
For example: math.extra.bend` is refused.

## Importing from the Hub

Bend also has a *package hub* (think `pip`/PyPI) located at https://hub.bend-lang.com/, 
letting you import by content hash (`import 0x<hash>/main.bend as P`) or by a published name/version. 
Use `bend file.bend --publish` to upload and share your own packages.

## The standard library `Base`

Base is small and consistent. Every def is `Type.verb`, and the same verbs recur: 
`add sub mul div mod`, `cmp`, `is_eq is_ne is_lt is_le is_gt is_ge`, `show`, `read`. 
You'll also find the types `Bool`, `Maybe`, `Result`, `List`, `Array`, a string-keyed `Map` and `Set`. 
Expect to write helpers that other languages ship built in. 

Explore Base with:

```bash
bend base            # print the standard library reference
bend base --types    # just the types
bend base Map        # one name and everything under it
```

## 15. Laws and Proofs: Code That Can't Lie

Here's something Python simply doesn't have an equivalent for, and it's worth
getting excited about because it makes Bend stand out: 
**Bend lets you write mathematical proofs about your code, and the compiler checks them.**

A **law** states a fact that must always hold, in other words: it is a claim. 
A **proof** (which is an ordinary `def` with the same name as its corresponding law) demonstrates why the law is true. 
The compiler won't let your program compile if a law is left unproven or false.
Here is an example:

```py
# laws_proofs.bend
import Base

# LAW: "for every x in the set of Nat: x plus 0 equals x"
law add_zero:
  for x: Nat
  {Nat.add(x, 0n) == x : Nat}

# PROOF: case analysis — base case is trivial, step case uses induction
def add_zero(x):
  match x:
    case 0n:
      {==}       # both sides compute to the same thing
    case 1n+p:
      %add_zero(p) : {1n+Nat.add(p, 0n) == 1n+_ : Nat}  # no spaces around +
      {==}

def main() -> {Nat.add(2n, 0n) == 2n : Nat}:
  add_zero(2n)    # => {==}
```

How to read it:
- `{a == b : T}` is the *type* "a equals b". 
`{==}` proves it when both sides compute to the same term.
- A recursive call (`add_zero(p)`) is the **induction hypothesis**.
- `%e : P` **rewrites** the goal using an equation `e`.
- `?name` prints the current goal and `?TODO` leaves a hole, which is handy while you work.

Notice how the return type of main() resembles the law!.
Proofs are an advanced topic with their own learning curve, similar to learning
`hypothesis`-style property-based testing in Python, but far stronger: instead
of testing a property on a sample of inputs, you *prove* it for *all* inputs,
forever.

Why should a Python programmer care about this at all? Because the Bend team
designed it explicitly for an AI-assisted coding world: instead of writing a
fuzzy English prompt like *"sort thNat.add(0n, x) == xis list correctly"* and hoping the AI (or
your intern, or future-you) got it right, you can write an unambiguous law, like:

- *"`list_sort()` must always return ascending numbers"* 
or
- *"the sum of all balances must be zero"*
- *"players can never pass through solid walls"*

and Bend's compiler will refuse to build the project until that law is
provably satisfied. It's `assert` taken to its logical extreme: instead of
checking a property at run time on the inputs you happen to test, Bend checks
it once, for every possible input, before the code ever runs.

## The `LAWS.bend` and `PROOF.bend` files

The usual project convention is two files:
- **`LAWS.bend`**: imports your code and states the rules. 
Humans write it.
- **`PROOF.bend`**: proves each law (like `law sorted` is proven by `def Laws.sorted`). 
An AI or you writes it.

Then `bend PROOF.bend` is the gate: it fails while any law is open or false. 
Separate our example above in LAWS.bend and PROOF.bend.
`bend PROOF.bend` still outputs {==}
Nat.add(0n, x) == x
This is genuinely cutting-edge stuff — most programmers (in any language)
never write formal proofs day-to-day — so treat this section as "good to know
it exists," and come back to it once you're comfortable with the rest of
Bend. You can skip this section entirely and still write useful Bend. 
When you're ready, `demos/` in the repo has full programs with their `LAWS.bend`.

The good news: the **BendAI agent** will write the proofs for you!

---

## 16. The `bend` Command-Line Tool, Cheat Sheet

Bend is a single, Python-like command-line tool:

```bash
bend file.bend             # type-check, then run `main`
bend file.bend -o file     # compile to a native binary (needs clang 14+; 19+ for GPU `!`)
bend file.bend -o file.c   # emit the C source
bend file.bend -o file.js  # emit JavaScript
bend file.bend --verdict   # check, then re-verify with the proven Lean-based kernel
bend page.html -o dist     # bundle a web page that imports .bend files
./file --threads 8         # run the compiled binary on 8 CPU threads
./file --gpu off           # force `!` calls to run on the CPU instead of GPU
./file --gpu 4GB           # cap the GPU's heap at 4GB
bend guide                 # print the language guide
bend guide shaders         # print the "Shaders in Bend" advanced guide
bend guide effects         # print the "Effects in Bend" advanced guide
```
Nat.add(0n, x) == x
If you're used to running `python file.py` for quick scripts and
`pyinstaller`/`cython` for compiled binaries, this will feel familiar — Bend
just folds "run it" and "compile it" into one tool with different flags.

Good to know:

- A `main` returning `IO` runs compiled. A `main` returning a plain value is *normalized* by the checker and printed, which is fine for small things and slow for big work. A file with no `main` is just checked.
- For fast edit-run cycles, the JavaScript target compiles quickly. Native builds go through clang, CUDA or Metal and take longer.
- A binary using `!` also produces a `file.gpu`, which must stay next to it.
- Graphics on Linux need `libx11-dev`, and audio needs `libasound2-dev`.
Exact defaults can change between versions, so `bend --help` is the source of truth.

---

## 17. Python ↔ Bend Quick-Reference Table

| Concept                  | Python                                | Bend                                                              |
|--------------------------|---------------------------------------|-------------------------------------------------------------------|
|                          |                                       | (T means: a type)                                                 |
| Comment                  | `# comment`                           | `# comment`                                                       |
| Function                 | `def f(x): return x`                  | `def f(x: T) -> T:\n  x` (no `return`, last expr is the result)   |
| Variable binding         | `x = 5` # mutable                     | `x = {5 : U32}` # immutable, used once by default                 | 
| Integer                  | `int` (arbitrary precision)           | `U32` (32-bit) or `Nat` (arbitrary, `3n`)                         |
| Float                    | `float`                               | `F32`                                                             |
| None / Optional          | `None` / `Optional[T]`                | `Unit` / `Maybe<T>`                                               |
| List                     | `[1, 2, 3]` # dynamic array           | `[1, 2, 3]` (linked list: (`Nil{}`, `Con{h, t}`))                 |
| Mutable array            | `list` (aliasing allowed)             | `Array<T>` (single-owner, in-place mutation, no aliasing)         |
| Tuple                    | `(a, b)`                              | `(a, b)`                                                          |
| Class / dataclass / Enum | `class`/`@dataclass`/`Enum`           | `type ... is Data: Ctor{fields}`  # constructor                   |
| Pattern matching         | `match`/`case` (3.10+)                | `match`/`case` (used *everywhere*, incl. for booleans)            |
| Branching                | `if ... else ...`                     | `match` on `True{}` / `False{}`                                   |
| Loop                     | `for`/`while`                         | Recursion only, and it must *provably terminate*                  |
| Crash on infinite loop   | possible                              | No: recursion **must** terminate                                  |
| Side effects             | implicit, anywhere                    | explicit, only via `IO(...)` return types and `do` blocks         |
| `async`/`await`          | `async def` / `await`                 | `do IO<T>:` / `<-`                                                |
| Concurrency              | `asyncio`, threads, `multiprocessing` | `IO.fork` / `IO.join` / `Chan`, *and* real CPU/GPU parallel calls |
|                          |                                       | `parallel call `a b = f(x) g(y)`                                   |
| Modules                  | `import foo`                          | `import ./foo.bend as F`                                          |
| Type checking            | optional (`mypy`)                     | no type inference, mandatory, deep, and includes full proofs      |
| Testing correctness      | `assert`, unit tests, `hypothesis`    | `law` + proof, checked for *all* inputs by the compiler           |
| Package manager          | `pip` / PyPI                          | BendHub, `import <name>@<version>/...`, `--publish`               |

Python → Bend, in one breath: **type-annotate everything, use `match` instead of `if`, recurse instead of looping, use variables once (or mark them `+`), put effects in `IO`, and write `a b = f(x) g(y)` when you want parallelism.**

---

## 18. A Bend Cheat sheet

```python
import Base                                  # standard library (prelude)
import ./file.bend as M                      # a module, used as M.x

type T is Data:                              # a datatype (Data = copyable)
  A{x: U32}                                  # constructors use braces
  B{}

def f(x: U32, +y: U32) -> U32:               # + = reusable; types required
  (x + y : U32)                              # operator needs spaces around it and a ": Type" annotation  

match v:                                     # the only branch statement
  case A{x}: ...
  case B{}:  ...

match n:                                     # Nat counter
  case 0n: ...
  case 1n+p: ...                             # recurse on smaller p

a b = f(x) g(y)                              # parallel call
f!(x)                                        # run on the GPU

a = [0 : U32*8n]                             # array (8 slots)
a[5] <- 42                                   # in-place write
~f                                           # template argument (inlined)

do IO<Unit>:                                 # effects in order
  x : String <- IO.get_env("USER")           # bind x
  IO.print(x)                                # step

law name:                                    # a claim
  for x: Nat
  {Nat.add(x, 0n) == x : Nat}
def name(x): ...                             # its proof
```

## 19. Honest limitations

Part of being welcoming is being straight with you. Bend is young, and its README lists these:

- Everything is annotated, so code is **verbose**.
- No type classes, traits or macros (only templates).
- Numbers are `Nat`, `U32` and `F32` only.
- Strings are linked lists, so text processing is slow.
- Base is small. There's no HTTP, JSON or regex yet.
- Closures and arrays can't be shared (they're affine).
- No Windows (WSL works). No debugger, profiler or REPL, and error messages are terse.
- Parallelism needs balanced work.
- Expect **bugs**, and report them at [https//github.com/bendlang/bend/issues](https://github.com/bendlang/bend/issues). 

---

## 20. Practice ideas and where to go next

You now know enough Bend to read and write real programs: variables, functions, types, 
pattern matching, recursion, the affine ownership system, arrays, IO/effects, 
and even a glimpse of parallelism and proofs. 
That's a genuinely solid foundation — nicely done!

Try these starting projects in order. Each one practices a new habit:
(For inspiration, see folder *exercises*.)

1. **`double`**: write `def double(+x: U32) -> U32`. *(Practices `+`.)*
2. **`is_zero`**: take a `U32`, return a `Bool`. *(Practices `match` instead of if, and why you need a helper.)*
3. **`length`** of a `List<U32>` with an accumulator. *(Practices recursion on lists.)*
4. **`count_down`** using a `Nat` counter. *(Practices `0n` and `1n+p`.)*
5. **A `Shape` data-type** with a third constructor and its `perimeter`. *(Practices data-types.)*

- Once you're comfortable, revisit § [13](#13-parallelism-splitting-work-across-cores-and-gpus) and write your own divide-and-conquer function (a parallel sum, a parallel
  Fibonacci, a parallel sort) and feel the GPU kick in with `!`.
6. **Parallel sum**: sum the numbers 1 to 2^d by splitting the range in two halves with `a b = f(lo) f(hi)`. *(Practices balanced parallelism.)*
7. **Prove** `Nat.add(0n, x) == x`. It's trickier than `add_zero`. Why? *(Practices laws.)*

From here:
- **Read the official demos.** The Bend repository's `demos/` folder has
  complete programs — including games with accompanying proofs — showing
  these ideas in a larger context.
- **Peek at the advanced guides** when you're ready: `bend guide shaders` for
  graphics/parallel performance, and `bend guide effects` for writing your own
  custom IO effects in C/JavaScript.
- **Join the community.** The Bend Discord and subreddit are friendly, active
  places to ask questions — remember, it's a young language, so your
  questions and bug reports genuinely help shape it.

Resources:

- `bend guide`, the official language guide (`guide/GUIDE.md`)
- `bend base`, the standard library source
- `demos/` in the repo: games, servers, proofs
- Papers in `paper/`: *BendTT* (the type theory) and *BendRT* (the parallel runtime)
- Community: Discord (discord.bend-lang.com), Reddit: r/bendlang

Bend asks a little more of you up front than Python does — more annotations,
more discipline about how values are used — but what you get in return is
real: code that runs in true parallel with a one-character change, and a
compiler that can mathematically back up your confidence that the code is
correct. That's a rare and exciting combination. 

Go write something fast and have fun bending! 🚀🎉