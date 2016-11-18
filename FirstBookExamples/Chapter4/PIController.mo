within FirstBookExamples.Chapter4;
block PIController "A PI Controller"
  parameter Real Kp=1 "Proportional Gain";
  parameter Real Ti=1 "Integral Time Constant";
  import Modelica.Blocks;

  Blocks.Interfaces.InPort command "Command signal"
    annotation (Placement(transformation(extent={{-110,10},{-90,30}},
          rotation=0)));
  Blocks.Interfaces.InPort sensor "Sensor signal"
    annotation (Placement(transformation(extent={{-108,-70},{-88,-50}},
          rotation=0)));
  Blocks.Interfaces.OutPort driver "Driver signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}},
          rotation=0)));
  Blocks.Math.Feedback Difference annotation (Placement(
        transformation(extent={{-70,10},{-50,30}}, rotation=0)));
  Blocks.Math.Gain K1(k={Kp}) annotation (Placement(transformation(
          extent={{-22,16},{-2,36}}, rotation=0)));
  Blocks.Math.Gain K2(k={1/Ti}) annotation (Placement(transformation(
          extent={{-10,-60},{10,-40}}, rotation=0)));
  Blocks.Math.Add Summation annotation (Placement(transformation(
          extent={{58,10},{78,30}}, rotation=0)));
  Blocks.Continuous.Integrator IntegratorBlock
    annotation (Placement(transformation(extent={{20,-60},{40,-40}},
          rotation=0)));
equation
  connect(command, Difference.u1) annotation (Line(points={{-100,20},
          {-68,20}}));
  connect(sensor, Difference.u2)
    annotation (Line(points={{-98,-60},{-60,-60},{-60,12}}));
  connect(Difference.y, K1.u)
    annotation (Line(points={{-51,20},{-32,20},{-32,26},{-24,26}}));
  connect(K1.y, Summation.u1) annotation (Line(points={{-1,26},{56,26}}));
  connect(K1.y, K2.u)
    annotation (Line(points={{-1,26},{4,26},{4,-20},{-20,-20},{-20,
          -50},{-12,-50}}));
  connect(IntegratorBlock.y, Summation.u2)
    annotation (Line(points={{41,-50},{50,-50},{50,14},{56,14}}));
  connect(Summation.y, driver)
    annotation (Line(points={{79,20},{88,20},{88,0},{110,0}}));
  connect(K2.y, IntegratorBlock.u)
    annotation (Line(points={{11,-50},{18,-50}}, color={0,0,255}));
  annotation (Diagram(graphics));
end PIController;
