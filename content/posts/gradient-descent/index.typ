#import "/typst/environment.typ": *
#import "@preview/lovelace:0.3.0": pseudocode-list
#import "/typst/template.typ": post-template
#show: post-template.with(
  title: "Gradient Descent",
  tags: ("Mathematics", "optimization"),
)
#import "@preview/zero:0.5.0": num

#show math.gradient: math.bold

Optimization problems can be divided into minimization and maximization categories, and maximization problems can always be transformed into equivalent minimization problems. Therefore, in the following text, we will focus on minimization problems.
Gradient descent is an iterative optimization algorithm used to find the local minimum of a function. It gradually approaches the minimum point by moving in the opposite direction of the function's gradient.

= Equivalent Problems
First, let us prove some lemmas about monotonicity.
#proposition(title: [Order Preservation of Strictly Monotonic Functions])[
  If $f$ is a strictly increasing function, then
  $
    x_1 < x_2 <-> f(x_1) < f(x_2)
  $
  That is, when the output strictly increases, the input must strictly increase.
]
#proof[
  ($->$) This is the definition of strictly increasing, $x_1 < x_2 -> f(x_1) < f(x_2)$\
  ($<-$)
  By contradiction, if $x_1 >= x_2$ then $f(x_1) >= f(x_2)$, which is a contradiction.
]

#proposition(title: [Strictly Monotonic Function $->$ Injection])[
  If $f$ is a strictly monotonic function, then $f$ is injective. That is,
  $
    x_1 = x_2 <-> f(x_1) = f(x_2)
  $
]
#proof[
  ($->$) This follows from the definition of functions. \
  ($<-$) We need to prove injectivity.
  Taking $f$ strictly increasing on $X$ as an example. Let $x_1, x_2 in X, f(x_1) = f(x_2)$.
  Suppose $x_1 < x_2$, then by strict monotonicity, $x_1 < x_2 -> f(x_1) < f(x_2)$, which is a contradiction. Similarly $x_1 gt.not x_2$, therefore $x_1 = x_2$.
]



#proposition(title: [Strictly Monotonic Functions Preserve Extreme Points])[
  Let $Y subset.eq RR$, $f: X -> Y$ be an arbitrary function, and $g: Y -> RR$ be a strictly increasing function. Then $g compose f$ and $f$ have the same extreme points. Conversely, they have opposite extreme points.
]
#proof[
  // 這裏只證明前者，後者思路類似
  // $g$ 是嚴格遞增函數，即 $forall y_1, y_2 in Y$
  // $
  //   y_1 < y_2 -> g(y_1) < g(y_2)
  // $
  // 因此对于任意区间 $(forall [x_1, x_2] subset.eq X) f(x_1) < f(x_2) => g(f(x_1)) < g(f(x_2))$, 即 $g compose f$ 和 $f$ 具有相同的严格單調性。一般的，若 $g$ 是不嚴格遞增函數，上面的 $<$ 改為 $<=$ 則单调性依然保持，但不严格。

  By the lemma, we know $x_1 <= x_2 <-> g(x_1) <= g(x_2)$
  Thus for some point $x^* in X$, $exists delta > 0, forall x in U(x^*, delta)$
  $ f(x^*) <= f(x) <-> g(f(x^*)) <= g(f(x)) $
  This proves that a minimum point of $f$ is also a minimum point of $g compose f$, and a minimum point of $g compose f$ is also a minimum point of $f$.
]

Based on this, for the optimization problem
$
  arg min f(x)
$
it always has the same solution as $arg min g compose f (x)$, if $g$ is a strictly increasing function. Or $arg max g compose f (x)$, if $g$ is a strictly decreasing function.

= Unconstrained Case
$RR^n$ is the $n$-dimensional Euclidean space. $bold(x) in RR^n$, $f: RR^n -> RR$ is a differentiable function. Finding the minimum point and minimum value of $f$ is the optimization problem
$
  min_(bold(x) in RR^n) f(bold(x))
$

The iterative equation is
$
  bold(x)_(k+1) = bold(x)_k - alpha gradient f(bold(x)_k)
