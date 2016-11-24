within FirstBookExamples.Chapter5;
function PolyEval "Evaluate polynomial and derivative"
  extends Modelica.Icons.Function;
  input Real x "Independent variable";
  input Real coef[:] "Coefficients (low to high order)";
  output Real y "Result of polynomial evaluation";
  output Real dydx "Derivative of polynomial";
protected
  Integer n;
algorithm
  n := size(coef, 1);
  y := coef[n];
  dydx := 0.0;
  for i in n - 1:-1:1 loop
    y := y*x + coef[i];
    dydx := dydx*x + i*coef[i + 1];
  end for;
end PolyEval;
