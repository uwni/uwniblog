#import "/typst/environment.typ": *
#import "/typst/template.typ": post-template

#show: post-template.with(
  title: "Linear Algebra",
)

We have learned about linear algebra in a concrete way, such as solving linear equations, matrix operations, etc. In this chapter, we will learn about the abstract concept of linear spaces, which is a generalization of vectors and matrices. First of all, you may ask, why do we need to learn such abstract concepts? check the following example.
We have learned about vectors at least in high school, like displacement, velocity, force, etc.
actually, when we say vectors, our first impression is that they must have two or three components, which represent a point in a plane or in space. but after we learned about the linear algebra, we learned that something like $(1, 2, 3, 4, 5)$ is also a vector, even though we cannot imagine what its _physical picture_ in the real world.

So, basically, the change of the concept of vector to a arbitrary number of components is a generalization or a abstraction to the original concept. so that we can handle more with the new denition. but at the cost of lossing some physical meaning. In this lecture, we will repeat this process, to further abstract the concept of vector, so that we can figure out some shared, common, or general properties of these.


let us recall the process of the abstraction from $RR^3$ to $RR^n$, here, I will give a more rigour definition, as the first step to get you familiar with the algebric structure.

Recall that if given a structure like $(a,b,c,d)$, is this a vector? No, definitily not. actually, it it just a tuple, which is a orderd finite sequence or list of elemenets. btw you can construct it with ordered pairs, anyway. Althogh we usually by default treat it as a vector, that because we can define a addition and scalar multiplication on it, in a very natural way. but with the structure of a tuple only, we cannot do any operation on it, unless you define some in advance. for example, if you try to run
`(1, 2, 3) + (1, 2, 3)` in Python, it will return `(1, 2, 3, 1, 2, 3)`, and if you try to write $(1,2,3) + (4,5,6)$ on your paper, the reader will think it is $(1+4, 2+5, 3+6)$ by default. that because for the programming languages, the `+` operator is overloaded to concatenate two tuples. but for the math, especially in the Euclid space, the `+` operator is defined to add their elements one by one. so you will understand that it is important to delcare or at least to know what a symbol exactly means before using it, otherwise you will get confused. so, the tuple is not a vector, but we can define a vector structure on it, and then it becomes a vector.

== Application of Vectors
Then, let's return back to the topic of vectors. for example, we know that force can be decomposed into two orthogonal components, and we use this to analyze mechanics problems. Why can we do that? because the force is a vector. but similarly, a sine signal

$
  A cos(omega t + phi) = (A cos phi) cos(omega t) - (A sin phi)sin(omega t)
$

can be decomposed into two components $sin(omega t)$ and $cos(omega t)$, we usually use a constellation to represent this decomposition. Have you ever noticed the similarity between the two cases? therefore, our goal today is to come up with a structure to deal with all the similar cases.

From these two examples above, looking like a list is neither a sufficient condition for being a vector (because addition on lists isn't necessarily vector addition), nor is it a necessary condition (because even if something doesn't look like a list, like a function or a polynomial, it can still behave exactly like a vector)._So, Finally, waht is a vector? how should we define what a vector is?_

Here we will first introduce the concept of field, which are the basic algebraic structures that we will use to define linear spaces.

= Introduction to Field

Before we start talking about the vector itself, let's begin from a more basic concept. Our story will starts with a set, the fundamental building block of mathematics. Suppose there is a set $S$. it is too trivial(boring) just like the tuple we mentioned above. with a set only we can seldom do anything.

So, we want to define a binary operation on the set $S$, which is a function that maps two elements of the set to the set itself.
#definition(title: [Binary Operation])[
  A binary operation $A$ on a set $S$ is a function
  $ A: S times S -> S $
]
Here is some examples of binary operations:
#example(title: [Some Binary Operation Examples])[
  - $+, -, times$ defined on $RR$, (is $\/$ a binary operation?)
  - $union, inter$ defined on sets are also binary operation.  (are $subset.eq, subset$ binary operations?)
  - $and, or, xor$ defined on ${top, bot}$, (is $not$ a binary operation?)
]

