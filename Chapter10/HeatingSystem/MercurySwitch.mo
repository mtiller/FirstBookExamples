model MercurySwitch 
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter Modelica.SIunits.Angle hysteresis(start=Modelica.Constants.PI/18);
  parameter Modelica.SIunits.Conductance Gon(start=1e+5);
  parameter Modelica.SIunits.Resistance Roff(start=1e+5);
protected 
  Boolean closed;
  Modelica.SIunits.Angle upper=hysteresis/2.0;
  Modelica.SIunits.Angle lower=-hysteresis/2.0;
  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100], 
      grid=[2, 2], 
      component=[20, 20]), 
    Window(
      x=0.28, 
      y=0.31, 
      width=0.6, 
      height=0.6), 
    Icon(
      Polygon(points=[-60, 26; -80, 40; -80, 48; -80, 60; -18, 80; 20, 80; 80, 
            60; 80, 40; 60, 26; 0, 40; -60, 26], style(color=0, fillColor=7)), 
      Polygon(points=[20, 38; 60, 28; 74, 38; 74, 42; 68, 46; 26, 46; 20, 42; 
            20, 38], style(color=0, fillColor=9)), 
      Line(points=[10, -90; 80, 40], style(color=0, thickness=4)), 
      Line(points=[-80, 40; -10, -90], style(color=0, thickness=4)), 
      Line(points=[-74, 52; -74, 42; -62, 34], style(color=0)), 
      Line(points=[48, 36; 48, 0; -100, 0]), 
      Line(points=[54, 36; 54, 0; 90, 0])));
public 
  Modelica.Mechanics.Rotational.Interfaces.Flange_a rot
    annotation (extent=[-10, -110; 10, -90]);
equation 
  i = if (closed) then Gon*v else v/Roff;
  //  i = 0.0;
  rot.tau = 0.0;
algorithm 
  when (initial()) then
    closed := rot.phi <= lower;
  end when;
  
  when (rot.phi <= lower) then
    closed := true;
  end when;
  
  when (rot.phi >= upper) then
    closed := false;
  end when;
  
end MercurySwitch;
