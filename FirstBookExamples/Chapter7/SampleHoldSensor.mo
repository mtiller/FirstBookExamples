within FirstBookExamples.Chapter7;
model SampleHoldSensor
  import Modelica.Mechanics.Rotational;

  extends
    Modelica.Mechanics.Rotational.Interfaces.PartialAbsoluteSensor;
  Modelica.SIunits.AngularVelocity w_m;
  parameter Modelica.SIunits.Time sample_interval=0.1;
  Modelica.Blocks.Interfaces.RealOutput w annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
equation
  w_m = der(flange.phi);
algorithm
  when sample(0, sample_interval) then
    w := w_m;
  end when;
end SampleHoldSensor;
