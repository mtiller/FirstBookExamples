model CoolingGlass 
  extends BookExamples.Icons.RunnableExample;
  parameter Modelica.SIunits.CoefficientOfHeatTransfer h=1;
  parameter Modelica.SIunits.SpecificHeatCapacity cp=1;
  parameter Modelica.SIunits.Mass m=3;
  Modelica.SIunits.Temperature T(start=400);
  Modelica.SIunits.Temperature T_ambient=300 + 20*time;
  annotation (experiment(StopTime=10), Commands(file="CoolingGlass.mos" 
        "Simulate CoolingGlass"));
equation 
  m*cp*der(T) = -h*(T - T_ambient);
end CoolingGlass;
