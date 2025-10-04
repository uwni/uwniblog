#import "/typst/environment.typ": *
#import "/typst/template.typ": *
#import "@preview/fletcher:0.5.8": diagram, edge, node

#let index(..args, body) = body
#let eu = $upright(e)$
#let dom = math.op("dom")

#show: post-template.with(
  title: "論集合",
  tags: ("Mathematics", "Analysis", "Algebra"),
  language: "lzh",
)


= ZFC 公理


== 集合代數
設 $A$, $B$ 皆集也。納 A 及 B 之所有以為一集，曰 $A$ 與 $B$ 之*并集*，記 $A union B$。

$
  A union B = {x | x in A or x in B}
$

擇 A 及 B 之共有以為一集，曰 $A$ 與 $B$ 之*交集*，記 $A inter B$。

$
  A inter B = {x | x in A and x in B}
$

$A$ 之所有之不見於 $B$ 者，曰 $A$ 與 $B$ 之*差集*，記 $A without B$。

$
  A without B = {x | x in A and x in.not B}
$

== 子集與空集
設 $A$ 集也。若分 $A$ 為一新集 $B$，曰 $A$ 之*子集*，記 $B subset.eq A$。然則凡 $b in B$ 者悉見於 $A$ 也。

$
  B subset.eq A <=> (forall b in B) b in A
$

若 $B subset.eq A$ 且 $B = A$，則曰 $B$ 為 $A$ 之*真子集*，記 $B subset A$。
$A$ 子集之集
集合無一物者曰*空集*，記 $emptyset$。空集爲任何集之子集也。

#proof[
  設 $A$ 集也。欲證 $emptyset subset.eq A$，即證
  $forall x (x in emptyset -> x in A)$。蓋 $emptyset$ 無元也，故前項為假而命題空真矣。
]

=== 集族
集合之集曰*集族*，$cal(F)$ 集族也。*一般並*者
$
  union.big cal(F) := union.big_(F in cal(F)) F := { x | (exists F in cal(F)) x in F }
$
若非空#footnote[不存在所有元素之集合故]，*一般交*者
$
  inter.big cal(F) := inter.big_(F in cal(F)) F := { x | (forall F in cal(F)) x in F }
$
且较然易見
$
  display(union.big {A, B} = A union B)\
  display(inter.big {A, B} = A inter B)
$


=== 幂集
#let ps = $cal(P)$
凡 $S$ 之子悉聚以為集族，曰*冪集*，記 $ps(S) := {x | x subset.eq S }$。例如 $ps {1, 2} = {{}, {1}, {2}, {1, 2}}$。

=== 不交並與劃分
設 $cal(F)$ 集族也。若 $forall A, B in cal(F), A != B -> A inter B = emptyset$ 則記 $union.big cal(F)$ 為 $union.sq.big cal(F)$。曰*不交並*。

設 $cal(F) subset.eq ps (X)$，$X$ 之族也。若
$
  union.sq.big cal(F) = X
$
則曰 $cal(F)$ 為 $X$ 之*劃分*。

== 元組與 Cartesian 積

TODO: 有序對（2元組），n元組，笛卡兒積

$
  A times B = {(a, b) | a in A and b in B}
$

$
  A^n := underbrace(A times A times dots.c times A, n "個")
$

== 關係
若集合 $R subset.eq A times B$者，謂之 *$A$ 與 $B$ 上之二元#index(modifier: "二元")[關係]*，畧以#index[關係]。若 $A = B$ 即 $R subset.eq A^2$ 則曰 $A$ 上之關係。$(a,b) in R$ 則曰 *$(a, b)$ 適 $R$*。以中綴表達式記曰 $a R b$，亦可記以前綴式並輔以括弧讀號，曰$R(a,b)$。

夫 $R$ 之*定義域*者，$dom R := {a in A | (exists b in B) a R b}$。夫*像域*者，$im R := {b in B |(exists a in A) a R b}$。

== 等價關係
#let normaleq = $class("normal", ~)$

#definition(title: [等價關係])[
  設 $normaleq$ 爲集 $S$ 上之二元關係。適三性如下列者謂 $S$ 上之*等價關係*。：
  / 自反性: $(forall s in S) s ~ s$
  / 對稱性: $(forall s, t in S) s ~ t -> t ~ s$
  / 傳遞性: $(forall s, t, u in S) s ~ t and t ~ u -> s ~ u$
]

