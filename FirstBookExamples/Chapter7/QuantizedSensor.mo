model QuantizedSensor
  import Modelica.SIunits;
  import Modelica.Mechanics.Rotational;
  extends Rotational.Interfaces.AbsoluteSensor;

  parameter Integer bits=4;
  parameter SIunits.Time sample_interval=0.02;
  parameter SIunits.AngularVelocity min=-150;
  parameter SIunits.AngularVelocity max=150;
  SIunits.AngularVelocity w;
protected
  parameter Real delta=(max - min)/2^bits;
  Integer level;
equation
  w = der(flange_a.phi);
  flange_a.tau = 0;
algorithm
  when sample(0, sample_interval) then
    level := integer((w - min)/delta);
  end when;
  if level < 0 then
    outPort.signal[1] := min;
  elseif level >= 2^bits then
    outPort.signal[1] := max;
  else
    outPort.signal[1] := level*delta + min;
  end if;
end QuantizedSensor;
