within FirstBookExamples.Thermal;
package Basic1D
  extends Modelica.Icons.Library;
  model Capacitance "Thermal capacitance"
    parameter Modelica.SIunits.SpecificHeatCapacity cp=1.0;
    parameter Modelica.SIunits.Density rho=1.0;
    parameter Modelica.SIunits.Volume V=1.0;
    Interfaces.Node_a n annotation (extent=[-10, -10; 10, 10]);
  equation
    V*cp*rho*der(n.T) = n.q;
    annotation (
      Icon(
        Polygon(points=[0, 80; -20, 76; -40, 70; -52, 56; -58, 48; -68, 38; -
              72, 26; -76, 12; -78, -2; -76, -18; -76, -30; -76, -40; -70, -52;
                -64, -60; -48, -64; -30, -70; -18, -70; -2, -72; 8, -76; 22, -
              76; 32, -74; 42, -68; 54, -62; 56, -60; 66, -48; 68, -40; 70, -38;
                72, -22; 76, -8; 78, 0; 78, 16; 74, 28; 66, 38; 54, 46; 44, 54;
                36, 70; 26, 78; 0, 80], style(color=9, fillColor=8)),
        Polygon(points=[-58, 48; -68, 38; -72, 26; -76, 12; -78, -2; -76, -18;
                -76, -30; -76, -40; -70, -52; -64, -60; -48, -64; -30, -70; -18,
                -70; -2, -72; 8, -76; 22, -76; 32, -74; 42, -68; 54, -62; 42, -
              64; 40, -64; 30, -66; 20, -68; 18, -68; 10, -68; 2, -64; -12, -60;
                -22, -60; -30, -58; -40, -52; -50, -42; -56, -30; -58, -22; -58,
                -12; -60, 0; -60, 8; -60, 20; -58, 30; -56, 32; -52, 40; -48,
              48; -44, 58; -40, 70; -58, 48], style(color=0, fillColor=9)),
        Text(extent=[-100, 120; 100, 80], string="%name")),
      Documentation(info="This is a generic model for thermal capacitance of material.  No
specific geometry is assumped beyond a total volume.  This model
also assumes a single uniform temperature for the entire volume.

It is also assumed that the density and specific heat capacity are
indepedent of temperature.
"));
  end Capacitance;

  model Conduction "Linear heat conduction"
    extends Interfaces.Element1D;
    parameter Modelica.SIunits.ThermalConductivity k=1.0;
    parameter Modelica.SIunits.Length L=1.0;
    parameter Modelica.SIunits.Area A=1.0;
  equation
    q = A*k*dT/L;
    annotation (
      Icon(
        Rectangle(extent=[-90, 80; 90, -80], style(
            color=0,
            pattern=0,
            fillColor=8,
            fillPattern=8)),
        Line(points=[-90, 80; -90, -80], style(color=0, thickness=2)),
        Line(points=[90, 80; 90, -80], style(color=0, thickness=2)),
        Text(extent=[-100, 120; 100, 80], string="%name")),
      Diagram,
      Documentation(info="This is a model for linear heat conduction.  The constitutive equation for heat conduction is:

q = k*(a.T-b.T)/L;

Both 'k' and 'L' are parameters.  The thermal conductivity, k, is not a function of temperature
in this model."));
  end Conduction;

  model Convection "Linear heat convection"
    extends Interfaces.Element1D;
    parameter Modelica.SIunits.CoefficientOfHeatTransfer h=1.0;
    parameter Modelica.SIunits.Area A=1.0;
  equation
    q = A*h*dT;
    annotation (
      Icon(
        Rectangle(extent=[60, 80; 90, -80], style(
            color=0,
            fillColor=8,
            fillPattern=8)),
        Line(points=[-40, 80; -40, -80], style(
            color=45,
            thickness=2,
            fillColor=47)),
        Line(points=[-40, -80; -50, -60], style(
            color=45,
            thickness=2,
            fillColor=47)),
        Line(points=[-40, -80; -30, -60], style(
            color=45,
            thickness=2,
            fillColor=47)),
        Line(points=[0, 80; 0, -80], style(
            color=45,
            thickness=2,
            fillColor=47)),
        Line(points=[0, -80; -10, -60], style(
            color=45,
            thickness=2,
            fillColor=47)),
        Line(points=[0, -80; 10, -60], style(
            color=45,
            thickness=2,
            fillColor=47)),
        Line(points=[40, 80; 40, -80], style(
            color=45,
            thickness=2,
            fillColor=47)),
        Line(points=[40, -80; 30, -60], style(
            color=45,
            thickness=2,
            fillColor=47)),
        Line(points=[40, -80; 50, -60], style(
            color=45,
            thickness=2,
            fillColor=47)),
        Rectangle(extent=[-90, 80; -60, -80], style(
            color=0,
            fillColor=8,
            fillPattern=8)),
        Text(extent=[-100, 120; 100, 80], string="%name")),
      Documentation(info="This is model of linear heat convection.  The basic constitutive equation for convection is:

q = h*(a.T-b.T);

It is assumed in this model that 'h' is a parameter and therefore not a function of temperature.
"));
  end Convection;

  model BlackBodyRadiation "Black body radiation"
    extends Interfaces.Element1D;
    parameter Real F "View factor";
    parameter Modelica.SIunits.Area A=1.0;
  equation
    q = F*Modelica.Constants.sigma*A*(a.T^4 - b.T^4);
    annotation (
      Icon(
        Line(points=[-40, 10; 40, 10], style(
            color=45,
            thickness=2,
            fillColor=45)),
        Line(points=[-40, 10; -30, 16], style(
            color=45,
            thickness=2,
            fillColor=45)),
        Line(points=[-40, 10; -30, 4], style(
            color=45,
            thickness=2,
            fillColor=45)),
        Line(points=[-40, -10; 40, -10], style(
            color=45,
            thickness=2,
            fillColor=45)),
        Line(points=[30, -16; 40, -10], style(
            color=45,
            thickness=2,
            fillColor=45)),
        Line(points=[30, -4; 40, -10], style(
            color=45,
            thickness=2,
            fillColor=45)),
        Rectangle(extent=[60, 80; 90, -80], style(
            color=0,
            fillColor=8,
            fillPattern=8)),
        Line(points=[-40, -30; 40, -30], style(
            color=45,
            thickness=2,
            fillColor=45)),
        Line(points=[-40, -30; -30, -24], style(
            color=45,
            thickness=2,
            fillColor=45)),
        Line(points=[-40, -30; -30, -36], style(
            color=45,
            thickness=2,
            fillColor=45)),
        Line(points=[-40, 30; 40, 30], style(
            color=45,
            thickness=2,
            fillColor=45)),
        Line(points=[30, 24; 40, 30], style(
            color=45,
            thickness=2,
            fillColor=45)),
        Line(points=[30, 36; 40, 30], style(
            color=45,
            thickness=2,
            fillColor=45)),
        Line(points=[60, 80; 60, -80], style(color=0, thickness=4)),
        Rectangle(extent=[-90, 80; -60, -80], style(
            color=0,
            fillColor=8,
            fillPattern=8)),
        Line(points=[-60, 80; -60, -80], style(color=0, thickness=4)),
        Text(extent=[-100, 120; 100, 80], string="%name")),
      Documentation(info="This simple radiation model uses the following constitutive equation:

q = F*A*sigma*(a.T^4-b.T^4);

where 'F' is a view factor (see \"A Heat Transfer Textbook\", Lienhard, 1987), 'A' is the area of the radiating surface
and sigma is the Stefan-Boltzmann constant.  It should be pointed out that 'F' should be chosen so that it
corresponds to the surface for which the area, 'A', is being supplied.  In other words, each surface will have
its own unique value for F (based on geometry) and it is important the values of 'F' and 'A' be consistent with
each other.
"));
  end BlackBodyRadiation;
end Basic1D;