#definition(title: [等價類與商集])[
  設 $normaleq$ 爲 $S$ 上之等價關係，凡 $s in S$，集合 $[s]_normaleq := {t in S | s ~ t}$ 名曰 $s$ 之*等價類*。$S$ 之等價類族曰*商集*，記 $S \/ normaleq := {[s]_normaleq | s in S}$。
]

#proposition[
  $S$ 之等價關係與其劃分一一對應也
]

== 恆等關係
記 $S$ 上之*恆等#index(modifier: "恆等")[關係]*曰 $id_S$
$
  id_S := {(s, s) | s in S}
$
例如 $S = {suit.club.stroked, suit.diamond.stroked, suit.heart.stroked}$，$id_S = {(suit.club.stroked, suit.club.stroked), (suit.diamond.stroked, suit.diamond.stroked), (suit.heart.stroked, suit.heart.stroked)}$

恆等關係者，等價關係也。

== 偏序關係
$(S, prec.eq)$ 設以為結構之並以關係者，並有
/ 自反性: $(forall s in S) s prec.eq s$
/ 反對稱性: $(forall s, t in S) s prec.eq t and t prec.eq s -> s = t$
/ 傳遞性: $(forall s, t, u in S) s prec.eq t and t prec.eq u -> s prec.eq u$
則 $prec.eq$ 名曰*偏序關係*。偏序關係之最小者，唯恆等關係也。不難證明之。
+ $id$ 適自反性，反對稱性，傳遞性，故爲偏序關係也。
+ 凡 $(forall s in S) id without {(s, s)}$ 之關係皆以有違自反性而非偏序關係也。故最小也
+ 凡偏序關係必含 $id$ 也。可以歸謬法示其唯一也。

若夫偏序之匪等者，曰*嚴格偏序*也。記 $prec$。$a prec b := a prec.eq b and a != b$

== 最大與最小
$(T, prec.eq)$ 偏序之構也。$s in T$，若夫
- $forall t in T, s prec.not t$，莫大於 $s$。$s$ 謂之*極大*。
- $forall t in T, t prec.not s$，莫小於 $s$。$s$ 謂之*極小*。
- $forall t in T, t prec.eq s$，皆小於 $s$。$s$ 謂之*最大*，記 $max T = s$。
- $forall t in T, s prec.eq t$，皆大於 $s$。$s$ 謂之*最小*，記 $min T = s$。

最大（小）者極大（小）也。

非空有窮偏序集者，偏序集之非空且有窮也。
- 極大（小）元常有。
  // show me here
- 最大（小）元不常有。例如 $T = {suit.club.stroked, suit.diamond.stroked, suit.heart.stroked}$，偏序關係 $class("normal", prec.eq) = id$。所以無最大（小）元者，不可相較而已。

