#import "/typst/environment.typ": *
#import "@preview/lovelace:0.3.0"
#import "/typst/template.typ": post-template
#show: post-template.with(
  title: "Gradient Descent",
  tags: ("Mathematics", "optimization"),
)

優化問題可以分為最小化與最大化兩類，而最大化問題總能轉化為等價的最小化問題。因此在後文中，我們將重點討論最小化問題。
梯度下降法是一种用于寻找函数局部最小值的迭代优化算法。它通过沿着函数梯度的反方向移动来逐步逼近最小值点。

= 等價問題
对于函数 $f$，优化问题
$
  min f(x)
$
可以转化成等价的问题，由以下定理

#proposition(title: [單調函數的保序性])[
 $g: op("dom")(f) -> RR$ 是嚴格單調遞增函數，則 $g compose f$ 和 $f$ 具有相同的單調性和極值點。反之則有相反的單調性和極值點。
]
#proof[
  這裏只證明前者，後者思路類似。
  $g$ 是嚴格單調函數，即 $forall x, y in I$
  $
    x < y => g(x) < g(y)
  $
  因此对于任意区间 $[x,y] subset I$， $f(x) < f(y) => g(f(x)) < g(f(y))$, 即 $g compose f$ 和 $f$ 具有相同的單調性。对于 $f$ 的極小值點 $x^*$，存在 $x^*$ 的鄰域，有 $f(x) >= f(x^*)$，因此 $g(f(x)) >= g(f(x^*))$，即 $g compose f$ 在 $x^*$ 处也取得极小值。极大值点亦然。
]

= 无约束情况
$RR^n$ 是 $n$ 维 Euclidean 空间。$x in RR^n$, $f: RR^n -> RR$ 是一个可微函数。求 $f$ 的最小值点和最小值是约束问题
$
  min_(x in RR^n) f(x)
$

迭代方程
$
  x_(k+1) = x_k - alpha gradient f(x_k)
$
其中，步长 $alpha$ 是一个正数，决定了每次迭代的更新幅度。$gradient f(x_k)$ 是函数 $f$ 在点 $x_k$ 处的梯度。

= 收敛性


= 凸優化
如果優化問題是凸的，那麼梯度下降法可以保證找到全局最小值。凸函數的定義是：對於任意的 $x, y in RR^n$ 和 $lambda in [0, 1]$，都有
$
  f(lambda x + (1-lambda) y) <= lambda f(x) + (1-lambda) f(y)
$