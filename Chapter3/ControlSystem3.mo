model ControlSystem3 
  extends BookExamples.Icons.RunnableExample;
  parameter Real Kp=.4;
  parameter Real Ti=1;
  import Modelica.Blocks;
  Blocks.Math.Feedback Difference annotation (extent=[-66, 22; -46, 42]);
  Blocks.Math.Gain PGain(k={Kp}) annotation (extent=[-34, 22; -14, 42]);
  Blocks.Math.Gain TiGain(k={1/Ti}) annotation (extent=[-28, -40; -8, -20]);
  Blocks.Math.Add Summation annotation (extent=[12, 16; 32, 36]);
  Blocks.Continuous.Integrator IntegratorBlock
    annotation (extent=[12, -18; 32, 2], rotation=180);
  Blocks.Sources.Sine sinsig(
    amplitude={.2}, 
    freqHz={.3}, 
    offset={1}) annotation (extent=[-92, 22; -72, 42]);
  Blocks.Continuous.TransferFunction PlantModel(a={.8,.1}, b={1})
    annotation (extent=[60, 16; 80, 36], rotation=0);
  annotation (
    experiment(StopTime=20), 
    Commands(file="ControlSystem3.mos" "Simulate ControlSystem3"), 
    Diagram);
equation 
  connect(sinsig.outPort, Difference.inPort1)
    annotation (points=[-71, 32; -64, 32]);
  connect(Difference.outPort, PGain.inPort)
    annotation (points=[-47, 32; -36, 32]);
  connect(PGain.outPort, Summation.inPort1)
    annotation (points=[-13, 32; 10, 32]);
  connect(PGain.outPort, TiGain.inPort)
    annotation (points=[-13, 32; -6, 32; -6, 0; -40, 0; -40, -30; -30, -30]);
  connect(TiGain.outPort, IntegratorBlock.inPort)
    annotation (points=[-7, -30; 48, -30; 48, -8; 34, -8]);
  connect(IntegratorBlock.outPort, Summation.inPort2)
    annotation (points=[11, -8; 2, -8; 2, 20; 10, 20]);
  connect(Summation.outPort, PlantModel.inPort)
    annotation (points=[33, 26; 58, 26]);
  connect(PlantModel.outPort, Difference.inPort2)
    annotation (points=[81, 26; 88, 26; 88, -60; -56, -60; -56, 24]);
end ControlSystem3;