the we can define #footnote[the term "field" comes from the German word "Körper", which means "body", and is different concept from the physical field like electric/magnetic field.] a *field* is a set $S$ with two binary operations, addition and multiplication, that satisfy certain properties. Note that the name "addition" and "multiplication" are just names, they do not necessarily mean the same as the addition and multiplication of real numbers. The important thing is that these operations satisfy certain properties.then the "addition" and "multiplication" satisfies' the following properties.

#definition(title: [Field])[
  A field is a set $S$ with two binary operations, $+$ and $dot.c$, such that: $a,b,c in S$
  / Associativity of addition: $(a + b) + c = a + (b + c)$
  / Commutativity of addition: $a + b = b + a$
  / Additive identity element#footnote[note that we use the $0$ here is just a notation as like the name $+$ and $times$]: $a + 0 = a$
  / Inverse element for addition: $forall a exists b (a + b = 0)$

  / Associativity of multiplication: $(a dot.c b) dot.c c = a dot.c (b dot.c c)$
  / Commutativity of multiplication: $a dot.c b = b dot.c a$
  / Multiplicative identity element: $a dot.c 1 = a$
  / Inverse element for multiplication: $a != 0 => exists b (a dot.c b = 1)$
  / Distributivity of multiplication over addition: $a dot.c (b + c) = a dot.c b + a dot.c c$
]

#proof(title: [$0 + a = a$])[
  trivial. by axiom 2.
]

Actually, we call the structure $(S, +)$ that satisfied the first 4 properties above an *abelian group*.
So, if we define the abelian group, then a more simple definition can be given as,
#definition()[
  A set with two abelian groups, $(S, +)$ for addition and $(S without {0}, dot.c)$, and the multiplication operation is distributive over addition. then we call it a field, and denoted as $(S, + dot.c)$.
]


the most common example of a field is the rational numbers, you can easily verify that the rational numbers satisfy all the properties of a field. The real numbers are also a field, and so are the complex numbers.

#example(title: [Examples of Fields])[
  - $QQ$ (rational numbers)
  - $RR$ (real numbers)
  - $CC$ (complex numbers)
]

Meanwhile, the integers are _not_ a field, because they do not have multiplicative inverses for all non-zero elements (for example $1\/2 in.not ZZ$), the natural numbers are _not_ even a group [Task: search for the definition of groups, and tell why.].




= Vector Space

Now we're ready to define what a vector space is.
#definition(title: [Vector Space])[
  A vector space $V$ _over_ $FF$, consists of a set $V$ (whose elements are called vectors) and a field $FF$ (whose elements are called scalars), together with two operations:

  / Vector addition: $+: V times V -> V$
  / Scalar multiplication #footnote[if it is not confusing, the $dot.c$ could be omitted like $a bold(v) := a dot bold(v)$]: $dot.c: FF times V -> V$

  These operations must satisfy the following axioms. For vectors $bold(u), bold(v), bold(w) in V$ and scalars $a, b in FF$:

  1. *Associativity*: $(bold(u) + bold(v)) + bold(w) = bold(u) + (bold(v) + bold(w))$
  2. *Commutativity*: $bold(u) + bold(v) = bold(v) + bold(u)$
  3. *Identity element*: There exists $bold(0) in V$ such that $bold(v) + bold(0) = bold(v)$ for all $bold(v) in V$
  4. *Inverse element*: For every $bold(v) in V$, there exists $bold(w) in V$ such that $bold(v) + bold(w) = bold(0)$

  5. *Associativity*: $a (b bold(v)) = (a b) bold(v)$
  6. *Identity*: $1 bold(v) = bold(v)$ #footnote[where $1$ is the multiplicative identity in $FF$]
  7. *Distributivity over vector addition*: $a (bold(u) + bold(v)) = a bold(u) + a bold(v)$
  8. *Distributivity over scalar addition*: $(a + b)bold(v) = a bold(v)+ b bold(v)$
]#footnote[In other words, if we reuse the denifition, the $(V, +_(V))$ is a abelian group.]
Note that these eight axioms completely characterize what we mean by a vector space. If a set $V$ with operations satisfies these axioms over some field $FF$, then we call it a vector space over $FF$.

For now, we can eventually answer the question, what is a vector? the answer is simple but abstract: A vector is an element of a vector space. And the vector space is defined by the eight axioms above.

Now let's look at some concrete examples to see how this abstract definition applies to familiar and not-so-familiar cases.

