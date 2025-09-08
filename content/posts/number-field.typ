#import "/typst/environment.typ": *
#import "/typst/template.typ": post-template, themed
#import "@preview/fletcher:0.5.8": diagram, edge, node

#let index(..args, body) = body
#let eu = $upright(e)$
#let im = $upright(i)$

#show: post-template.with(
  title: "分析學其一：數集",
  tags: ("Mathematics", "Analysis", "Algebra"),
  language: "lzh",
)

本章議數集之建構及諸性質。數集者，蓋數之集合也。數集之有，始於自然數。自然數之有，始於人數物之需。人數物以計其數，故有自然數也。自然數者，其性自然。人之所創者，記號而已矣。現代之數學需以形式論理之，故欲明自然數之義，必以公理定之。

數學之發展，非獨賴自然數也。蓋自然數之有，猶樹之有根本也。樹之有枝葉，賴根本而生也。數學之有他數集，賴自然數而立也。故分析學之始，必自自然數論也。

= 論自然數
#let inc = $op(nu)$
#definition(title: [Dedekind-Peano 結構])[
  三元組 $NN = (N, 0, inc)$ 之備下列性者曰 Dedekind-Peano 結構，$N$ 集合也, $0 in N$, $inc: N -> N_* := N without {0}$ 映射也，曰後繼函數。\
  ($N_0$) $inc$ 單射也\
  ($N_1$) $M$ 者 $N$ 之子集含 $0$ 也。若 $(forall n in M) inc n in M$，則 $M = N$ 也。
]

由此可見，
- 凡 $n in N$，$0$ 非後繼也
- $a != b -> inc a != inc b$, 即相異者後繼亦不同也。

察時針之刻，$N' := {🕛,🕐,🕑,🕒,🕓,🕔,🕕,🕖,🕗,🕘,🕙,🕚}$, $0' := 🕛$。$inc$ 進一時刻也。然則 $🕛 = inc 🕚$，是以不適 $N_0$ 而非 Dedekind-Peano 結構也。

又察下例，$N' := {♥️, ♦️, ♣️, ♠️}$, $0' := ♥️$。設 $inc$ 其義如下。$♦️ = inc ♥️ = inc ♠️$ 違於 $N_1$ 而非 Dedekind-Peano 結構之屬也。

#align(center)[
  #themed(theme => {
    set text(fill: theme.color)
    diagram(
      cell-size: 2em,
      edge-stroke: theme.color,
      $
        ♥️ edge(inc, |->) & ♦️ edge(inc, |->) & ♣️ edge(inc, |->) & ♠️ edge(#(1, 0), inc, |->, bend: #45deg)
      $,
    )
  })]


= 論整數


#let mr = $stretch(-, size: #1em)$
#let dr = $slash slash$

相等關係
$
  a mr b = c mr d <=> a + d = b + c
$

凡自然數 $n$，察對射於 $NN -> {n mr 0 | n in NN}$ 上者 $n |-> n mr 0$。知整數之形如 $n mr 0$ 者同構於 $NN$ 也。故可以整數 $n$ 記自然數 $n mr 0$ 而無虞也。
逆元
$
  -a := 0 mr a
$

= 分數論

相等關係
$
  a dr b = c dr d <=> a d = b c
$
必有
$
  (exists x dr y in [a dr b]) gcd(x, y) = 1
$
*約式*，或曰*最簡分式*，分式之子母互素者也。例如 $1\/1$，$2\/3$，$5\/8$。以其子母皆最小，立爲 $QQ\/=$ 之代表元也。稠性: $a$

= 實數論
請問，正方形之對角線長 $l$ 幾何? 以勾股定理知 $l^2 = 2$，擬其長以一分數之約式 $l = p\/q$

$
  l^2 = 2 <=> p^2 = 2 q^2
  <=> 2 divides p^2 <=> 2 divides p\
  <=> exists p'(p = 2 p') <=>
  2p'^2 = q^2 <=> 2 divides q^2 <=> 2 divides q
$

$p$ 與 $q$ 皆偶數，而 $p \/ q$ 非約式也。故知 $l$ 非分數之屬也。以Ἵππασος之初覺爲嚆矢，分數之遺缺始昭於天下矣。此所以分數不可以度量也。

另察一例，有集分數其平方皆小於 $2$ 者
#let QQ2 = $QQ_(<sqrt(2))$
$
  QQ2 := {x in QQ | x^2 < 2}
$
即知有上界也。而無上確界。擬以歸謬法證之：
設其上確界爲 $dash(x)$，則 $forall x in QQ2, dash(x) >= x$，
$
  forall epsilon > 0, exists y in QQ2, dash(x) - epsilon < y
$

由全序關係之三歧性知
+ 若 $dash(x)^2 = 2$: 證偽
+ 若 $dash(x)^2 > 2$，需證明 $exists y in QQ2, y < dash(x)$，設 $y = dash(x) - epsilon$，並使 $y^2 > 2$。即 $y$ 爲上界而甚小耳。 $ (dash(x) - epsilon)^2 >= 2 <=> dash(x)^2 - 2 dash(x) epsilon + epsilon^2 > 2 arrow.l.double dash(x)^2 - 2 dash(x) epsilon >= 2 <=> epsilon <= (dash(x)^2 - 2) / (2 dash(x)) $
  不妨取 $epsilon = (dash(x)^2 - 2) / (2 dash(x))$，即爲證
+ 若 $dash(x)^2 < 2$，需證明 $exists y in QQ2, y > dash(x)$，設 $y = dash(x) + epsilon$。即 $dash(x)$ 乃非上界耳。 $ y^2 = (dash(x) + epsilon)^2 <= 2 <=> dash(x)^2 + 2 dash(x) epsilon + epsilon^2 < 2 arrow.l.double dash(x)^2 + 2 dash(x) epsilon <= 2 <=> epsilon <= (2 - dash(x)^2) / (2 dash(x)) $
  不妨取 $epsilon = (2 - dash(x)^2) / (2 dash(x))$，即爲證

故知 $QQ2$ #index[上確界]之不存也。

二例。#let QQ4 = $QQ_(<2)$
$
  QQ4 := {x in QQ | x^2 < 4}
$
可知 $x >= 2$ 皆上界也，而$sup QQ4 = 2$也

凡 $Q$ 爲 $QQ$ 上非空有上界子集，則定義為實數。
全序集 $(X, prec.eq)$。若其非空子集之有上界者有上確界。曰*序完備*
