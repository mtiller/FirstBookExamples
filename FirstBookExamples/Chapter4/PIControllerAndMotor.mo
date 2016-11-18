model PIControllerAndMotor
  extends FirstBookExamples.Icons.RunnableExample;
  annotation (experiment(StopTime=20),
              Commands(file="PIControllerAndMotor.mos" "Simulate Motor with PI controller"),
              Diagram);
  import Modelica.Blocks;

  Blocks.Sources.Sine sinsig(
    amplitude={0.2},
    freqHz={0.3},
    offset={1.0}) annotation (extent=[-70, 20; -50, 40]);
  PIController pic(Kp=0.4) annotation (extent=[-22, 18; -2, 38]);
  Blocks.Continuous.TransferFunction motor(a={0.8,0.1})
    annotation (extent=[30, 18; 50, 38]);
equation
  connect(sinsig.outPort, pic.command) annotation (points=[-49, 30; -22, 30]);
  connect(pic.driver, motor.inPort) annotation (points=[-1, 28; 28, 28]);
  connect(motor.outPort, pic.sensor) annotation (points=[51, 28; 62, 28; 62, -42;
         -30, -42; -30, 22; -21.8, 22]);
end PIControllerAndMotor;
