#import "/typst/environment.typ": *
#import "index.typ": *
#import "@preview/fletcher:0.5.8": diagram, edge, node

#let index(..args, body) = body
#let eu = $upright(e)$
#let im = $upright(i)$

#show: post-template.with(
  title: "級數論",
  tags: ("Mathematics", "Analysis", "Algebra"),
  language: "lzh",
)

= 級數論
級數者，數列之累和也。累數列 ${a_n}$ 前 $n$ 項之和，名曰 $s_n = sum_(k=0)^n a_k$。則記

$
  sum_(n=0)^oo a_n := lim_(n -> oo) s_n
$
爲*無窮級數*，畧作*級數*。其中凡 $a_n > 0$ 者，謂之*正項級數*。若 $s_n$ 收斂即曰級數收斂。$s_n$ 發散即謂之級數發散。

#proposition[
  凡級數 $sum_(n=0)^oo a_n$ 之收斂者
  $
    lim_(n -> oo) a_n = 0
  $
]
#proof[
  不妨設 $sum_(n=0)^oo a_n = L$，$s_n = sum_(k=0)^n a_k$ 收斂於 $L$。然則由極限定義知，於凡正數 $epsilon > 0$ 之中，必存有一自然數 $N$，而凡自然數 $n$ 之 $n > N + 1$ 者
  $
    abs(s_(n-1) - L) < epsilon / 2
  $
  然則 $ abs(s_n - L) < epsilon / 2 $
  又因 $s_n = s_(n-1) + a_n$，故 $forall n > N$
  $
    abs(s_n - L - (s_(n-1) - L)) <= abs(s_n - L) + abs(s_(n-1) - L) < epsilon
  $
  故 $lim_(n -> oo) a_n = 0$。
]

欲料反之然否，請道以下例。

#example(title: [調和級數])[
  調和級數者，形如 $sum_(n=1)^oo 1 \/ n$ 之級數也。雖 $1\/n -> 0$ 於 $n -> oo$，然其級數發散。請證以比較審斂法：

  $
    sum_(n=1)^oo 1 / n = 1 + 1 / 2 + 1 / 3 + 1 / 4 + 1 / 5 + 1 / 6 + 1 / 7 + 1 / 8 + dots.c
  $

  分組而計：
  $
    "原式" & = 1 + 1 / 2 + (1 / 3 + 1 / 4) + (1 / 5 + 1 / 6 + 1 / 7 + 1 / 8) + dots.c \
           & > 1 + 1 / 2 + (1 / 4 + 1 / 4) + (1 / 8 + 1 / 8 + 1 / 8 + 1 / 8) + dots.c \
           & = 1 + 1 / 2 + 1 / 2 + 1 / 2 + dots.c
  $

  無界而知其發散也。此為 Nicole Oresme 於十四世紀所證也。
]

有諸據可以斷級數之斂散。請道其詳。
== 檢比術

== 檢根術

= 常數 $eu$
常數 $eu$，或曰*自然底數*，初見於複利率之計算。凡 $n > 0$ 有定義曰
$ eu := lim_(n->oo) a_n = lim_(n -> oo) (1+1 / n)^n $
此處唯需證明 RHS 收斂。請道其證法。
$
  a_n
  = sum_(k=0)^n binom(n, k)(1 / n)^k
  = sum_(k=0)^n n^(underline(k)) / (k! n^k)
$

$n^(underline(k)) / (k! n^k) >0$ ，則知 $a_n$ 之嚴格遞增矣。
考慮
$
  b_n := (1+1 / n)^(n+1 / 2)
$
$
  b_n / b_(n-1) = (1-1 / n^2)^(n-1 / 2) < 1
$
故 $b_n$ 單調遞減且 $b_n = a_n sqrt(1+1\/n) > a_n$, 故 $b_n$ 皆 $a_n$ 之上界也。故知 $a_n$ 收斂。$2 = a_1 < eu < b_1 = 2sqrt(2)$。#footnote[實則 $b_n tilde.eq a_n "as" n -> oo$]

#example(title: [別證])[

]
茲定義曰 $e_n := sum_(k=0)^n 1\/k!$，由 $(forall k >= 1) thick 1\/k! <= 1\/2^(k-1)$
$
  e_n & = 1 + 1 + 1 / 2 + 1 / (2 times 3) + dots.c + 1 / (2 times dots.c times (n-1) times n) \
      & <= 1 + 1 + 1 / 2 + 1 / (2 times 2) + dots.c + 1 / (2^(n-1)) \
      & <= 3
