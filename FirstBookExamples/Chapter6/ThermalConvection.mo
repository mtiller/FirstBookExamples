within FirstBookExamples.Chapter6;
model ThermalConvection "1-D Convective Heat Transfer"
  // Physical parameters
  import Modelica.SIunits;
  parameter SIunits.CoefficientOfHeatTransfer h=1.0;
  parameter SIunits.Area A=1.0;

  // Connectors
  ThermalNode a;
  ThermalNode b;
equation
  a.q = A*h*(a.T - b.T);
  b.q = -A*h*(a.T - b.T);
end ThermalConvection;