非空有窮全序集常有最大（小）元。請擬以歸納證明之
  + $abs(S) = 1$，$S$ 之元唯一，即最大最小元也。
  + $abs(S) = 2$，設 $S = {t_1, t_2}$，其最元得計算如下
    $
      max S = cases(t_1 quad "if" t_2 prec.eq t_1, t_2 quad "if" t_1 prec.eq t_2), wide
      min S = cases(t_1 quad "if" t_1 prec.eq t_2, t_2 quad "if" t_2 prec.eq t_1)
    $
  + 設 $abs(S) = N$，$S$ 有最大元 $M$ 與最小元 $m$。
  + 察 $abs(S) = N+1$，令 $S' = S without {s}$。
    由前款知 $S'$ 有最大元 $M'$ 與最小元 $m'$。然則 $max S = max{M', s}$, $min S = min{m', s}$ 也。即 $S$ 有最大最小元也。

集之界，不逾之境也。凡集 $S subset.eq T$ 之元 $s$，其或 $s <= M$ 者，則名 $M$ 爲 $S$ 一*上界*。反之，若 $M <= s$ 則喚作*下界*。上下界並存，則謂之*有界*。界不必含於集也。上界之最小者，曰*上確界*，或曰最小上界，記 $sup S$。下界之最大者，曰*下確界*，或曰最大下界，記 $inf S$。

$
  sup S = min{ t in T | s in S, s <= t}
$
$
  inf S = max{ t in T | s in S, t <= s}
$

例以上界與上確界，察其性質，凡有二項，一曰 $sup S$ 乃 $S$ 之上界也，二曰凡其上界莫小於 $sup S$ 也，即最小之上界也。
請問偏序集恆有上界乎？
1。有窮集顯然恆有界，且 $sup S= max S$ 而 $inf S = min S$ 也。依序可列 $S$ 之元,

== 全序關係
若改 $prec.eq$ 之自反性爲完全性，即
$
    "完全性": & quad (forall s, t in S) s prec.eq t or t prec.eq s \
  "反對稱性": & quad (forall s, t in S) s prec.eq t and t prec.eq s -> s = t \
    "傳遞性": & quad (forall s, t, u in S) s prec.eq t and t prec.eq u -> s prec.eq u
$

則名曰*全序#index(modifier: "全序")[關係]*，或曰*鏈*。凡全序之關係，恆偏序也。請備述之。全序關係滿足反對稱性與傳遞性，並以完全性蘊含自反性即知其亦偏序也。

= 映射
$X$, $Y$ 皆設以為集也。$X times Y$ 上之二元關係 $f$ 為*映射*，若

$
  (x, y) in f and (x, y') in f -> y = y'
$

若夫定義域、像域之所謂，承自二元關係也。若定義域 $dom f = A$，像域 $im f subset.eq B$。記 $f: A -> B$，$B$ 曰*終域*。若 $(x,y) in f$，記曰 $f(x) = y$ 或 $f: x |-> y$。若 $B$ 為一數集，則 $f$ 謂之*函數*。

== 限制與擴張
$f: A -> B$ 為映射也，$S subset.eq A$，集合
$
  f[S] := {f(s) | s in S}
$
名曰 $f$ 於 $S$ 之*像集*。

#proposition[
  $f[S] subset.eq f[A] = im f$
]
#proof[
  前者較然可見。再者，即證 $f[A] subset.eq im f$ 及 $f[A] supset.eq im f$。其中 $im f = {b in B| (exists a in A) f(a) = b}$ 承義自二元關係。
  + ($subset.eq$) $forall b in f[A] = {f(a) | a in A}$ 有 $a in A$ 遂使 $b = f(a) in B$。故 $b in im f$。
  + ($supset.eq$) $forall b in im f$ 有 $a in A$ 遂使 $b = f(a)$。是以 $b in f[A]$。
]
定義函數 $f$ 於 $S$ 之*限制* $f|_(S): S -> B$，$f|_S (s) := f(s)$。於是 $im f|_S = f[S]$。

== 單滿性
$f: A -> B$ 映射也。夫*單射*者，
$
  f(a) = f(a') -> a = a'.
$
為 $f$ 之不同元有不同像也。夫*滿射*者，
$
  forall b in B, exists a in A, f(a) = b.
$
夫*對射*者，單射且滿射。

#proposition[
  $ f: A -> B "滿射" <-> im f = B $
]
#proof[
  ($->$) 設 $f$ 滿射也。欲證 $im f = B$，即證 $im f subset.eq B$ 且 $B subset.eq im f$。前者較然。及後者，蓋 $f$ 滿射，故 $forall b in B, exists a in A, f(a) = b$。是以 $b in im f = {f(a)| a in A}$。

  ($<-$) 設 $im f = B$。欲證 $f$ 滿射也，即證 $forall b in B, exists a in A, f(a) = b$。蓋 $im f = B$，則 $forall b in B, b in im f$。是以 $forall b in B, exists a in A, f(a) = b$。
]

== 逆映射

== 勢
孟子曰權，然後知輕重；度，然後知長短。物皆然。計集 $S$ 其元众寡曰*勢*，記以 $abs(S)$。
$S$, $T$ 集合也，若有對射 $f: S -> T$，則曰二集*等勢*，記曰 $S tilde.equiv T$。是以 $S$ 度 $T$ 之勢也。

