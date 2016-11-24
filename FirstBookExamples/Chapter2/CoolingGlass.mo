within FirstBookExamples.Chapter2;
model CoolingGlass
  extends FirstBookExamples.Icons.RunnableExample;
  parameter Modelica.SIunits.CoefficientOfHeatTransfer h=1;
  parameter Modelica.SIunits.SpecificHeatCapacity cp=1;
  parameter Modelica.SIunits.Mass m=3;
  parameter Modelica.SIunits.Area A=1;
  Modelica.SIunits.Temperature T(start=400);
  Modelica.SIunits.Temperature T_ambient=300 + 20*time;
equation
  m*cp*der(T) = -h*A*(T - T_ambient);
  annotation (experiment(StopTime=10), __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter2/CoolingGlass.mos"
        "Simulate CoolingGlass"));
end CoolingGlass;