$
where the step size $alpha$ is a positive number that determines the update magnitude at each iteration. $gradient f(bold(x)_k)$ is the gradient of function $f$ at point $bold(x)_k$. The algorithm's goal is to make
$bold(x)_(k) -> bold(x)^*$ as $k -> oo$ where $bold(x)^* in arg min f(bold(x))$. that is to say, $bold(x)^*$ is a minimum. The pseudocode is as follows:

#pseudocode-list[
  - *Algorithm* Gradient Descent Method for minimize $f$
  - *Input*: initial point $bold(x)_0$, step length $alpha > 0$, tolerance $epsilon > 0$, max iterations $N$
  - *Output*: $bold(x)^*$
    + $k <- 0$
    + *while* $k < N$
      + $bold(g)_k <- gradient f(bold(x)_k)$
      + $bold(x)_(k+1) <- bold(x)_k - alpha bold(g)_k$
      + *if* $f(bold(x)_(k+1)) < epsilon$ *then*
        + *return* $bold(x)_(k+1)$
      + *end*
      + $k <- k + 1$
    + *end*
    + *return* $bold(x)_k$
]

Algorithm:

Let us look at an example

$
  min_((x_1, x_2) in RR^2) f(x_1, x_2)
$
where $f(x_1, x_2) = x_1^2 + x_1 x_2 + x_2^2$.
First, we know through analytical methods that for $x_1, x_2 in RR$

$
  x_1^2 + x_1 x_2 + x_2^2 = (x_1, x_2) mat(1, 1\/2; 1\/2, 1) vec(x_1, x_2) >= 0
$
Equality holds if and only if $x_1 = 0, x_2 = 0$. Therefore, the minimum value $0$ is achieved at the origin. Next, we use gradient descent to solve this.

$
  gradient f vec(x_1, x_2) = vec(2x_1 + x_2, 2x_2 + x_1)
$
$
  vec(x_1, x_2)_(k+1) = vec(x_1, x_2)_k - alpha vec(2x_1 + x_2, 2x_2 + x_1)_k
$


#let illust = image("assets/gradient_descent_visualization.svg")
#let example1 = csv("assets/gradient_descent_alpha_0.1.csv", row-type: dictionary).last()
#let example2 = csv("assets/gradient_descent_alpha_0.4.csv", row-type: dictionary).last()
#let example3 = csv("assets/gradient_descent_alpha_0.5.csv", row-type: dictionary).last()

We set the initial condition as $x_0 = (1.0, 2.0)^"T"$, step size $alpha = 0.1$, and stopping condition as $f <= 10^(-20)$. After #example1.iteration iterations, the function value reaches #num(example1.f_value, digits: 2). The trajectory left by each iteration in the feasible region is shown in the figure below. The black solid lines in the figure are the contour lines of function $f$, and the arrows indicate the gradient field. The coloring indicates the magnitude of the function value, with darker colors representing larger function values. The red points represent the positions updated at each iteration, and the connecting lines are the iteration trajectories. It can be seen that each iteration moves opposite to the gradient direction with step size proportional to the gradient magnitude, and the iteration points gradually approach the origin—the theoretical minimum point.

When we increase the step size to $0.4$, after #example2.iteration iterations, the function value reaches #num(example2.f_value, digits: 2).

When we increase the step size to $0.5$, after #example3.iteration iterations, the function value reaches #num(example3.f_value, digits: 2).

If the step size is increased to $0.6$, it leads to divergence. Therefore

#figure(illust, caption: [Gradient Descent Visualization])

It is not difficult to see that the iteration speed is related to the step size, which can lead to divergence. Therefore, we need to choose an appropriate step size to ensure convergence.

= Constrained Case

When dealing with constrained optimization problems, we need to find the minimum of a function $f(bold(x))$ subject to constraints. The general form is:

$
  min_(bold(x) in RR^n) & quad f(bold(x)) \
           "subject to" & quad g_i (bold(x)) <= 0, space i = 1, 2, ..., m \
                        & quad h_j (bold(x)) = 0, space j = 1, 2, ..., l
$

For constrained problems, we cannot simply move in the negative gradient direction as this may violate the constraints. Instead, we need to project the gradient onto the feasible region or use penalty methods.

== Projected Gradient Method

The projected gradient method modifies the standard gradient descent by projecting each iteration onto the feasible set $cal(C)$:

