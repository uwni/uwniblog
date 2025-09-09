#import "/typst/environment.typ": *
#import "/typst/template.typ": *
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
#let inc = $class(
  "unary",
  nu,
)$

#let img = $op("Im")$

#axiom(title: [Peano 公理])[
  語言：$L := {0, S, =}$；變元：$x, y, z, …$。\
  (A1) $exists x (x = 0)$； $0$ 自然數也\
  (A2) $forall x, exists y, (y = S(x))$； 後繼亦自然數也\
  (A3) $forall x, S(x) != 0$； $0$ 非後繼也\
  (A4) $forall x, forall y, (S(x) = S(y) -> x = y)$； 後繼相等則原數相等\
  (A5) $phi(0) and forall x (phi(x) -> phi(S(x))) -> forall x phi(x)$。 歸納法原理
]

集合论中的 “标准自然数” 由 Dedekind–Peano 结构定义；它满足 PA 的公理。但注意不是所有满足 PA 的集合都是 Dedekind-Peano 结构。#footnote[比如，非标准模型中可能包含无限大的自然数，这些数永不可达。而 $N_1$ 直接要求含0且后继封闭的子集 = 全集]。而可以证明所有满足 Dedekind-Peano 结构的模型都是同构的。即同构意义上只有一种自然数集。

#definition(title: [Dedekind-Peano 結構])[
  三元組 $(NN, 0, inc)$ 之備下列性者曰 Dedekind-Peano 結構，$NN$ 集合也, $0 in NN$, $inc: NN -> NN_* := NN without {0}$ 映射也，曰後繼函數。\
  ($N_0$) $inc$ 單射也\
  ($N_1$) $M$ 者 $NN$ 之子集含 $0$ 也。若 $(forall n in M) inc n in M$，則 $M = NN$ 也。
]

由此可見，
- 凡 $n in NN$，$0$ 非後繼也
- $a != b -> inc a != inc b$, 即相異者後繼亦不同也。

察時針之刻，$N' := {🕛,🕐,🕑,🕒,🕓,🕔,🕕,🕖,🕗,🕘,🕙,🕚}$, $0' := 🕛$。$inc$ 進一時刻也。然則 $🕛 = inc 🕚$，是以不適 $N_0$ 而非 Dedekind-Peano 結構也。

又察下例，$N' := {suit.heart, suit.diamond, suit.club, suit.spade}$, $0' := suit.heart$。設 $inc$ 其義如下。$suit.diamond = inc suit.heart = inc suit.spade$ 違於 $N_1$ 而非 Dedekind-Peano 結構之屬也。

#themed(theme => {
  set align(center)
  set text(fill: theme.color)
  diagram(
    cell-size: 2em,
    edge-stroke: theme.color,
    $
      suit.heart edge(inc, |->) & suit.diamond edge(inc, |->) & suit.club edge(inc, |->) & suit.spade edge(#(1, 0), inc, |->, bend: #45deg)
    $,
  )
})

$nu$ 滿射也。即 $forall n in NN_*, exists m in NN, inc m = n$
#proof[
  設 $M := img nu union {0} = {n in NN_* | exists n' in NN, inc n' = n} union {0}$。若 $m in M subset.eq NN$, $inc m in img nu subset.eq M$。由 $N_1$ 知 $M = NN = NN_* union {0}$。以 $0 in.not img nu$, $img nu = NN_*$  故 $nu$ 滿射也。
]

== 加
至此，$NN$ 之構造甚簡，僅有一集，一元 $0$，一函數，公理二个而已。然人所熟稔之加法，猶未定義也。縱 $1+1$ 亦不可算也。

#definition(title: [加法])[
  定義函數 $+: NN^2 -> NN$ 如下，凡 $m in NN$：\
  (0) $0 + m := m$\
  (1) $inc(n) + m := inc(n + m)$
]

此定義稱善。蓋凡 $m in NN$，可證加法於 $n in NN$ 皆有定義。若 $n=0$，則依(0)有定義。若 $n + m$ 有定義，則以 (1) 而 $inc(n) + m$ 亦有定義。由 $N_1$ 知加法於 $NN$ 上全有定義也。

== 序
加法既立，則可定義自然數之序。
#definition(title: [序關係])[
  凡自然數 $n, m$，若有 $k in NN$ 使 $n = m + k$，則曰 $m$ 小於等於 $n$，記 $m <= n$。若 $k != 0$，則曰 $m$ 小於 $n$，記 $m < n$。
]
此序關係全序也，凡自然數皆可相較也。

