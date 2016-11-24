within FirstBookExamples.Chapter5;
function Piecewise "A piecewise linear interpolation"
  extends Modelica.Icons.Function;
  input Real x "Independent variable";
  input Real x_grid[:] "Independent variable data points";
  input Real y_grid[:] "Dependent variable data points";
  output Real y "Interpolated result";
protected
  Integer n;
algorithm
  n := size(x_grid, 1);
  assert(size(x_grid, 1) == size(y_grid, 1), "Size mismatch");
  assert(x >= x_grid[1] and x <= x_grid[n], "Out of range");
  for i in 1:n - 1 loop
    if x >= x_grid[i] and x <= x_grid[i + 1] then
      y := y_grid[i] + (y_grid[i + 1] - y_grid[i])*((x - x_grid[i])/(x_grid[i
         + 1] - x_grid[i]));
    end if;
  end for;
end Piecewise;
