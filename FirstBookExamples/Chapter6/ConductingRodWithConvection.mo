within FirstBookExamples.Chapter6;
model ConductingRodWithConvection
  import Modelica.SIunits;
  extends ConductingRod;

  parameter SIunits.Length perimeter=1.0;
  parameter SIunits.CoefficientOfHeatTransfer h=1.0;
  ThermalNode ambient annotation (extent=[-8, -108; 12, -88]);
protected
  parameter SIunits.Area As=perimeter*dx;
  ThermalConvection conv[n](each h=h, each A=As)
    annotation (extent=[-22, -28; -2, -8]);
equation
  for i in 1:n loop
    connect(cap[i].p, conv[i].a);
    connect(ambient, conv[i].b);
  end for;
  annotation (Diagram);
end ConductingRodWithConvection;