#proof[
  此序關係為全序，須證四性：

  *自反性* ($n <= n$)：\
  由加法定義，$n = n + 0$。以 $0 in NN$，故 $n <= n$ 恆真。

  *反對稱性* ($m <= n$ 且 $n <= m => m = n$)：\
  若 $m <= n$，則有 $k_1 in NN$ 使 $n = m + k_1$。\
  若 $n <= m$，則有 $k_2 in NN$ 使 $m = n + k_2$。\
  代入得 $m = (m + k_1) + k_2 = m + (k_1 + k_2)$。此式意味 $k_1 + k_2 = 0$。二自然數之和為零，必二者皆零也，故 $k_1 = 0$。是以 $n = m + 0 = m$。

  *傳遞性* ($l <= m$ 且 $m <= n => l <= n$)：\
  若 $l <= m$，則有 $k_1$ 使 $m = l + k_1$。\
  若 $m <= n$，則有 $k_2$ 使 $n = m + k_2$。\
  代入得 $n = (l + k_1) + k_2 = l + (k_1 + k_2)$。令 $k_3 = k_1 + k_2$，則 $k_3 in NN$，故 $l <= n$。

  *完全性* ($m <= n$ 或 $n <= m$)：\
  此可用歸納法證之。固定 $m in NN$，歸納于 $n$。令命題 $P(n) := m <= n or n <= m$。
  - *基始*：$n=0$。\
    由加法定義，$m = 0 + m$。故 $0 <= m$ 恆為真。是以 $P(0)$ 成立。
  - *歸納*：設 $P(n)$ 為真，即 $m <= n$ 或 $n <= m$。察 $P(inc(n))$。
    - 若 $m <= n$，則有 $k$ 使 $n = m+k$。故 $inc(n) = inc(m+k) = m + inc(k)$。是以 $m <= inc(n)$。此時 $P(inc(n))$
    - 若 $n <= m$，則有 $k$ 使 $m = n+k$。
      - 若 $k=0$，則 $m=n$。故 $inc n = inc m = m + inc 0$，則 $m <= inc(n)$。此時 $P(inc n)$。
      - 若 $k != 0$，則有 $k'$ 使 $k=inc(k')$。$m = n+inc(k') = inc(n)+k'$。是以 $inc(n) <= m$。此時 $P(inc(n))$。
  綜上，凡 $tack.r P(n) -> P(inc(n))$。
  由是，據歸納公理，完全性得證。
]

== 乘法
乘法者，亦可由加法遞歸而生。
#definition(title: [乘法])[
  定義函數 $times: NN^2 -> NN$ 如下，凡 $m in NN$：\
  (1) $0 times m := 0$\
  (2) $inc(n) times m := (n times m) + m$
]
此定義亦稱善，其理同於加法，可遍施於 $NN^2$ 而無缺。

== 記數法
然加法既成，尚需記數之法以表之。吾人所習用者，十進位制也。蓋以十為基，逢十進一。所用數碼，印度-阿拉伯數字也，凡十，曰 ${0, 1, 2, 3, 4, 5, 6, 7, 8, 9}$。

#definition(title: [十進位表示法])[
  凡自然數 $n in NN$，其十進位表示乃一字符串 $s_k s_(k-1) ... s_1 s_0$，其中 $s_i$ 皆為數碼。此串之值，定義如下：
  $
    n = sum_(i=0)^k s_i times 10^i
  $
  其中 $10$ 為 $nu(9)$。此式建立自然數與數碼串之對應。
]

此映射如何構造？可以遞歸為之。
凡 $n in NN$，其記數 $f(n)$ 定義為：
- 若 $n < 10$，則 $f(n)$ 為對應之數碼。如 $f(nu(0))$ 為 "1"。
- 若 $n >= 10$，則以帶餘除法可得 $n = q times 10 + r$，其中 $0 <= r < 10$。則 $f(n)$ 為 $f(q)$ 與 $f(r)$ 之拼接。

例如，欲求 $123$ 之表示。
1. $123 = 12 times 10 + 3$
2. $12 = 1 times 10 + 2$
3. $1 = 0 times 10 + 1$

由是，$f(123)$ 為 $f(12)$ 拼接 $f(3)$，即 $f(1)$ 拼接 $f(2)$ 再拼接 $f(3)$，終得 "123"。

至此，抽象之自然數集方有吾人熟識之形態。


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

