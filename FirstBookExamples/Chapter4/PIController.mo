within FirstBookExamples.Chapter4;
block PIController "A PI Controller"
  parameter Real Kp=1 "Proportional Gain";
  parameter Real Ti=1 "Integral Time Constant";
  import Modelica.Blocks;

  Blocks.Interfaces.InPort command "Command signal"
    annotation (extent=[-110, 10; -90, 30]);
  Blocks.Interfaces.InPort sensor "Sensor signal"
    annotation (extent=[-108, -70; -88, -50]);
  Blocks.Interfaces.OutPort driver "Driver signal"
    annotation (extent=[100, -10; 120, 10]);
  Blocks.Math.Feedback Difference annotation (extent=[-70, 10; -50, 30]);
  Blocks.Math.Gain K1(k={Kp}) annotation (extent=[-22, 16; -2, 36]);
  Blocks.Math.Gain K2(k={1/Ti}) annotation (extent=[-10, -60; 10, -40]);
  Blocks.Math.Add Summation annotation (extent=[58, 10; 78, 30]);
  Blocks.Continuous.Integrator IntegratorBlock
    annotation (extent=[20, -60; 40, -40]);
equation
  connect(command, Difference.inPort1) annotation (points=[-100, 20; -68, 20]);
  connect(sensor, Difference.inPort2)
    annotation (points=[-98, -60; -60, -60; -60, 12]);
  connect(Difference.outPort, K1.inPort)
    annotation (points=[-51, 20; -32, 20; -32, 26; -24, 26]);
  connect(K1.outPort, Summation.inPort1) annotation (points=[-1, 26; 56, 26]);
  connect(K1.outPort, K2.inPort)
    annotation (points=[-1, 26; 4, 26; 4, -20; -20, -20; -20, -50; -12, -50]);
  connect(IntegratorBlock.outPort, Summation.inPort2)
    annotation (points=[41, -50; 50, -50; 50, 14; 56, 14]);
  connect(Summation.outPort, driver)
    annotation (points=[79, 20; 88, 20; 88, 0; 110, 0]);
  connect(K2.outPort, IntegratorBlock.inPort)
    annotation (points=[11, -50; 18, -50], style(color=3));
  annotation (Diagram);
end PIController;
