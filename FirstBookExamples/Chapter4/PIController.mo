within FirstBookExamples.Chapter4;
block PIController "A PI Controller"
  parameter Real Kp=1 "Proportional Gain";
  parameter Real Ti=1 "Integral Time Constant";
  import Modelica.Blocks;

  Blocks.Interfaces.RealInput command "Command signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Blocks.Interfaces.RealInput sensor "Sensor signal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Blocks.Interfaces.RealOutput driver "Driver signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Blocks.Math.Feedback Difference annotation (Placement(
        transformation(extent={{-70,-10},{-50,10}})));
  Blocks.Math.Gain K1(k=Kp) annotation (Placement(transformation(
          extent={{-22,-10},{-2,10}})));
  Blocks.Math.Gain K2(k=1/Ti)   annotation (Placement(transformation(
          extent={{-10,-60},{10,-40}})));
  Blocks.Math.Add Summation annotation (Placement(transformation(
          extent={{60,-10},{80,10}})));
  Blocks.Continuous.Integrator IntegratorBlock
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
equation
  connect(command, Difference.u1) annotation (Line(points={{-120,0},{
          -68,0}}));
  connect(sensor, Difference.u2)
    annotation (Line(points={{-120,-60},{-60,-60},{-60,-8}}));
  connect(Difference.y, K1.u)
    annotation (Line(points={{-51,0},{-32,0},{-24,0}}));
  connect(K1.y, Summation.u1) annotation (Line(points={{-1,0},{50,0},
          {50,6},{58,6}}));
  connect(K1.y, K2.u)
    annotation (Line(points={{-1,0},{10,0},{10,-30},{-30,-30},{-30,
          -50},{-12,-50}}));
  connect(IntegratorBlock.y, Summation.u2)
    annotation (Line(points={{41,-50},{50,-50},{50,-6},{58,-6}}));
  connect(Summation.y, driver)
    annotation (Line(points={{81,0},{81,0},{110,0}}));
  connect(K2.y, IntegratorBlock.u)
    annotation (Line(points={{11,-50},{18,-50}}, color={0,0,255}));
end PIController;