#example(title: [$RR^n$])[
  The most familiar example is $ RR^n = {(x_1, x_2, ..., x_n) | x_i in RR} $ over the field $RR$. Here:
  - Vector addition: $(x_1, ..., x_n) + (y_1, ..., y_n) = (x_1 + y_1, ..., x_n + y_n)$
  - Scalar multiplication: $a dot.c (x_1, ..., x_n) = (a x_1, ..., a x_n)$
  - Additive identity: $(0, 0, ..., 0)$
  - Additive inverse: $(-x_1, ..., -x_n)$
]
You can verify that all eight axioms are satisfied.

#example(title: [Polynomials])[
  Let $cal(P)_n (RR)$ be the set of all polynomials of degree at most $n$ with real coefficients:
  $ cal(P)_n (RR) = {a_0 + a_1 x + a_2 x^2 + dots.c + a_n x^n | a_i in RR} $

  Here:
  - Vector addition: $(a_0 + a_1 x + dots.c) + (b_0 + b_1 x + dots.c) = (a_0 + b_0) + (a_1 + b_1)x + dots.c$
  - Scalar multiplication: $c dot.c (a_0 + a_1 x + dots.c) = (c a_0) + (c a_1)x + dots.c$
  - Additive identity: $0 = 0 + 0 x + 0 x^2 + dots.c$
  - Additive inverse: $-(a_0 + a_1 x + dots.c) = (-a_0) + (-a_1)x + dots.c$
]
Notice how polynomials, which don't "look like" vectors in the geometric sense, still satisfy all the vector space axioms!


#example(title: [Functions], label: <exm:functions>)[
  Let $FF^S$ be the set of all functions mapping a nonempty set $S$ to $FF$. We define $forall f, g in FF^S$
  - Addition: $(f + g)(x) = f(x) + g(x)$
  - Scalar multiplication: $(c dot.c f)(x) = c dot.c f(x)$
  - additive identity: const function $0(x) = 0$ for all $x in S$
  - additive inverse: $(-f)(x) = -f(x)$
  then $FF^S$ is a vector space over $FF$.
]


This also forms a vector space over $FF$.
Functions can be thought of as "vectors" in a very abstract sense, where the "components" are the function values at each point in the domain. and we can restric this function vector space to a subset of functions, while still satisfying the vector space axioms. #footnote[提前为引入子空间做准备]

#example(title: [Continuous Functions])[
  Let $C(I)$ be the set of all continuous functions defined on an interval $I -> FF$. The structure is defined basically the same as in @exm:functions, but with the additional property that the functions are continuous over the interval $I$.
  $
    C(I) = {f in FF^I mid(|)(forall x_0 in I) lim_(x -> x_0) f(x) = f(x_0) }
  $

  by the continuous functions' properties, we know that the sum of two continuous functions is also continuous, and the scalar multiplication of a continuous function is also continuous. So this set also forms a vector space over $FF$.

  Furthermore, let $C^1(I)$ be the set of all continuously differentiable functions#footnote[which means both the function and its derivative are continuous] $I -> FF$. The structure is defined similarly, but with the additional property that the functions have _continuous first derivatives_. similarly, we can define $C^n (I)$ as the set of all functions with continuous derivatives up to order $n$.

  They are all vector spaces over $FF$. the proof is left to the reader as exercises.
]

This is the example we started with!
#example(title: [Solutions to Linear Differential Equations], label: <exm:solutions_linear_differential_equations>)[
  The set of all solutions to the differential equation
  $
    {y in FF^I mid(|) y^((n)) + a_(n-1) y^((n-1)) + dots.c + a_1 y' + a_0 y = 0 }
  $
  is a vector space over $FF$. where $a_i in FF$ are known coefficients. The addition and scalar multiplication are defined the same as in @exm:functions.
]

Some useful properties of this vector space can be derived from the definition(axioms) directly. and these properties should be proved before we use them. they are obviously true, but quite tricky to prove.

#proposition(title: [Unique Additive Identity])[
  A vector space has a _unique_ additive identity.
]
#proof[
  Suppose there are two additive identities $bold(0)_1$ and $bold(0)_2$ in a vector space $V$. Then:
  $bold(0)_1 + bold(0)_2 = bold(0)_1$ (by the definition of additive identity)
  But also, $bold(0)_2 + bold(0)_1 = bold(0)_2$ (by the same definition)
  Therefore, $bold(0)_1 = bold(0)_2$ (by the commutativity of addition).
]