自然数以為籌, 若 $exists n in NN$ 可使 $S$ 與 $NN_(<n) := {0, 1, 2, ..., n-1}$ 對射，則謂 $S$ *有窮集*，勢 $n$，記 $abs(S) = n$。
此計數之抽象也，若有 $S = {suit.club.stroked, suit.diamond.stroked, suit.heart.stroked, suit.spade.stroked}$ 集，數以一二三四而知其勢乃 $4$ 。蓋有對射:
$
  f: & S -> NN_(<4) \
     & suit.club.stroked |-> 0, suit.diamond.stroked |-> 1, suit.heart.stroked |-> 2, suit.spade.stroked |-> 3
$
使之然也。

不然，謂之*無窮集*。如分數集，實數集云云。無窮集中，$abs(NN)$ 定以為 $alef_0$。集合勢與自然數集等者，名曰*可數集*，否則曰*不可數集*。例如分數集爲可數集，實數集爲不可數集。有窮集之勢皆自然數，且 $abs(emptyset) = 0$。無窮集者，雖不可勝數，猶可較也。若有集可使其元對射於自然數者，譬如盡數自然數之勢然。

#proposition(title: [Schroder-Bernstein 定理])[
  $S$, $T$ 皆集也。
  $
    abs(S) <= abs(T) and abs(T) <= abs(S) -> abs(S) = abs(T)
  $
]
#let calS = $cal(S)$
#let calT = $cal(T)$
#proof[
  設 $f: S -> T$ 與 $g: T -> S$ 皆單射也。欲證 $abs(S) = abs(T)$，即證有對射 $h: S -> T$ 也。
  設
  $
    S_n := cases(
      S without g[T] quad & "if " n = 0,
      g compose f[S_(n-1)] quad & "if " n > 0
    )
  $
  $S_0$ 之元莫有 $g$ 之像也。而 $S_1$, $S_2$ ... 之屬，俱可緣溯至 $S_0$。故集 $S$ 之元之源自 $S$ 者設以為 $calS_S := union.big_(n in NN) S_n$。設 $calT_S := f[calS_S]$，$T$ 之元之源自 $S$ 者也。$calS_S$, $calS_T$ 不相交。蓋 $s in calS_S$ 源自 $S$ 而非 $T$ 故也。

  設
  $
    h: S -> T = cases(
      f quad & "if " s in calS_S,
      g^(-1) quad & "if " s in S without calS_S,
    )
  $
  則 $h$ 對射也。何故？
  + $f$ 單射而 $f|_(calS_S)$ 自然也。反之，$f|_(calS_S): calS_S -> calT_S$ 滿射也。以 $calT_S = f[calS_S] = im f|_(calS_S)$ 較然可知。故 $f|_(calS_S)$ 對射也。
  + 同理知 $g|_(T without calT_T)$ 單射。而又以
    $
      g[T without calT_S] = S without calS_S
    $
    得 $g|_(T without calT_T): T without calT_T -> S without calS_S$ 滿射也。所以然者，蓋
    + 凡 $s in S without calS_S$，則 $s in.not S_0$。是以 $s in g[T] -> (exists t in T) g(t) = s$。是唯需證 $t in.not calT_S$。\
      若 $t in calT_S$，則 $(exists s' in calS_S) f(s') = t$。則 $s = g(t) = g(f(s'))$ 即 $(exists n in NN_+) s in S_n subset.eq calS_S$。謬也。故 $t in.not calT_S -> t in T without calT_S -> s = g(t) in g[T without calT_S]$。

    + 反之，凡 $s in g[T without calT_S]$，則 $exists t in T without calT_S, g(t) = s$。是唯需證 $s in.not calS_S$。\
      若 $s in calS_S$，則 $(exists n in NN_+) s in S_n$。繼而 $(exists s' in calS_S) g (f (s')) = s$，因 $g$ 單射，$t = f(s') in calT_S$。謬也。故 $s in S without calS_S$。

  是以 $h$ 對射也。所證如是。
]

#proposition(title: [Cantor's 定理])[
  $S$ 集也。
  $
    abs(S) < abs(ps(S))
  $
]

