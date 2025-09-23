#import "/typst/environment.typ": *
#import "index.typ": *
#import "@preview/fletcher:0.5.8": diagram, edge, node

#let index(..args, body) = body
#let eu = $upright(e)$
#let im = $upright(i)$

#show: post-template.with(
  title: "數列",
  tags: ("Mathematics", "Analysis", "Algebra"),
  language: "lzh",
)

// = 數列
// 數列者，

= 數列單調收斂之定理
凡單調遞增數列之有上界者與單調遞減數列之有下界者，皆收斂。請證明之。

= 極限
若夫極限者，古希臘之先賢始用之。自古及 Weierstrass#figure(image("assets/Augustin-Louis_Cauchy_1901.jpg"), caption: [Karl Weierstrass, 1815-1897]) 之議，歷久而鮮能盡其理實也。微分與無窮小之辯，相爭其存廢逾千載猶未能決。其或爲 0，或幾及 0 而非 0。時 0 而時亦非 0，George Berkeley 之屬者甚異之。物理學家屢以無窮小正定所求不爽，故不以爲謬也。數學之理也，必明必晰。然則應先辯明所謂極限者，後可以確然治分析無慮也。

#definition(title: [極限])[
  稱數列 ${a_n}$ 之極限曰

  $
             & lim_(n -> oo) a_n = L \
    <=> quad & (forall epsilon > 0) (exists N in NN^*) (forall n > N) abs(a_n - L) < epsilon
  $
]

極限者近而不逮，傍而未屆也。$a_n$ 之值將屆於 $L$ ，抑不之至。不得知也。若以 $epsilon-N$ 定義議之。恣取正數 $epsilon$，不論大小，必存一處 $N$，凡 $n$ 之後於 $N$ 者，$a_n$ 與 $L$ 相距幾微。何以知其然也? 蓋其相距小於 $epsilon$ 者也。凡正數者，皆見小於 $a_n$ 與 $L$ 之相距，此所以度量其近也。豈非因 $n$ 之漸長而 $a_n$ 幾及於 $L$ 耶？！此定義也，初立論時，不納者眾，至于今世，莫不是之！

== 單調有界性之定理

數列之收斂者，其極限必存焉。以單調有界性之定理得知其收斂而不得知其極限也。欲察極限幾何，猶須探其值而後驗以定義也。幸有各術如下以索數列之極限，一曰夾逼定理，二曰四則運算，三曰 Stolz-Cesàro 定理也。

== 夾逼定理

夾逼定理者，求極限之要術也。設有數列 ${a_n}$、${b_n}$、${c_n}$，自某項起恆有 $a_n <= b_n <= c_n$，且 $lim_(n -> oo) a_n = lim_(n -> oo) c_n = L$，則必有 $lim_(n -> oo) b_n = L$ 也。

#proposition(title: [夾逼定理])[
  設數列 ${a_n}$、${b_n}$、${c_n}$ 滿足
  $
    (exists N in NN^*)(forall n > N) a_n <= b_n <= c_n
  $
  若 $lim_(n -> oo) a_n = lim_(n -> oo) c_n = L$，則 $lim_(n -> oo) b_n = L$。
]

#proof()[
  以極限定義證之。設 $forall epsilon > 0$，因 $lim_(n -> oo) a_n = L$，故
  $
    (exists N_1 in NN^*)(forall n > N_1) abs(a_n - L) < epsilon
  $
  即 $L - epsilon < a_n < L + epsilon$。同理，因 $lim_(n -> oo) c_n = L$，故
  $
    (exists N_2 in NN^*)(forall n > N_2) abs(c_n - L) < epsilon
  $
  即 $L - epsilon < c_n < L + epsilon$。

  取 $N_0 = max{N, N_1, N_2}$，則當 $n > N_0$ 時有
  $
    L - epsilon < a_n <= b_n <= c_n < L + epsilon
  $

  故 $abs(b_n - L) < epsilon$，即 $lim_(n -> oo) b_n = L$。
]

若數列 ${b_n}$ 之極限難求，但得覓取上下夾逼之數列 ${a_n}$ 與 ${c_n}$，則可藉求 ${a_n}$ 與 ${c_n}$ 之極限而得 ${b_n}$ 之極限也。

例以議之。
#example[
  請證 $ lim_(n -> oo) (sin n) / n = 0 $

  蓋 $abs(sin n) <= 1$，故 $ -1 / n <= (sin n) / n <= 1 / n $
  而 $lim_(n -> oo) 1 \/ n = lim_(n -> oo) (-1 \/ n) = 0$，由夾逼定理知 $lim_(n -> oo) (sin n) / n = 0$ 也。
]

夾逼定理不獨用於數列，亦可推廣於函數極限。設函數 $f(x)$、$g(x)$、$h(x)$ 於點 $x_0$ 之某鄰域內（或去心鄰域內）滿足 $f(x) <= g(x) <= h(x)$，且 $lim_(x -> x_0) f(x) = lim_(x -> x_0) h(x) = L$，則 $lim_(x -> x_0) g(x) = L$ 也。

== 極限之代數運算
極限之加減乘除是也。設以 $lim_(n -> oo) a_n = L$，$lim_(n -> oo) b_n = M$，由定義知 $forall epsilon > 0$

$
           & (exists N_a in NN^*) (forall n > N_a) abs(a_n - L) < epsilon \
  and quad & (exists N_b in NN^*) (forall n > N_b) abs(b_n - M) < epsilon
$

故而 $abs(-a_n - (-L)) = abs(a_n - L) < epsilon$，是以
$
  lim_(n -> oo) (-a_n) = -L
$<eq:lim-rev>
也。設 $N := max{N_a, N_b}$，以三角不等式
$
  abs(a_n + b_n - (L + M)) <= abs(a_n - L) + abs(b_n - M) < 2 epsilon
$
故而
$
  lim_(n -> oo) (a_n + b_n) = L + M
$<eq:lim-add>
並由@eq:lim-rev 可知 $lim_(n -> oo) (a_n - b_n) = L - M$ 也。

此所以極限之代數運算效也。
$
  abs(a_n b_n - L M)
$
