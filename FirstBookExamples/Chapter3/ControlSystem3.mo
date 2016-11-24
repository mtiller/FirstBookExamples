within FirstBookExamples.Chapter3;
model ControlSystem3
  extends FirstBookExamples.Icons.RunnableExample;
  parameter Real Kp=0.4;
  parameter Real Ti=1;
  import Modelica.Blocks;
  Blocks.Math.Feedback Difference annotation (Placement(
        transformation(extent={{-66,22},{-46,42}})));
  Blocks.Math.Gain PGain(k=Kp) annotation (Placement(transformation(
          extent={{-34,22},{-14,42}})));
  Blocks.Math.Gain TiGain(k=1/Ti) annotation (Placement(
        transformation(extent={{-28,-40},{-8,-20}})));
  Blocks.Math.Add Summation annotation (Placement(transformation(
          extent={{12,16},{32,36}})));
  Blocks.Continuous.Integrator IntegratorBlock
    annotation (Placement(transformation(
        origin={22,-8},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Blocks.Sources.Sine sinsig(
    amplitude=0.2,
    freqHz=0.3,
    offset=1) annotation (Placement(transformation(extent={{-92,22},{
            -72,42}})));
  Blocks.Continuous.TransferFunction PlantModel(a={0.8,0.1}, b={1})
    annotation (Placement(transformation(extent={{60,16},{80,36}})));
equation
  connect(sinsig.y, Difference.u1)
    annotation (Line(points={{-71,32},{-64,32}}));
  connect(Difference.y, PGain.u)
    annotation (Line(points={{-47,32},{-36,32}}));
  connect(PGain.y, Summation.u1)
    annotation (Line(points={{-13,32},{10,32}}));
  connect(PGain.y, TiGain.u)
    annotation (Line(points={{-13,32},{-6,32},{-6,0},{-40,0},{-40,-30},
          {-30,-30}}));
  connect(TiGain.y, IntegratorBlock.u)
    annotation (Line(points={{-7,-30},{48,-30},{48,-8},{34,-8}}));
  connect(IntegratorBlock.y, Summation.u2)
    annotation (Line(points={{11,-8},{2,-8},{2,20},{10,20}}));
  connect(Summation.y, PlantModel.u)
    annotation (Line(points={{33,26},{58,26}}));
  connect(PlantModel.y, Difference.u2)
    annotation (Line(points={{81,26},{88,26},{88,-60},{-56,-60},{-56,
          24}}));
  annotation (
    experiment(StopTime=20),
    __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter3/ControlSystem3.mos" "Simulate ControlSystem3"));
end ControlSystem3;