#proposition(title: [Unique Additive Inverse])[
  Every element in a vector space has a unique additive inverse.
]
#proof[
  Suppose $V$ is a vector space. Let $bold(v) ∈ V$. Suppose $bold(w)$ and $bold(w')$ are additive inverses of $bold(v)$. Then
  $
    bold(w) = bold(w) + bold(0) = bold(w) + (bold(v) + bold(w')) = (bold(w) + bold(v)) + bold(w') = bold(0) + bold(w') = bold(w')
  $]

By the uniqueness of the additive identity, the notation $-bold(v)$ is well-defined as the unique additive inverse of $bold(v)$. and we can define the substraction operation as $bold(v) - bold(w) = bold(v) + (-bold(w))$.

#proposition[
  $0 bold(v) = bold(0)$ for every $bold(v) in V$
]
#proof[
  Let $bold(v) in V$. By the definition of scalar multiplication, we have:
  $0 bold(v) = (0 + 0) bold(v) = 0 bold(v) + 0 bold(v)$
  Suppose $-0 bold(v)$ is the additive inverse of $0 bold(v)$, so that $0 bold(v) + (- 0 bold(v)) = bold(0)$.
  Then we have:
  $
    bold(0) = 0 bold(v) + (- 0 bold(v)) = 0 bold(v) + 0 bold(v) + (-0 bold(v)) = 0 bold(v)
  $]

#proposition[
  $a bold(0) = bold(0)$ for every $a ∈ FF$.
]
#proof[
  Let $a ∈ FF$ and $bold(0) ∈ V$ be the additive identity. Then:
  $a bold(0) = a (bold(0) + bold(0)) = a bold(0) + a bold(0)$
  By the definition of additive identity, we have:
  $a bold(0) + (-a bold(0)) = bold(0)$
  Therefore, $ bold(0) = a bold(0) + (-a bold(0)) = a bold(0) + a bold(0) + (-a bold(0)) = a bold(0) $]

#proposition(label: <prop:multiplicative_inverse>)[
  $(-1)bold(v) = -bold(v)$ for every $bold(v) ∈ V$.
]
#proof[
  $ bold(v) + (-1)bold(v) = 1bold(v) + (-1)bold(v) = (1 + (-1))bold(v) = 0bold(v) = bold(0) $
  This equation says that $(-1)bold(v)$, when added to $bold(v)$, gives $bold(0)$. Thus $(-1)bold(v)$ is the additive inverse of $bold(v)$, as desired.
]

= Subspaces

Now that we understand vector spaces, let's talk about subspaces. A subspace is essentially a "vector space within a vector space."

#definition(title: [Subspace])[
  A subset $U subset.eq V$ is called a *subspace* of $V$ if $U$ is also a vector space with the same scalar field, additive identity, addition, and scalar multiplication as on $V$.
]

#proposition[
  A subset $U subset.eq V$ over the same $FF$ is a *subspace* of $V$ if and only if:
  1. $bold(0) in U$
  2. $U$ is closed under vector addition: $forall bold(u), bold(v) in U, bold(u) + bold(v) in U$
  3. $U$ is closed under scalar multiplication: $forall bold(v) in U, forall a in FF, a bold(v) in U$
]

#proof[
  If $U$ is a subspace of $V$, then $U$ satisfies the three conditions above by the definition of vector space. Conversely, suppose $U$ satisfies the three conditions above. The first condition ensures that the additive identity of $V$ is in $U$. The second condition ensures that addition makes sense on $U$. The third condition ensures that scalar multiplication makes sense on $U$. If $bold(u) ∈ U$, then $-bold(u)$ (which equals $(-1)bold(u)$ by @prop:multiplicative_inverse) is also in $U$ by the third condition above. Hence every element of $U$ has an additive inverse in $U$. The other parts of the definition of a vector space, such as associativity and commutativity, are automatically satisfied for $U$ because they hold on the larger space $V$. Thus $U$ is a vector space and hence is a subspace of $V$.
]

Note that if these three conditions are satisfied, then $W$ automatically inherits all the vector space axioms from $V$, so $(W, F)$ is itself a vector space. meanwhile, if $W$ is a subset of $V$ but does not satisfy these conditions, it won't be a subspace.

