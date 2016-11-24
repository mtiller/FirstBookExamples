within FirstBookExamples.Chapter10.HeatingSystem;
model MercurySwitch
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter Modelica.SIunits.Angle hysteresis(start=Modelica.Constants.pi/18);
  parameter Modelica.SIunits.Conductance Gon(start=1e+5);
  parameter Modelica.SIunits.Resistance Roff(start=1e+5);
protected
  Boolean closed;
  Modelica.SIunits.Angle upper=hysteresis/2.0;
  Modelica.SIunits.Angle lower=-hysteresis/2.0;
public
  Modelica.Mechanics.Rotational.Interfaces.Flange_a rot
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
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
