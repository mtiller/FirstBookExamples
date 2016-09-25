model SampleHoldSensor 
  import Modelica.Mechanics.Rotational;
  
  extends Rotational.Interfaces.AbsoluteSensor;
  Modelica.SIunits.AngularVelocity w;
  parameter Modelica.SIunits.Time sample_interval=0.1;
equation 
  w = der(flange_a.phi);
  flange_a.tau = 0;
algorithm 
  when sample(0, sample_interval) then
    outPort.signal[1] := w;
  end when;
end SampleHoldSensor;
