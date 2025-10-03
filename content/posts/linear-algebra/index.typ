#import "/typst/template.typ": *

#let category-key = "線性代數"

#let post-template = post-template.with(
  category: category-key,
)

#show: category-template.with(
  title: category-key,
  tags: ("Mathematics", "Algebra"),
  language: "lzh",
)

我們的思路：
- 從解線性方程組說起
- 矩陣和 $FF^n$ 向量的定義
- 矩陣的運算
- 对于向量的推广 - 線性空間
 - 线性无关·张成·基底
  - Steinitz 交換定理
 - 矩阵的行空间与列空间
- 对于矩阵的推广 - 線性映射
 - 基变换与坐标变换 
 - 一般線性映射的矩陣表示
- 特征值与特征向量
 - 特征多项式与最小多项式
 - 代数重数与几何重数
- Jordan 分解
- 行列式
- 赋范空间
- 内积空间
 - 正交基底与格拉姆-施密特正交化
 - 施密特正交补空间
 - 正交映射与酉映射

 $
   vec(1,1)
   vec(1,1,1)
   vec(a,b, c,d)
 $

 