#proof[
  $f: S -> ps(S)$ 以為映射。欲證 $f$ 非對射也，蓋則 $abs(S) <= abs(ps(S))$。設
  $
    T := {s in S | s in.not f(s)}
  $
  則 $T subset.eq S$ 故 $T in ps(S)$。欲證 $T$ 非 $f$ 之像也，蓋則 $f$ 非對射也。假 $exists t in S, f(t) = T$。則
  + 若 $t in T$，則 $t in.not f(t) = T$。謬也。
  + 若 $t in.not T$，則 $t in f(t) = T$。謬也。

  所證如是。
]

可數集 $S$ 之冪集 $ps (S)$ 尤勢 $2^abs(S)$ 也，請以歸納法證明之:
$abs(ps(emptyset)) = abs({emptyset}) = 1$
,若設以
$abs(ps(S)) = 2^abs(S)$,
既添新元 $x$ 於 $S$，其冪集必含原 $ps(S)$ 所有。$ps(S union {x})$ 之所添乃 $x$ 與原 $ps(S)$ 所有之併也。
$
  ps(S union {x}) = ps(S) union.sq {Y union {x} | Y in ps(S)}
$
是以

$
  2^(abs(S union {x})) = abs(ps(S union {x})) = abs(ps(S)) + abs({Y union {x} | Y in ps(S)}) = 2^abs(S) + 2^abs(S) = 2^(abs(S)+1)
$

所證如是。


// == 界

== 數列
#proposition[
  有序列 ${a_n}$ 單調遞減而 ${b_n}$ 單調遞增者，且 $a_n >= b_n$。
  $ forall i, j in NN, quad a_i >= b_j $
  意即，$a_n$ 皆 $b_n$ 之上界也，$b_n$ 皆 $a_n$ 之下界也。
]

#proof[
  設 $i, j ∈ ℕ$，不失一般性，分三種情況討論：

  *情況一：* $i = j$

  由題設知 $a_i ≥ b_i$，故 $a_i ≥ b_j$。

  *情況二：* $i < j$

  因 ${a_n}$ 單調遞減，故 $a_i ≥ a_j$。
  因 ${b_n}$ 單調遞增，故 $b_j ≥ b_i$。
  由題設 $a_j ≥ b_j$，結合上述不等式：
  $a_i ≥ a_j ≥ b_j$

  *情況三：* $i > j$

  因 ${a_n}$ 單調遞減，故 $a_j ≥ a_i$。
  因 ${b_n}$ 單調遞增，故 $b_i ≥ b_j$。
  由題設 $a_i ≥ b_i$，結合上述不等式：
  $a_i ≥ b_i ≥ b_j$

  綜上所述，$∀i, j ∈ ℕ$，恆有 $a_i ≥ b_j$。

  因此，任意 $a_i$ 皆為序列 ${b_n}$ 之上界，任意 $b_j$ 皆為序列 ${a_n}$ 之下界。
]

#proposition[
  設 $(X, prec.eq)$ 為全序集。下列三命題等價也。

  (1) 凡 $X$ 之非空子集有上界者有上確界\
  (2) 凡 $X$ 之非空子集有下界者有下確界\
  (3) $A$, $B$ 皆 $X$ 之非空子集也。 凡 $A$ 中之 $a$ 與 $B$ 中之 $b$ 使 $a prec.eq b$ 者。 $X$ 中必有一元 $c$ 夾於 $a$, $b$ 之間，即 $exists c in X, a prec.eq c prec.eq b$
]


#proof[

  (1) ⇒ (2)：使 $A$ 為 $X$ 之非空子集也，且有下界。集 $A$ 之下界以為
  $ B := {b in X | b prec.eq a, forall a in A } $
  以 $A$ 有下界知 $B$ 之不空也。凡 $a in A$ 皆為 $B$ 上界也。故 $B$ 有上確界也。
  假 $m := sup B$, 而 $m prec.eq a$ 也（以上確界乃最小上界故耳）。
  故知，$m in B$ 而 $m = max B$。$A$ 下界之最大者也。$m = inf A$。

  (2) ⇒ (3): 設 $A$, $B$ 皆 $X$ 之非空子集也。$forall a in A, forall b in B, a prec.eq b$ 也。故知 $A$ 之元俱為 $B$ 之下界也。由 (2) 知 $B$ 有下確界，設以為 $c := inf B$，則 $a prec.eq c prec.eq b$ ，即所求也。

  (3) ⇒ (1)：

]
