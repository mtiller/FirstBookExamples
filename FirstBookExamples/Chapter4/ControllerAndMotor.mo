within FirstBookExamples.Chapter4;
model ControllerAndMotor
  import Modelica.Blocks;

  Blocks.Sources.Sine sinsig(
    amplitude={0.2},
    freqHz={0.3},
    offset={1.0}) annotation (extent=[-84, 10; -64, 30]);
  replaceable PIController con(Kp=0.4) constrainedby Controller
    annotation (extent=[-8, 8; 12, 28]);
  Blocks.Continuous.TransferFunction motor(a={0.8,0.1})
    annotation (extent=[34, 8; 54, 28]);
equation
  connect(sinsig.outPort, con.command) annotation (points=[-63, 20; -8, 20]);
  connect(con.driver, motor.inPort) annotation (points=[13, 18; 32, 18]);
  connect(motor.outPort, con.sensor) annotation (points=[55, 18; 72, 18; 72, -40;
         -34, -40; -34, 11.8; -7.2, 11.8]);
end ControllerAndMotor;
