within FirstBookExamples.Chapter2;
model CoolingGlass
  extends FirstBookExamples.Icons.RunnableExample;
  parameter Modelica.SIunits.CoefficientOfHeatTransfer h=1;
  parameter Modelica.SIunits.SpecificHeatCapacity cp=1;
  parameter Modelica.SIunits.Mass m=3;
  Modelica.SIunits.Temperature T(start=400);
  Modelica.SIunits.Temperature T_ambient=300 + 20*time;
equation
  m*cp*der(T) = -h*(T - T_ambient);
  annotation (experiment(StopTime=10), Commands(file="CoolingGlass.mos"
        "Simulate CoolingGlass"));
end CoolingGlass;
