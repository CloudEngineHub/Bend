# This program is an example that shows how scopeless lambdas can be used.

Seq (a: A) (b: B) : A = a

# Create a program capable of using `callcc`
unchecked CC.lang : ((((a -> b) -> b) -> c) -> c) -> d =
λprogram
  let callcc  = λcallback (λ$garbage($hole) (callback λ$hole(0)));
  let result  = (program callcc);
  let garbage = $garbage; # Discard `$garbage`, which is the value returned by `callback`
  (Seq result garbage)

main: u24 = (CC.lang λcallcc 
  # This code calls `callcc`, then calls `k` to fill the hole with `42`.
  # This means that the call to callcc returns `42`, and the program returns `52`
  (+ 10 (callcc λk(+ (k 42) 1729)))
)
  