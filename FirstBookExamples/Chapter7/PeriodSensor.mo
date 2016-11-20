within FirstBookExamples.Chapter7;
model PeriodSensor
  import Modelica.Mechanics.Rotational;

  extends
    Modelica.Mechanics.Rotational.Interfaces.PartialAbsoluteSensor;
  parameter Integer divisions=4;
  Modelica.Blocks.Interfaces.RealOutput w annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
protected
  parameter Modelica.SIunits.Angle trigger_interval=2*Modelica.Constants.pi/
      divisions;
  discrete Modelica.SIunits.Angle upper;
  discrete Modelica.SIunits.Angle lower;
  Modelica.SIunits.Time last_time;

algorithm
  when initial() or flange.phi >= upper or flange.phi <= lower then
    upper := flange.phi + trigger_interval;
    lower := flange.phi - trigger_interval;
    last_time := time;
    w := if initial() then 0.0 else trigger_interval/(time -
      pre(last_time));
  end when;
end PeriodSensor;
