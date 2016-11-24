within FirstBookExamples;
package Icons
  class BookExample
    annotation (
      Icon(graphics={
          Ellipse(
            extent={{-100,100},{-60,80}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillPattern=FillPattern.Sphere,
            fillColor={160,160,164}),
          Rectangle(
            extent={{-100,88},{-62,-90}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={160,160,164}),
          Ellipse(
            extent={{-100,-80},{-60,-100}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-80,-80},{60,-100}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-100,90},{-100,-88}},
            color={0,0,0},
            thickness=0.5),
          Line(points={{-96,-84},{56,-84}}, color={192,192,192}),
          Line(points={{-98,-88},{56,-88}}, color={192,192,192}),
          Line(points={{-100,-92},{56,-92}}, color={192,192,192}),
          Line(points={{-96,-96},{56,-96}}, color={192,192,192}),
          Ellipse(
            extent={{50,-80},{70,-100}},
            lineColor={128,128,128},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{100,100},{62,-100}},
            lineColor={255,255,255},
            lineThickness=1,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-80,-100},{60,-100}},
            color={0,0,0},
            thickness=0.5),
          Rectangle(
            extent={{-80,100},{60,-80}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,100},{-80,-80}}, color={0,0,0}),
          Line(
            points={{-80,100},{60,100},{60,-80},{-80,-80}},
            color={0,0,0},
            thickness=0.5),
          Text(
            extent={{-146,178},{126,106}},
            lineColor={255,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            textString=
                 "%name"),
          Line(
            points={{-100,90},{-100,-92}},
            color={0,0,0},
            thickness=0.5)}));
  end BookExample;

  model RunnableExample
    annotation (
      Icon(graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-84},{-80,34}}, color={0,0,0}),
          Line(points={{-80,-84},{80,-84}}, color={0,0,0}),
          Line(points={{-80,-44},{-60,-44},{-58,-36},{-52,-30},{-44,
                -28},{-38,-32},{-34,-38},{-30,-40},{-28,-40},{-24,-38},
                {-20,-26},{-16,-12},{-12,8},{-6,12},{0,6},{0,4},{4,-8},
                {6,-24},{6,-26},{8,-40},{10,-58},{16,-70},{26,-70},{
                32,-64},{36,-52},{38,-46},{44,-42},{54,-40},{62,-42},
                {64,-46},{66,-46},{72,-46},{74,-44},{80,-44}}, color=
                {0,0,0}),
          Text(extent={{-96,90},{96,50}}, textString=
                                              "%name"),
          Polygon(
            points={{88,-84},{68,-76},{68,-92},{88,-84}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-80,44},{-88,24},{-72,24},{-80,44}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}));

  end RunnableExample;
  annotation (
    Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid), Text(extent={{-100,40},{100,
              -40}}, textString =                 "Icons")}));
end Icons;
