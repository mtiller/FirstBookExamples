within FirstBookExamples.Thermal;
package BoundaryConditions
  extends Modelica.Icons.Library;
  model FixedTemperature "Fixed temperature boundary condition"
    parameter Modelica.SIunits.Temperature T;
    Interfaces.Node_a n annotation (Placement(transformation(extent={
              {-110,-10},{-90,10}}, rotation=0)));
  equation
    n.T = T;
    annotation (
      Icon(graphics={
          Rectangle(
            extent={{-100,80},{100,-80}},
            lineColor={28,108,200},
            pattern=LinePattern.None,
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,80},{-20,-80}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={160,160,164},
            fillPattern=FillPattern.Forward),
          Text(
            extent={{-20,40},{100,0}},
            lineColor={0,0,0},
            textString=
                 "T=%T"),
          Line(
            points={{-20,80},{-20,-80}},
            color={0,0,0},
            thickness=1),
          Line(
            points={{80,0},{-18,0},{-20,0}},
            color={0,0,0},
            arrow={Arrow.None,Arrow.Filled}),
          Text(extent={{-100,122},{100,80}}, textString=
                                                 "%name")}),
      Documentation(info=" "));
  end FixedTemperature;

  model VariableTemperature "Variable temperature boundary condition"
    Modelica.Blocks.Interfaces.RealInput T(final n=1) annotation (Placement(
          transformation(extent={{120,-10},{100,10}}, rotation=0)));
    Interfaces.Node_a n annotation (Placement(transformation(extent={
              {-110,-10},{-90,10}}, rotation=0)));
  equation
    n.T = T.signal[1];
    annotation (
      Icon(graphics={
          Rectangle(
            extent={{-100,80},{100,-80}},
            lineColor={28,108,200},
            pattern=LinePattern.None,
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,80},{-20,-80}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={160,160,164},
            fillPattern=FillPattern.Forward),
          Text(
            extent={{56,24},{100,-22}},
            lineColor={0,0,0},
            textString=
                 "T="),
          Line(points={{-100,80},{-100,-80}}, color={0,0,0}),
          Line(
            points={{64,0},{-20,0}},
            color={0,0,0},
            arrow={Arrow.None,Arrow.Filled}),
          Line(
            points={{-20,80},{-20,-80}},
            color={0,0,0},
            thickness=1),
          Text(extent={{-100,122},{100,80}}, textString=
                                                 "%name")}),
      Documentation(info="This model represents a variable temperature boundary condition.  The temperature value is given by the input
connector to the model.  The effect is that an instance of this model acts as an infinite reservoir able to
absorb or generate as much energy as required to keep the temperature at the specified value.
"));
  end VariableTemperature;

  model PrescribedHeatFlux "Prescribed heat flux"
    Modelica.SIunits.Area A=1.0;
    Modelica.Blocks.Interfaces.RealInput q(final n=1) annotation (Placement(
          transformation(
          origin={110,0},
          extent={{-10,-10},{10,10}},
          rotation=180)));
    Interfaces.Node_a n annotation (Placement(transformation(extent={
              {-110,-10},{-90,10}}, rotation=0)));
  equation
    n.q = A*q.signal[1];
    annotation (
      Icon(graphics={
          Rectangle(
            extent={{-100,80},{100,-80}},
            lineColor={28,108,200},
            pattern=LinePattern.None,
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,80},{-20,-80}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={160,160,164},
            fillPattern=FillPattern.Forward),
          Line(
            points={{-20,80},{-20,-80}},
            color={0,0,0},
            thickness=1),
          Line(
            points={{64,0},{-20,0}},
            color={0,0,0},
            arrow={Arrow.None,Arrow.Filled}),
          Text(
            extent={{56,24},{100,-22}},
            lineColor={0,0,0},
            textString=
                 "q="),
          Text(extent={{-100,122},{100,80}}, textString=
                                                 "%name")}),
      Documentation(info="This model allows a specified amount of heat to be \"injected\" into a thermal system at a given node.  The amount of heat
is given by the input connector attached to the model.
"));
  end PrescribedHeatFlux;
end BoundaryConditions;
