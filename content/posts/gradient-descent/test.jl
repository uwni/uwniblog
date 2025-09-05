using Pkg;
Pkg.activate(@__DIR__);

using CairoMakie
set_theme!(backgroundcolor=:gray90)

f = Figure(size=(800, 500))
ax = Axis(f[1, 1])
Colorbar(f[1, 2])
colsize!(f.layout, 1, Aspect(1, 1.0))
resize_to_layout!(f)
f
