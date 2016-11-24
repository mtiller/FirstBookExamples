within FirstBookExamples.Chapter2;
model TwoTanks "Hydraulic system involving two tanks"
  extends FirstBookExamples.Icons.RunnableExample;
  import Modelica.SIunits;

  // Constants
  constant Real pi=Modelica.Constants.pi;
  constant Real g=Modelica.Constants.g_n;

  // Parameters
  parameter SIunits.Length L=0.1 "Pipe length";
  parameter SIunits.Length D=0.2 "Pipe diameter";
  parameter SIunits.Density rho=0.2 "Fluid density";
  parameter SIunits.DynamicViscosity mu=2e-3;
  parameter SIunits.Area A1=1.0 "Area of left tank";
  parameter SIunits.Area A2=2.0 "Area of right tank";
  parameter SIunits.KinematicViscosity c=(pi*D^4)/(128*mu*L);

  // Variables
  SIunits.Pressure P1;
  SIunits.Pressure P2;
  SIunits.Length H1;
  SIunits.Length H2(start=2);
  SIunits.VolumeFlowRate Q;
equation
  // Pressure equations
  P1 = rho*H1*g;
  P2 = rho*H2*g;

  // Flow rate
  Q = c*(H1 - H2);

  // Conservation of mass
  A1*der(H1) = -Q;
  A2*der(H2) = Q;
  annotation (experiment(
      StopTime=10,
      Tolerance=1E-8), __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter2/TwoTanks.mos" "Simulate TwoTanks"));
end TwoTanks;
