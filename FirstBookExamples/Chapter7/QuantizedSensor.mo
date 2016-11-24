within FirstBookExamples.Chapter7;
model QuantizedSensor
  import Modelica.SIunits;
  import Modelica.Mechanics.Rotational;
  extends
    Modelica.Mechanics.Rotational.Interfaces.PartialAbsoluteSensor;

  parameter Integer bits=4;
  parameter SIunits.Time sample_interval=0.02;
  parameter SIunits.AngularVelocity min=-150;
  parameter SIunits.AngularVelocity max=150;
  SIunits.AngularVelocity w_m;
  Modelica.Blocks.Interfaces.RealOutput w annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
protected
  parameter Real delta=(max - min)/2^bits;
  Integer level;
equation
  w_m = der(flange.phi);

algorithm
  when sample(0, sample_interval) then
    level := integer((w_m - min)/delta);
  end when;
  if level < 0 then
    w := min;
  elseif level >= 2^bits then
    w := max;
  else
    w := level*delta + min;
  end if;
end QuantizedSensor;
