#import "/typst/environment.typ": *
#import "@preview/lovelace:0.3.0"
#import "/typst/template.typ": post-template
#show: post-template.with(
  title: "Gradient Descent",
  tags: ("Mathematics", "optimization"),
)
#import "@preview/zero:0.5.0": num
#import "@preview/oxifmt:1.0.0": strfmt
#import "@preview/lilaq:0.4.0" as lq

#show math.gradient: math.bold

優化問題可以分為最小化與最大化兩類，而最大化問題總能轉化為等價的最小化問題。因此在後文中，我們將重點討論最小化問題。
梯度下降法是一种用于寻找函数局部最小值的迭代优化算法。它通过沿着函数梯度的反方向移动来逐步逼近最小值点。

= 等價問題
首先我们来先证明一些关于单调性的引理。
#proposition(title: [Lemma])[
  $f$ 是单调递增函数，则
  $
    x_1 < x_2 <-> f(x_1) < f(x_2)
  $
  即，输出严格变大时，输入必严格变大。
]
#proof[
  ($->$) 即单调递增的定义\
  ($<-$)
  反证法排除 $x_1 >= x_2$ 两种情况可得
]

#proposition(title: [严格单调 $->$ 单射])[
  $f$ 是严格单调函数，则 $f$ 是单射。即有
  $
    x_1 = x_2 <-> f(x_1) = f(x_2)
  $
]
#proof[
  ($->$) 由函数的定义显然。 \
  ($<-$) 即求證單射。
  以 $f$ 在 $X$ 上严格递增为例。设 $x_1, x_2 in X, f(x_1) = f(x_2)$。
  假设 $x_1 < x_2$, 因严格递增，$x_1 < x_2 -> f(x_1) < f(x_2)$, 矛盾。同理 $x_1 gt.not x_2$，故 $x_1 = x_2$
]



#proposition(title: [單調函數的保序性])[
  $Y subset.eq RR$, $f: X -> Y$ 是任意函数, $g: Y -> RR$ 是嚴格遞增函數，則 $g compose f$ 和 $f$ 具有相同的極值點。反之則有相反的極值點。
]
#proof[
  // 這裏只證明前者，後者思路類似
  // $g$ 是嚴格遞增函數，即 $forall y_1, y_2 in Y$
  // $
  //   y_1 < y_2 -> g(y_1) < g(y_2)
  // $
  // 因此对于任意区间 $(forall [x_1, x_2] subset.eq X) f(x_1) < f(x_2) => g(f(x_1)) < g(f(x_2))$, 即 $g compose f$ 和 $f$ 具有相同的严格單調性。一般的，若 $g$ 是不嚴格遞增函數，上面的 $<$ 改為 $<=$ 則单调性依然保持，但不严格。

  由 lemma 知 $x_1 <= x_2 <-> g(x_1) <= g(x_2)$
  於是對於某點 $x^* in X$, $exists delta > 0, forall x in U(x^*, delta)$
  $ f(x^*) <= f(x) <-> g(f(x^*)) <= g(f(x)) $
  即證得 $f$ 的极小值点也是 $g compose f$ 的极小值点,  $g compose f$ 的极小值点也是 $f$ 的极小值点，
]

基於此，对于优化问题
$
  arg min f(x)
$
總有相同的解和 $arg min g compose f (x)$，如果 $g$ 是嚴格递增函数。或者 $arg max g compose f (x)$，如果 $g$ 是严格遞減函数。

= 无约束情况
$RR^n$ 是 $n$ 维 Euclidean 空间。$bold(x) in RR^n$, $f: RR^n -> RR$ 是一个可微函数。求 $f$ 的最小值点和最小值是约束问题
$
  min_(bold(x) in RR^n) f(bold(x))
$

迭代方程
$
  bold(x)_(k+1) = bold(x)_k - alpha gradient f(bold(x)_k)
$
其中，步长 $alpha$ 是一个正数，决定了每次迭代的更新幅度。$gradient f(bold(x)_k)$ 是函数 $f$ 在点 $bold(x)_k$ 处的梯度。算法的目标是使
$bold(x)_(k) -> bold(x)^*$ as $k -> oo$ where $bold(x)^* in arg min f(bold(x))$. that is to say, $bold(x)^*$ is a minimum.

让我们看一个例子

$
  min_((x_1, x_2) in RR^2) f(x_1, x_2)
$
where $= x_1^2 + x_1 x_2 + x_2^2$,
首先我们通过解析法知道，对于 $x_1, x_2 in RR$

$
  x_1^2 + x_1 x_2 + x_2^2 = (x_1, x_2) mat(1, 1\/2; 1\/2, 1) vec(x_1, x_2) <= 0
$
当且仅当 $x_1 = 0, x_2 = 0$ 时相等。故在原点处取得最小值 $0$。接下来我们使用梯度下降法来求解。

$
  gradient f vec(x_1, x_2) = vec(2x_1 + x_2, 2x_2 + x_1)
$
$
  vec(x_1, x_2)_(k+1) = vec(x_1, x_2)_k - alpha vec(2x_1 + x_2, 2x_2 + x_1)_k
$

#let fn(x1, x2) = x1 * x1 + x1 * x2 + x2 * x2
#let grad-fn(x1, x2, a) = (x1 - a * (2 * x1 + x2), x2 - a * (2 * x2 + x1))
#let tol = 1e-20
#let max-iter = 1000
#let a = 0.1
#let i = 0
#let x1 = 1.0
#let x2 = 2.0

#for _ in range(max-iter) {
  i += 1
  (x1, x2) = grad-fn(x1, x2, a)
  if fn(x1, x2) < tol { break }
}
#let display-num(it) = $num(strfmt("{:.2e}", it))$

假设初始点为 $bold(x)_0 = vec(1.0, 2.0)$, 设步长为 $alpha = #a$, 则 $#i$ 步后 $f$ 迭代至 $#display-num(fn(x1, x2))$.

$
  bold(x)_#(i) approx vec(#display-num(x1), #display-num(x2))\
  f(bold(x)_#i) approx #display-num(fn(x1, x2))
$

#let a = 0.4
#let i = 0
#let x1 = 1.0
#let x2 = 2.0
#for _ in range(max-iter) {
  i += 1
  (x1, x2) = grad-fn(x1, x2, a)
  if fn(x1, x2) < tol { break }
}

$alpha = #a$ 时

$
  bold(x)_#(i) approx vec(#display-num(x1), #display-num(x2))\
  f(bold(x)_#i) approx #display-num(x1 * x1 + x2 * x2)
$

#let a = 0.5
#let i = 0
#let x1 = 1.0
#let x2 = 2.0
#for _ in range(max-iter) {
  i += 1
  (x1, x2) = grad-fn(x1, x2, a)
  if fn(x1, x2) < tol { break }
}

$alpha = #a$ 时

$
  bold(x)_#(i) approx vec(#display-num(x1), #display-num(x2))\
  f(bold(x)_#i) approx #display-num(fn(x1, x2))
$

不难发现，迭代速度和步长相关，而如果你尝试将步长增大到 $0.8$，则导致发散。因此我们需要选择合适的步长来保证收敛。

= 收敛性
接下來，我們嚴謹的分析梯度下降法的收敛性。

= 凸優化
如果優化問題是凸的，那麼梯度下降法可以保證找到全局最小值。凸函數的定義是：對於任意的 $x, y in RR^n$ 和 $lambda in [0, 1]$，都有
$
  f(lambda x + (1-lambda) y) <= lambda f(x) + (1-lambda) f(y)
$
