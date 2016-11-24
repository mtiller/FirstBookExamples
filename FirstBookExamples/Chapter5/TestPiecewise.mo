within FirstBookExamples.Chapter5;
model TestPiecewise
  extends FirstBookExamples.Icons.RunnableExample;
  import Modelica.SIunits;
  parameter SIunits.Time x_values[:]={0,2,4,6,8,10};
  parameter Real y_values[:]={0,0,4,16,36,64};
  Real y;
  Real x;
  Real z;
equation
  y = Piecewise(x=time, x_grid=x_values, y_grid=y_values);
  der(x) = -y;
  der(z) = -x;
  annotation (experiment(StopTime=9.999),
              __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter5/TestPiecewise.mos" "Simulate TestPiecewise"));
end TestPiecewise;
