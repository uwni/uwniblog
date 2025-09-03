# Gradient Descent Example for f(x1, x2) = x1² + x1*x2 + x2²
using Pkg;
Pkg.activate(@__DIR__);
using CairoMakie

# Define the objective function
function f(x1::Real, x2::Real)::Real
    return x1^2 + x1 * x2 + x2^2
end

# Define the gradient function
function grad_f(x1::Real, x2::Real)::Vector{Real}
    return [2 * x1 + x2, 2 * x2 + x1]
end

# Gradient descent algorithm
function gradient_descent(x0::Vector{<:Real}, alpha::Real, tolerance::Real=1e-20, max_iter::Int=1000)
    x = copy(x0)
    x_history = [copy(x)]
    f_history = [f(x[1], x[2])]

    for i in 1:max_iter
        grad = grad_f(x[1], x[2])
        x_new = x - alpha * grad

        # Check convergence
        if f(x_new[1], x_new[2]) < tolerance
            push!(x_history, x_new)
            push!(f_history, f(x_new[1], x_new[2]))
            println("Converged after $i iterations")
            return x_new, i, x_history, f_history
        end

        x = x_new
        push!(x_history, copy(x))
        push!(f_history, f(x[1], x[2]))
    end

    println("Did not converge within $max_iter iterations")
    return x, max_iter, x_history, f_history
end

# Example 1: α = 0.1
println("Example 1: α = 0.1")
x0 = [1.0, 2.0]
alpha1 = 0.1
x_opt1, iterations1, x_hist1, f_hist1 = gradient_descent(x0, alpha1)

println("Initial point: x₀ = [$(x0[1]), $(x0[2])]")
println("Step size: α = $alpha1")
println("Final point after $iterations1 iterations: x* ≈ [$(x_opt1[1]), $(x_opt1[2])]")
println("Final function value: f(x*) ≈ $(f(x_opt1[1], x_opt1[2]))")
println()

# Example 2: α = 0.4
println("Example 2: α = 0.4")
alpha2 = 0.4
x_opt2, iterations2, x_hist2, f_hist2 = gradient_descent(x0, alpha2)

println("Initial point: x₀ = [$(x0[1]), $(x0[2])]")
println("Step size: α = $alpha2")
println("Final point after $iterations2 iterations: x* ≈ [$(x_opt2[1]), $(x_opt2[2])]")
println("Final function value: f(x*) ≈ $(f(x_opt2[1], x_opt2[2]))")
println()

# Verify analytical solution: minimum at (0, 0)
println("Analytical solution:")
println("Minimum at x* = [0, 0] with f(x*) = 0")
println("The quadratic form x₁² + x₁x₂ + x₂² = [x₁, x₂] * [1 0.5; 0.5 1] * [x₁; x₂]")
println("The matrix has positive eigenvalues, confirming a global minimum at the origin.")

# Create visualization: contour plot with gradient vector field using Makie
function create_visualization()
    # Define grid for plotting
    x_range = -3:0.2:3
    y_range = -3:0.2:3

    Z = [f(x, y) for x in x_range, y in y_range]

    # Create figure
    fig = Figure(size=(900, 700))
    ax = Axis(fig[1, 1],
        title="Function f(x₁,x₂) = x₁² + x₁x₂ + x₂² with Gradient Field",
        xlabel="x₁",
        ylabel="x₂",
        aspect=1,
        limits=(-3, 3, -3, 3),
        xticks=-3:1:3,
        yticks=-3:1:3)

    # Add smooth surface with blue transparency gradient
    surface!(ax, x_range, y_range, fill(0f0, size(Z));
        color=Z,
        colormap=:GnBu,
        shading=NoShading,
    )

    # Get nice contour levels using Makie's tick finder
    levels = Makie.get_tickvalues(Makie.LinearTicks(10), extrema(Z)...)

    # Add contour lines with labels
    contour!(ax, x_range, y_range, Z,
        levels=levels,
        color=:black,
        linewidth=1,
        labels=true,
        labelfont=:bold,
        labelsize=10)

    # Create gradient vector field (subsample for clarity)
    step = 4
    x_arrows = collect(x_range[1:step:end])
    y_arrows = collect(y_range[1:step:end])

    # Compute gradient vectors with magnitude scaling
    u_vals = Float64[]
    v_vals = Float64[]
    x_vals = Float64[]
    y_vals = Float64[]
    strength = Float64[]

    for x in x_arrows, y in y_arrows
        grad = grad_f(x, y)
        norm_grad = sqrt(grad[1]^2 + grad[2]^2)
        if norm_grad > 0
            push!(u_vals, grad[1])  # Negative for descent direction
            push!(v_vals, grad[2])
            push!(x_vals, x)
            push!(y_vals, y)
            push!(strength, norm_grad)
        end
    end

    # Add gradient vector field
    arrows2d!(ax, x_vals, y_vals, u_vals, v_vals,
        color=strength,
        lengthscale=0.1)

    # Add gradient descent path for α = 0.1
    x_path = [x_hist1[i][1] for i in eachindex(x_hist1)]
    y_path = [x_hist1[i][2] for i in eachindex(x_hist1)]

    lines!(ax, x_path, y_path,
        color=:red,
        linewidth=1,
        label="α = 0.1 path")

    # Add hollow markers for iteration points
    scatter!(ax, x_path, y_path,
        color=:red,
        strokecolor=:black,
        strokewidth=1,
        markersize=10)

    # Mark the minimum point
    scatter!(ax, [0], [0],
        color=:transparent,
        strokecolor=:black,
        strokewidth=2,
        markersize=16,
        label="Global minimum")

    # Mark starting point
    scatter!(ax, [x0[1]], [x0[2]],
        markersize=10,
        marker=:xcross,
        label="Starting point")

    # Add legend
    axislegend(ax, position=:rt)

    return fig
end

# Create and display the visualization
plot_combined = create_visualization()

# Save the plot
save(string(@__DIR__, "assets/gradient_descent_visualization.pdf"), plot_combined)