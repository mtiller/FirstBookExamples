model PeriodSensor 
  import Modelica.Mechanics.Rotational;
  
  extends Rotational.Interfaces.AbsoluteSensor;
  parameter Integer divisions=4;
protected 
  parameter Modelica.SIunits.Angle trigger_interval=2*Modelica.Constants.pi/
      divisions;
  discrete Modelica.SIunits.Angle upper;
  discrete Modelica.SIunits.Angle lower;
  Modelica.SIunits.Time last_time;
equation 
  flange_a.tau = 0;
algorithm 
  when initial() or flange_a.phi >= upper or flange_a.phi <= lower then
    upper := flange_a.phi + trigger_interval;
    lower := flange_a.phi - trigger_interval;
    last_time := time;
    outPort.signal[1] := if initial() then 0.0 else trigger_interval/(time - 
      pre(last_time));
  end when;
end PeriodSensor;