#example(title: [Lines through the origin])[
  In $RR^2$, any line passing through the origin forms a subspace. For instance:
  $ U = {(x, y) in RR^2 | y = 2x} = {(t, 2t) | t in RR} $

  You can verify:
  - $(0, 0) in U$
  - If $(t_1, 2t_1), (t_2, 2t_2) in U$, then $(t_1, 2t_1) + (t_2, 2t_2) = (t_1 + t_2, 2(t_1 + t_2)) in U$
  - If $(t, 2t) in U$ and $a in RR$, then $a dot.c (t, 2t) = (a t, 2a t) in U$
]

Similarly, any plane or line through the origin in $RR^3$ is a subspace. but note that those that do not pass through the origin are not subspaces.

#example(title: [Even/Odd functions])[
  In the vector space of $FF^S$, the set of even/odd functions forms a subspace.
  - It contains the $0(x) = 0$ function.
  - If $f(x)$ and $g(x)$ are even/odd, then $(f + g)(x) = f(x) + g(x)$ is also even/odd.
  - If $f(x)$ is even/odd and $c in RR$, then $(c f)(x) = c f(x)$ is also even/odd.
]



#example(title: [Continuous Functions])[
  The set $C(I)$ of all continuous functions on an interval $I$ forms a subspace of the vector space of all functions $FF^I$.
  - constant value function $0(x) = 0$ is in $C(I)$
  - If $f, g in C(I)$, then $(f + g)(x) = f(x) + g(x)$ is also continuous, so $f + g in C(I)$
  - If $f in C(I)$ and $c in RR$, then $(c f)(x) = c f(x)$ is also continuous, so $c f in C(I)$
]

#example(title: [Solutions to Homogeneous Linear Differential Equations])[
  The set of all solutions to a linear homogeneous differential equation in @exm:solutions_linear_differential_equations forms a subspace of the vector space of functions.
  - The zero function is a solution (the trivial solution).
  - If $y_1$ and $y_2$ are solutions, then $(y_1 + y_2)(x) = y_1(x) + y_2(x)$ is also a solution.
  - If $y$ is a solution and $c in RR$, then $(c y)(x) = c y(x)$ is also a solution.
]

= Sum of Subspaces
Now let's talk about the sum of two subspaces. Given two subspaces $U$ and $W$ of a vector space $V$, their sum, denoted $U + W$, is defined as:
#definition(title: [Sum of Subspaces])[
  The sum of two subspaces $U$ and $W$ of a vector space $V$ is the set:
  $ U + W = {bold(u) + bold(w) mid(|) bold(u) in U, bold(w) in W} $
]
but note that $U union W$ is not the same as $U + W$. The sum $U + W$ is a vector space itself, and it contains all possible sums of vectors from $U$ and $W$ whereas $U union W$ just combines the elements of both subspaces so it will not must be a vector space.

#example[
  Suppose $U$ is the subspace of all vectors of the form $(x, 0)$ in $RR^2$, and $W$ is the subspace of all vectors of the form $(0, y)$. Then:
  $ U + W = {(x, y) mid(|) x in RR, y in RR} = RR^2 $
  forms the $RR^2$ plane while $U union W = {(x, 0) mid(|) x in RR} union {(0, y) mid(|) y in RR}$ is just the union of $x$-axis and $y$-axis, which is not a vector space.
]

#proposition(title: [Sum of Subspaces is the smallest containing subspace])[
  The sum $V_1 + dots.c + V_m$ of subspaces $V_1, ..., V_m$ of $V$ is the smallest subspace of $V$ containing each of $V_1, ..., V_m$.
]
#proof[
  The reader can verify that $V_1 + dots.c + V_m$ contains the additive identity $bold(0)$ and is closed under addition and scalar multiplication. Thus it is a subspace of $V$.

  The subspaces $V_1, ..., V_m$ are all contained in $V_1 + dots.c + V_m$ (to see this, consider sums $bold(v)_1 + dots.c + bold(v)_m$ where all except one of the $bold(v)_k$'s are $bold(0)$). Conversely, every subspace of $V$ containing $V_1, ..., V_m$ contains $V_1 + dots.c + V_m$ (because subspaces must contain all finite sums of their elements). Thus $V_1 + dots.c + V_m$ is the smallest subspace of $V$ containing $V_1, ..., V_m$.
]

