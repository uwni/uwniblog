# Gradient Descent Example for f(x1, x2) = x1² + x1*x2 + x2²
using Pkg;
Pkg.activate(@__DIR__);

using CairoMakie, CSV, DataFrames

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

    for i ∈ 1:max_iter
        grad = grad_f(x[1], x[2])
        x_new = x - alpha * grad

        # Check convergence
        if f(x_new[1], x_new[2]) < tolerance
            push!(x_history, x_new)
            push!(f_history, f(x_new[1], x_new[2]))
            return x_new, i, x_history, f_history
        end

        x = x_new
        push!(x_history, copy(x))
        push!(f_history, f(x[1], x[2]))
    end

    return x, max_iter, x_history, f_history
end

# Function to export iteration data to CSV
function export_to_csv(x_history, f_history, filename)
    # Create DataFrame with iteration data
    df = DataFrame(
        iteration=0:(length(x_history)-1),
        x1=[x[1] for x in x_history],
        x2=[x[2] for x in x_history],
        f_value=f_history
    )

    # Save to assets directory
    filepath = joinpath(@__DIR__, "assets", filename)
    CSV.write(filepath, df)
    return df
end

# Example 1: α = 0.1
x0 = [1.0, 2.0]
alpha1 = 0.1
x_opt1, iterations1, x_hist1, f_hist1 = gradient_descent(x0, alpha1)

export_to_csv(x_hist1, f_hist1, "gradient_descent_alpha_0.1.csv")

# Example 2: α = 0.4
alpha2 = 0.4
x_opt2, iterations2, x_hist2, f_hist2 = gradient_descent(x0, alpha2)

export_to_csv(x_hist2, f_hist2, "gradient_descent_alpha_0.4.csv")

# Example 3: α = 0.5
alpha3 = 0.5
x_opt3, iterations3, x_hist3, f_hist3 = gradient_descent(x0, alpha3)

export_to_csv(x_hist3, f_hist3, "gradient_descent_alpha_0.5.csv")

# Common functions for consistent visualization styles
function add_starting_point!(ax, x, y; label=nothing)
    scatter!(ax, [x], [y],
        markersize=12,
        color=:blue,
        strokecolor=:white,
        strokewidth=2,
        marker=:circle,
        label=label)
end

function add_iteration_points!(ax, x_path, y_path; label=nothing)
    scatter!(ax, x_path, y_path,
        color=(:red, 0.8),
        markersize=8,
        strokecolor=:black,
        strokewidth=1,
        label=label)
end

function add_iteration_path!(ax, x_path, y_path; label=nothing)
    scatterlines!(ax, x_path, y_path,
        color=(:red, 0.8),
        linewidth=2,
        markersize=10,
        strokecolor=:black,
        strokewidth=1,
        label=label)
end

function add_optimal_point!(ax, x, y; label=nothing)
    scatter!(ax, [x], [y],
        markersize=12,
        color=:green,
        strokecolor=:white,
        strokewidth=2,
        marker=:star5,
        label=label)
end

# Common function to setup base plot with contours
function setup_base_plot(title::String)
    # Define grid for plotting
    x_range = -1:0.2:3
    y_range = -1:0.2:3
    Z = [f(x, y) for x in x_range, y in y_range]

    # Create figure with transparent background and minimal margins
    fig = Figure(size=(900, 700), backgroundcolor=:transparent)

    ax = Axis(fig[1, 1],
        title=title,
        xlabel="x₁",
        ylabel="x₂",
        limits=(-1, 3, -1, 3),
        xticks=-1:1:3,
        yticks=-1:1:3,
    )

    colsize!(fig.layout, 1, Aspect(1, 1.0))

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
        color=(:black, 0.5),
        linewidth=1,
        labels=true,
        labelfont=:bold,
        labelsize=12)

    resize_to_layout!(fig)
    return fig, ax, x_range, y_range
end

# Create visualization: contour plot with gradient vector field using Makie
function create_visualization()
    fig, ax, x_range, y_range = setup_base_plot("Function f(x₁,x₂) = x₁² + x₁x₂ + x₂² with Gradient Field")

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

    add_iteration_path!(ax, x_path, y_path, label="α = 0.1 path")

    # Mark starting point
    add_starting_point!(ax, x0[1], x0[2], label="Starting point")

    # Add legend
    axislegend(ax, position=:rt)

    return fig
end

# Create and display the visualization
plot_combined = create_visualization()

# Save the plot
save(joinpath(@__DIR__, "assets", "gradient_descent_visualization.svg"), plot_combined)

# CONSTRAINED GRADIENT DESCENT EXAMPLE
# Reuse the same objective function and gradient as unconstrained case

# Projection onto line constraint x2 = 1
function project_line(x::Vector{<:Real})::Vector{Real}
    # Project onto line x2 = 1
    # Keep x1 unchanged, set x2 = 1
    return [x[1], 1.0]
end

