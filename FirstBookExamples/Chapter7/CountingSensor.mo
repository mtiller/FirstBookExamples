within FirstBookExamples.Chapter7;
model CountingSensor
  import Modelica.Mechanics.Rotational;

  extends
    Modelica.Mechanics.Rotational.Interfaces.PartialAbsoluteSensor;
  parameter Integer divisions=4;
  parameter Modelica.SIunits.Time sample_interval=0.1;
  Modelica.Blocks.Interfaces.RealOutput w annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));

protected
  constant Real pi=Modelica.Constants.pi;
  parameter Modelica.SIunits.Angle trigger_interval=2*pi/divisions;
  Integer count;
  Real s;

equation
  s = Modelica.Math.sin(flange.phi*divisions);
algorithm
  when initial() then
    count := 0;
  end when;
  when s >= 0 then
    count := pre(count) + 1;
  end when;
  when sample(sample_interval, sample_interval) then
    count := 0;
    w := (pre(count) + 1)*trigger_interval/sample_interval;
  end when;
end CountingSensor;