$
抑由 $forall k >= 2$
$
  1 / k! <= 1 / k(k-1) = 1 / (k-1) - 1 / (k) \
  e_n = 2 + sum_(k=2)^n 1 / k! <= 2 + (1 - 1 / n) <= 3 \
$
得 $3$ 者 $e_n$ 之上界也。同理可證 $e_n$ 之收斂也。
由定義知 $sup a_n = eu$ 也。以前例亦得證 $e_n$ 之收斂。然 $lim_(n->oo) e_n eq.quest eu$ 之真僞猶未能辨，不宜臆斷。

#let e_n_plot(n) = {
  range(n + 1).fold(
    0,
    (acc, k) => (
      acc + 1 / calc.fact(k)
    ),
  )
}
#let e_plot(n) = calc.pow(1 + 1 / n, n)


再證二者收斂於同處。庶幾以夾逼定理證之，唯需各項 $a_n < e_n < eu$。以上圖料其然也。然理學也非證不信非驗不服。請證之如下。

#proof[
  張 $a_n$ 如下, $forall k < n$
  $
    a_n & = sum_(m=0)^n 1 / m! n / n (n-1) / n dots.c (n-m+1) / n \
        & = 1 + 1 + 1 / 2! (1-1 / n) + dots.c + 1 / n! (1 - 1 / n) dots.c (1 - (n-1) / n) \
        & > 1 + 1 + 1 / 2! (1-1 / n) + dots.c + 1 / k! (1 - 1 / n) dots.c (1 - (k-1) / n) \
  $<eq:an-expand>
  令 $n -> oo$。然則 $k in NN$
  $
    eu > 1 + 1 + 1 / 2! + dots.c + 1 / k! = e_k
  $
  逐項比較@eq:an-expand 與 $e_n$，知 $e_n > a_n$。故
  $
    lim_(n -> oo) e_n = eu
  $]

== 指數函數

定義 $exp$ 函數曰
#definition(
  title: [$exp$ 函數],
  $
    exp x := sum_(n=0)^oo x^n / n!
  $,
)

審其斂散，法以比值
$
  lr(abs(x^(n+1) / (n+1)!) mid(slash) abs(x^n / n!)) = abs(x / (n+1)) -> 0 " 當 " n -> oo
$

故冪級數 $exp x$ 於 $RR$ 處處絕對收斂也。

= 差分方程論
請問線性微分方程如 $y'' + y = 0$ 者當作何解？得特徵方程 $r^2 + 1 = 0$ 有根 $r = plus.minus i$ 故知通解爲 $y = c_1 cos x + c_2 sin x$。代入即明此誠爲其解也。此*全解*耶? 請論其理。
定義數列 ${x_n}$ 之*前向差分算子*曰
$ Delta x_n = x_(n+1) - x_(n) $
而*逆向差分算子*曰
$ nabla x_n = x_n - x_(n-1) $
$n >= 0$ 階差分遞歸定義曰

$
  Delta^n = cases(
    I & "if" n = 0,
    Delta compose Delta^(n-1) quad & "if" n > 0,
  )
$

因 $Delta (a x_n + b y_n) = a Delta x_n + b Delta y_n$，可知 $Delta$ 爲線性#index(modifier: "線性")[算子]。又以 $I$ 之線性，知 $Delta^n$ 亦線性也。
稱形如
$ sum_(k=0)^n a_k Delta^k x_k = b $
之方程式曰 $n$ *階常係數差分方程*。特稱 $b = 0$ 者爲*齊次*，否則爲*非齊次*。若有一列數 $hat(x)_n$ 可令 $x_n = hat(x)_n$ 滿足方程，則稱 $hat(x)_n$ 爲方程之*解*。
請探其性質。凡非齊次方程之解 ${hat(x)_n}$，${hat(y)_n}$，其和 ${hat(x)_n + hat(y)_n}$ 亦解矣
$
  sum_(k=0)^n a_k Delta^k (alpha hat(x)_k + beta hat(y)_k) = alpha sum_(k=0)^n a_k Delta^k hat(x)_k + beta sum_(k=0)^n a_k Delta^k hat(y)_k = 0
$