# Projected gradient descent algorithm with projection tracking
function projected_gradient_descent(x0::Vector{<:Real}, alpha::Real, tolerance::Real=1e-20, max_iter::Int=1000)
    # Project initial point onto constraint set
    x = project_line(x0)
    x_history = [copy(x)]
    f_history = [f(x[1], x[2])]

    # Track intermediate steps for visualization
    gradient_steps = Vector{Vector{Float64}}()  # y = x - α∇f(x)
    projections = Vector{Vector{Float64}}()     # projected points

    for i ∈ 1:max_iter
        # Compute gradient
        grad = grad_f(x[1], x[2])

        # Gradient step (unconstrained update)
        y = x - alpha * grad
        push!(gradient_steps, copy(y))

        # Project onto feasible set
        x_new = project_line(y)
        push!(projections, copy(x_new))

        # Check convergence
        if f(x_new[1], x_new[2]) < tolerance
            push!(x_history, x_new)
            push!(f_history, f(x_new[1], x_new[2]))
            return x_new, i, x_history, f_history, gradient_steps, projections
        end

        x = x_new
        push!(x_history, copy(x))
        push!(f_history, f(x[1], x[2]))
    end

    return x, max_iter, x_history, f_history, gradient_steps, projections
end

# Example: Starting from same point as unconstrained case
x0_constrained = [1.0, 2.0]  # Same as unconstrained starting point
alpha_constrained = 0.1
x_opt_constrained, iterations_constrained, x_hist_constrained, f_hist_constrained, grad_steps_constrained, proj_constrained = projected_gradient_descent(x0_constrained, alpha_constrained)

export_to_csv(x_hist_constrained, f_hist_constrained, "constrained_gradient_descent.csv")


# Create visualization for constrained case
function create_constrained_visualization()
    fig, ax, x_range, y_range = setup_base_plot("Constrained Optimization: f(x₁,x₂) = x₁² + x₁x₂ + x₂² subject to x₂ = 1")

    # Highlight feasible region: line x2 = 1
    x_line = [-1, 3]  # Extend line across the plot
    y_line = [1, 1]   # Horizontal line at x2 = 1
    lines!(ax, x_line, y_line,
        color=:black,
        linewidth=2,
        label="Constraint: x₂ = 1")

    # Add optimization paths with projection visualization

    # Path starting from [1.0, 2.0] - show only scatter points
    x_path_constrained = [x_hist_constrained[i][1] for i in eachindex(x_hist_constrained)]
    y_path_constrained = [x_hist_constrained[i][2] for i in eachindex(x_hist_constrained)]

    add_iteration_points!(ax, x_path_constrained, y_path_constrained, label="Iteration points")

    # Show initial projection separately
    # Mark original starting point
    add_starting_point!(ax, 1.0, 2.0, label="Starting point")

    lines!(ax, [1.0, x_hist_constrained[1][1]], [2.0, x_hist_constrained[1][2]],
        color=:orange,
        linestyle=:dot)

    # Show gradient arrows and projection process for all gradient descent iterations
    for i in eachindex(grad_steps_constrained)
        current_point = x_hist_constrained[i]
        gradient_step = grad_steps_constrained[i]
        projected_point = proj_constrained[i]

        # Calculate transparency based on iteration (Gaussian decay starting from iteration 1)
        # Use the rapid decay part of Gaussian function
        # iter_alpha = exp(-0.1 * (i - 1)^2)  # Adjust decay rate as needed
        iter_alpha = 1 / (i - 1)^2 # Adjust decay rate as needed

        # Draw gradient step with arrow
        arrows2d!(ax, [current_point[1]], [current_point[2]],
            [gradient_step[1] - current_point[1]], [gradient_step[2] - current_point[2]],
            color=:red,
            shaftwidth=1,
            tipwidth=2,
            alpha=iter_alpha)

        # Draw projection step (dotted line from unconstrained update to projected point)
        lines!(ax, [gradient_step[1], projected_point[1]], [gradient_step[2], projected_point[2]],
            color=:orange,
            linestyle=:dot,
            alpha=iter_alpha)
    end



    # Mark optimal point (constrained optimum)
    # For f(x1,x2) = x1² + x1*x2 + x2² subject to x2 = 1
    # ∇f = [2x1 + x2, 2x2 + x1], when x2 = 1: ∇f = [2x1 + 1, 2 + x1]
    # At optimum on constraint line, gradient should be orthogonal to constraint
    # Since constraint is x2 = 1 (horizontal line), gradient should be vertical
    # So 2x1 + 1 = 0, hence x1 = -1/2
    x_opt_analytical = -0.5
    y_opt_analytical = 1.0
    add_optimal_point!(ax, x_opt_analytical, y_opt_analytical, label="Constrained optimum")

    # Add legend
    axislegend(ax, position=:rt)

    return fig
end

# Create and save the constrained visualization
plot_constrained = create_constrained_visualization()
save(joinpath(@__DIR__, "assets", "constrained_gradient_descent_visualization.svg"), plot_constrained)
println("Constrained gradient descent completed successfully!")

@show plot_constrained