$
  bold(x)_(k+1) = Pi_(cal(C)) (bold(x)_k - alpha gradient f(bold(x)_k))
$

where $Pi_(cal(C))$ denotes the projection operator onto the constraint set $cal(C)$.

The pseudocode for the projected gradient method is:

#pseudocode-list[
  - *Algorithm* Projected Gradient Method for minimize $f$ subject to $bold(x) in cal(C)$
  - *Input*: initial point $bold(x)_0 in cal(C)$, step length $alpha > 0$, tolerance $epsilon > 0$, max iterations $N$
  - *Output*: $bold(x)^*$
    + $k <- 0$
    + *while* $k < N$
      + $bold(g)_k <- gradient f(bold(x)_k)$
      + $bold(y)_(k+1) <- bold(x)_k - alpha bold(g)_k$
      + $bold(x)_(k+1) <- Pi_(cal(C)) (bold(y)_(k+1))$
      + *if* $f(bold(x)_(k+1)) < epsilon$ *then*
        + *return* $bold(x)_(k+1)$
      + *end*
      + $k <- k + 1$
    + *end*
    + *return* $bold(x)_k$
]

== Example: Linear Constraint

Consider the optimization problem:

$
  min_((x_1, x_2) in RR^2) & quad f(x_1, x_2) \
              "subject to" & quad x_2 = 1
$

where $f(x_1, x_2) = x_1^2 + x_1 x_2 + x_2^2$ (same as the unconstrained case).

The feasible set is the line $cal(C) = {(x_1, x_2) : x_2 = 1}$. The unconstrained minimum $(0, 0)$ is not feasible, so we expect the constrained optimum to lie on the constraint.

The gradient is the same as in the unconstrained case.

For the linear constraint $x_2 = 1$, the projection operation onto the line is:
$
  Pi_(cal(C)) (bold(y)) = vec(y_1, 1)
$

Algorithm implementation:

$
  vec(x_1, x_2)_(k+1) = Pi_(cal(C)) (vec(x_1, x_2)_k - alpha vec(2x_1 + x_2, 2x_2 + x_1)_k)
$

#let constrained_illust = image("assets/constrained_gradient_descent_visualization.svg")
#let example_constrained = csv("assets/constrained_gradient_descent.csv", row-type: dictionary).last()

We demonstrate the algorithm starting from the same initial point as the unconstrained case:

We set the initial point as $x_0 = (1.0, 2.0)^"T"$, which lies off the constraint. The algorithm first projects this point onto the constraint $x_2 = 1$, resulting in $(1.0, 1.0)$. After #example_constrained.iteration iterations, it converges to the constrained optimal point with function value #num(example_constrained.f_value, digits: 2).

The visualization below shows the optimization trajectory and the projection process. The black line represents the constraint $x_2 = 1$.

For all iterations, the visualization shows (with later iterations becoming more transparent):
- *Red arrows*: gradient steps $-alpha gradient f(bold(x)_k)$ from current point to unconstrained update
- *Orange dotted lines*: projection steps from the unconstrained update back to the constraint

This clearly demonstrates how the projected gradient method alternates between taking gradient steps and projecting back to the feasible set. The gradient arrows show both the direction and magnitude of the descent step, while the projection steps ensure feasibility. The path successfully reaches the constrained optimal point $(-0.5, 1.0)$.

#figure(constrained_illust, caption: [Constrained Gradient Descent Visualization])

== Penalty Method

Another approach for handling constraints is the penalty method, where we convert the constrained problem into an unconstrained one by adding penalty terms:

$
  min_(bold(x) in RR^n) L(bold(x), rho) = f(bold(x)) + rho sum_(i=1)^m max(0, g_i(bold(x)))^2 + rho sum_(j=1)^l h_j(bold(x))^2
$

where $rho > 0$ is the penalty parameter. As $rho -> oo$, the solution of the penalized problem approaches the solution of the original constrained problem.


= Convergence
Next, we rigorously analyze the convergence of gradient descent.

= Convex Optimization
If the optimization problem is convex, then gradient descent can guarantee finding the global minimum. The definition of a convex function is: for any $x, y in RR^n$ and $lambda in [0, 1]$, we have
$
  f(lambda x + (1-lambda) y) <= lambda f(x) + (1-lambda) f(y)
$
