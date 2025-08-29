#import "/typst/environment.typ": *
#import "@preview/lovelace:0.3.0"
#import "/typst/template.typ": post-template
#show: post-template.with(
  title: "Gradient Descent",
  tags: ("Mathematics", "optimization"),
)

梯度下降法是一种用于寻找函数局部最小值的迭代优化算法。它通过沿着函数梯度的反方向移动来逐步逼近最小值点。
對於優化問題

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