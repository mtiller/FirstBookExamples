within FirstBookExamples.SimpleCar;
package Engine "Engine models and components"
  extends Modelica.Icons.Package;

  package GasProperties "Gas property related definitions"
    partial model BasePropertyModel "Basic property model interface"
      input Modelica.SIunits.Pressure P "Gas pressure";
      input Modelica.SIunits.Temperature T "Gas temperature";
      Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy of gas";
      Modelica.SIunits.SpecificEnergy u "Specific energy of gas";
      Real gamma "ratio of specific heats";
      Modelica.SIunits.MolarMass mw "Molecular weight of gas";
      annotation (
        Documentation(info="This interface defines the relationship between the state of a gas (pressure and temperature)
and the intensive properties of the gas (specific enthalpy, specific energy).  This is a generic
interface that should be implemented with four equations.  The equations will generally compute
the intensive properties of the gas directly from the state but it could be used \"in reverse\" to
compute pressure and temperature based on two intensive properties.
"));
    end BasePropertyModel;

    model SimpleAirProperties "Very simple air properties"
      extends BasePropertyModel;
      parameter Modelica.SIunits.SpecificHeatCapacity cp=1039
        "Specific heat capacity at constant pressure";
      parameter Modelica.SIunits.MolarMass mole_weight=0.028964
        "Molecular weight";
    protected
      parameter Modelica.SIunits.SpecificHeatCapacity cv=cp - (Modelica.
          Constants.R/mole_weight);
    equation
      h = cp*T;
      u = cv*T;
      mw = mole_weight;
      gamma = cp/cv;
      annotation (
        Documentation(info="This property model assumes the gas is a perfect gas with the properties of air at room temperature.
This is an overly simplified model of air but sufficient for demonstrating the basics of engine
thermodynamics.
"));
    end SimpleAirProperties;
  end GasProperties;

  model GeometrySource "Engine geometry specification"
    parameter Modelica.SIunits.Length bore "Engine bore";
    parameter Modelica.SIunits.Length stroke "Engine stroke";
    parameter Modelica.SIunits.Length conrod "Connecting rod length";
    parameter Real comp_ratio=9.5 "Compression ratio";
    Interfaces.EngineGeometryProvided geom annotation (Placement(
          transformation(
          origin={-110,0},
          extent={{-10,-10},{10,10}},
          rotation=180)));
  equation
    assert(bore > 0, "Invalid bore value");
    assert(stroke > 0, "Invalid stroke value");
    assert(conrod > 0, "Invalid connecting rod length");
    assert(comp_ratio > 1, "Invalid compression ratio");
    geom.bore = bore;
    geom.stroke = stroke;
    geom.conrod = conrod;
    geom.Vc = geom.Vd/(comp_ratio - 1);
    geom.Ap = Modelica.Constants.pi*(bore/2)^2;
    geom.Vd = stroke*geom.Ap;
    geom.crank = stroke/2.0;
    annotation (
      Icon(graphics={
          Polygon(
            points={{-60,-100},{-60,40},{-42,40},{-42,44},{-40,46},{
                -60,60},{-100,60},{-100,-100},{-60,-100}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-58,12},{58,-64}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={192,192,192}),
          Rectangle(
            extent={{-60,6},{60,0}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-60,-8},{60,-14}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-60,-20},{60,-26}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-58,-64},{-40,-52},{40,-52},{58,-64},{-58,-64}},
            lineColor={28,108,200},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-4,-34},{4,-42}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-42,44},{-18,40}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={192,192,192}),
          Polygon(
            points={{-42,44},{-40,46},{-20,46},{-18,44},{-42,44}},
            lineColor={160,160,164},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-32,46},{-28,94}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={192,192,192}),
          Polygon(
            points={{18,44},{20,46},{40,46},{42,44},{18,44}},
            lineColor={160,160,164},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{18,44},{42,40}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={192,192,192}),
          Rectangle(
            extent={{28,46},{32,96}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={192,192,192}),
          Polygon(
            points={{100,-100},{100,60},{60,60},{40,46},{42,44},{42,
                40},{60,40},{60,-100},{100,-100}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-100,96},{-60,96},{-40,80},{-20,60},{-20,46},{
                -18,44},{-18,40},{18,40},{18,44},{20,46},{20,60},{40,
                80},{60,96},{100,96},{100,100},{-100,100},{-100,96}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(extent={{-60,-66},{60,-100}}, textString=
                                                 "%name")}),
      Documentation(info="This model takes basic engine geometry parameters and computes the complete
set of engine geometry characteristics.
"));
  end GeometrySource;

  model SportsCarGeometry "Geometry of a sports car with an I4 engine"
    extends GeometrySource(
      bore=0.09604,
      stroke=0.0794,
      comp_ratio=9.5,
      conrod=0.157);
    annotation (
      Documentation(info="This model has default engine geometry parameters that would be typical of a sports car.
"));
  end SportsCarGeometry;

  package Components "A collection of components used to build engines"
    extends Modelica.Icons.Package;

    replaceable model PropertyModel =
        GasProperties.SimpleAirProperties;
    model ChamberVolume
      "Computes combustion chamber volume as a function of piston position"

      Modelica.Mechanics.Translational.Interfaces.Flange_a piston annotation (Placement(
            transformation(extent={{-10,-90},{10,-70}})));
      Modelica.Blocks.Interfaces.RealOutput volume annotation (Placement(
            transformation(
            origin={-110,0},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Interfaces.EngineGeometryRequired geom annotation (Placement(
            transformation(
            origin={110,0},
            extent={{-10,-10},{10,10}},
            rotation=180)));
    equation
      volume = geom.Vc + geom.Ap*piston.s;
      piston.f = 0;
      annotation (
        Icon(graphics={
            Polygon(
              points={{-60,-100},{-60,40},{-42,40},{-42,44},{-40,46},
                  {-60,60},{-100,60},{-100,-100},{-60,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Forward),
            Polygon(
              points={{-100,96},{-60,96},{-40,80},{-20,60},{-20,46},{
                  -18,44},{-18,40},{18,40},{18,44},{20,46},{20,60},{
                  40,80},{60,96},{100,96},{100,100},{-100,100},{-100,
                  96}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Forward),
            Rectangle(
              extent={{-58,12},{58,-64}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={192,192,192}),
            Rectangle(
              extent={{-60,6},{60,0}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-60,-8},{60,-14}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-60,-20},{60,-26}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-58,-64},{-40,-52},{40,-52},{58,-64},{-58,-64}},
              lineColor={28,108,200},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-4,-34},{4,-42}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-42,36},{-18,32}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={192,192,192}),
            Polygon(
              points={{-42,36},{-40,38},{-20,38},{-18,36},{-42,36}},
              lineColor={160,160,164},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-32,38},{-28,96}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={192,192,192}),
            Polygon(
              points={{18,44},{20,46},{40,46},{42,44},{18,44}},
              lineColor={160,160,164},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{18,44},{42,40}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={192,192,192}),
            Rectangle(
              extent={{28,46},{32,96}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={192,192,192}),
            Polygon(
              points={{100,-100},{100,60},{60,60},{40,46},{42,44},{42,
                  40},{60,40},{60,-100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Forward),
            Text(extent={{-58,126},{60,94}}, textString=
                                                 "%name")}),
        Documentation(info="This model is used to compute the combustion chamber volume as a function
of piston position.  The has connectors for providing engine geometry
characteristics and the piston position and computes the chamber volume
as an output signal.

Note that this model does not really interact with the piston because it
does not result in any force being applied to the piston.  It is important
when creating models that are \"read-only\" for a given domain (e.g. the
translational domain in the case of the piston position) that a zero
contribution be provided for any flow variables.
"));
    end ChamberVolume;

    model ControlVolume "Thermodynamic control volume"

      Modelica.SIunits.Energy U(start=147) "Total energy";
      Modelica.SIunits.Mass m(start=4e-4) "Total mass";
      Modelica.SIunits.Pressure P(start=101800) = state.P "Pressure";
      Modelica.SIunits.Temperature T(start=300) = state.T "Temperature";
      Modelica.SIunits.MassFlowRate mdot=state.mdot "Net mass flow";
      Modelica.SIunits.Power q=state.q "Net power";
      Modelica.SIunits.Volume V=volume "Chamber volume";
      Modelica.SIunits.AmountOfSubstance N "Number of moles of gas";
      Real R=Modelica.Constants.R;
      Real logV;
      Real logP;

      Modelica.Blocks.Interfaces.RealInput volume annotation (Placement(
            transformation(
            origin={110,0},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Modelica.Blocks.Interfaces.RealOutput mass annotation (Placement(
            transformation(
            origin={-60,110},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Interfaces.Gas state "Gas state" annotation (Placement(transformation(extent={{-10,-10},{
                10,10}})));
    protected
      PropertyModel props(T=T, P=P) annotation (Placement(
            transformation(extent={{-80,40},{-40,80}})));
    equation
      // Compute number of moles
      N = m/props.mw;

      // Ideal gas low
      P*V = N*R*T;

      // First law of thermodynamics
      der(U) = q - P*der(V);
      U = m*props.u;

      // Conservation of mass
      der(m) = mdot;
      mass = m;
      logV = Modelica.Math.log(V);
      logP = Modelica.Math.log(P);
      annotation (
        Icon(graphics={
            Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,0}),
            Ellipse(
              extent={{14,46},{18,50}},
              lineColor={0,127,255},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{16,48},{4,60},{-18,42}},
              color={0,0,0},
              pattern=LinePattern.Dot),
            Ellipse(
              extent={{52,20},{56,24}},
              lineColor={0,127,255},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-54,18},{-50,22}},
              lineColor={0,127,255},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{54,22},{60,14},{52,2}},
              color={0,0,0},
              pattern=LinePattern.Dot),
            Line(
              points={{-54,40},{-60,32},{-52,20}},
              color={0,0,0},
              pattern=LinePattern.Dot),
            Ellipse(
              extent={{0,18},{4,14}},
              lineColor={0,127,255},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{2,16},{-18,10}},
              color={0,0,0},
              pattern=LinePattern.Dot),
            Ellipse(
              extent={{-40,-42},{-36,-46}},
              lineColor={0,127,255},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-38,-44},{-34,-60},{-30,-34}},
              color={0,0,0},
              pattern=LinePattern.Dot),
            Ellipse(
              extent={{24,-24},{28,-28}},
              lineColor={0,127,255},
              pattern=LinePattern.Dot,
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{26,-26},{38,-52}},
              color={0,0,0},
              pattern=LinePattern.Dot),
            Text(extent={{-50,108},{80,80}}, textString=
                                                 "%name"),
            Polygon(
              points={{-80,68},{-80,80},{-60,60},{-60,-60},{60,-60},{
                  60,60},{-60,60},{-80,80},{80,80},{80,-80},{-80,-80},
                  {-80,68}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Backward)}),
        Documentation(info="This model contains the basic equations of a thermodynamic control volume.  These include the conservation of mass and energy
as well as the ideal gas law and gas property equations.  The volume of the control volume is an input to this model
and the current mass contained within the control volume is an output.  The output signal for mass is necessary to
connect a combustion model.
"));
    end ControlVolume;

    partial model Orifice "Isentropic flow restriction"
      parameter Modelica.SIunits.Area Aref "Reference Area";

     Interfaces.Gas a annotation (Placement(transformation(extent={{
                -110,-10},{-90,10}})));
     Interfaces.Gas b annotation (Placement(transformation(extent={{
                -10,-110},{10,-90}})));

    protected
      Modelica.SIunits.MassFlowRate mdot "Flow from 'a' to 'b'";
      Modelica.SIunits.SpecificEnthalpy h "Upstream enthalpy";
      Modelica.SIunits.SpecificEnthalpy gamma "Upstream gamma";
      Real pratio "Pressure ratio";
      Real Cd "Discharge Coefficient";
      PropertyModel a_props(T=a.T, P=a.P) annotation (Placement(
            transformation(extent={{-60,20},{-20,60}})));
      PropertyModel b_props(T=b.T, P=b.P) annotation (Placement(
            transformation(extent={{20,20},{60,60}})));
    equation
      a.mdot = mdot;
      b.mdot = -mdot;
      a.q = mdot*h;
      b.q = -mdot*h;
      if noEvent(a.P > b.P) then
        h = a_props.h;
        gamma = a_props.gamma;
        pratio = b.P/a.P;
        if noEvent(pratio <= (2.0/(gamma + 1.0))^(gamma/(gamma - 1.0))) then
          mdot = Cd*Aref*a.P/((Modelica.Constants.R/a_props.mw)*a.T)^0.5*gamma
            ^0.5*(2.0/(gamma + 1.0))^((gamma + 1.0)/(2.0*(gamma - 1.0)));
        else
          mdot = Cd*Aref*a.P/((Modelica.Constants.R/a_props.mw)*a.T)^0.5*
            pratio^(1.0/gamma)*(2.0*gamma/(gamma - 1.0)*(1.0 - pratio^((gamma
             - 1.0)/gamma)))^0.5;
        end if;
      else
        h = b_props.h;
        gamma = b_props.gamma;
        pratio = a.P/b.P;
        if noEvent(pratio <= (2.0/(gamma + 1.0))^(gamma/(gamma - 1.0))) then
          mdot = -Cd*Aref*b.P/((Modelica.Constants.R/b_props.mw)*b.T)^0.5*
            gamma^0.5*(2.0/(gamma + 1.0))^((gamma + 1.0)/(2.0*(gamma - 1.0)));
        else
          mdot = -Cd*Aref*b.P/((Modelica.Constants.R/b_props.mw)*b.T)^0.5*
            pratio^(1.0/gamma)*(2.0*gamma/(gamma - 1.0)*(1.0 - pratio^((gamma
             - 1.0)/gamma)))^0.5;
        end if;
      end if;
      annotation (
        Documentation(info="This is a base model for other models which model isentropic flow (e.g. throttles, engine valves)
"));
    end Orifice;

    model Throttle "Orifice with throttle plate"
      extends Orifice(final Aref=Modelica.Constants.pi*(dia/2)^2);

      parameter Modelica.SIunits.Diameter dia=0.1 "Throttle diameter";
      Modelica.Blocks.Interfaces.RealInput throttle_angle
        "Throttle Angle [deg]" annotation (Placement(transformation(
            origin={0,110},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      Cd = Modelica.Math.sin(throttle_angle*Modelica.Constants.
        pi/180)^2;
      annotation (
        Icon(graphics={
            Rectangle(
              extent={{-60,80},{60,-80}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={192,192,192}),
            Line(
              points={{30,32},{-30,-28}},
              color={0,0,0},
              thickness=0.5),
            Ellipse(
              extent={{-6,8},{6,-4}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(extent={{20,100},{100,80}}, textString=
                                                 "%name")}),
        Documentation(info="A very simple engine throttle.  The input signal is the throttle angle.
"));
    end Throttle;

    model Valve "Engine poppet valve"
      extends Orifice(final Aref=Modelica.Constants.pi*(dia/2)^2);

      parameter Modelica.SIunits.Diameter dia=0.012 "Valve diameter";
      parameter Modelica.SIunits.Length max_lift=0.012 "Maximum Valve Lift";
      parameter Real max_discharge=0.7 "Maximum Discharge Coefficient";

     Modelica.Mechanics.Translational.Interfaces.Flange_a lift annotation (Placement(
            transformation(extent={{-10,90},{10,110}})));

    protected
      parameter Real c_over_l=max_discharge/max_lift;

    equation
      lift.f = 0;
      Cd = c_over_l*lift.s;
      // Cd = 0.0;
      annotation (
        Icon(graphics={
            Rectangle(
              extent={{-40,-60},{40,-70}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={192,192,192}),
            Polygon(
              points={{-40,-60},{-28,-52},{30,-52},{40,-60},{-40,-60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={160,160,164}),
            Rectangle(
              extent={{-10,90},{10,-52}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={192,192,192}),
            Polygon(
              points={{-40,-54},{-28,-46},{-28,-40},{-40,-30},{-60,
                  -16},{-100,-16},{-100,-100},{-60,-100},{-60,-70},{
                  -60,-58},{-40,-58},{-40,-54}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Forward),
            Polygon(
              points={{-100,40},{-60,40},{-10,16},{-10,100},{-100,100},
                  {-100,40}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Forward),
            Polygon(
              points={{10,6},{20,0},{30,-40},{30,-46},{40,-54},{40,
                  -58},{60,-58},{60,-100},{100,-100},{100,100},{10,
                  100},{10,6}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Forward),
            Text(extent={{12,64},{100,44}}, textString=
                                                "%name")}),
        Documentation(info="This is a very simple model of an engine valve the is derived from the \"Orifice\" model of isentropic flow.
The valve model must be connected to two different gas volumes (or reservoirs).  In addition, a translational
connector is used to represent the lift of the valve.
"));
    end Valve;

    model MasslessPiston "A massless piston"
      parameter Modelica.SIunits.Pressure Pcc=101800 "Crankcase pressure";
      Interfaces.EngineGeometryRequired geom annotation (Placement(
            transformation(
            origin={110,0},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Interfaces.Gas chamber annotation (Placement(transformation(
              extent={{-10,90},{10,110}})));
      Modelica.Mechanics.Translational.Interfaces.Flange_a piston annotation (Placement(
            transformation(extent={{-10,-32},{10,-12}})));
    equation
      piston.f = geom.Ap*(chamber.P - Pcc);
      chamber.mdot = 0;
      chamber.q = 0;

      annotation (
        Icon(graphics={
            Rectangle(
              extent={{-94,90},{94,-100}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={192,192,192}),
            Rectangle(
              extent={{-100,80},{100,74}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-100,42},{100,36}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-100,60},{100,54}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-94,-100},{-60,-58},{60,-58},{94,-100},{-94,
                  -100}},
              lineColor={28,108,200},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-20,-2},{20,-42}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(extent={{-40,-70},{42,-90}}, textString=
                                                  "%name")}),
        Documentation(info="This piston is used to translate pressure inside the cylinder into force (presumably applied to the crank slider mechanism).
This piston has no mass.
"));
    end MasslessPiston;

    model OffsetShaft "Angular displacement"
      parameter Types.Degrees shift=0 "Shift from crankshaft";
      Types.RPM shaft_speed;
      Modelica.Mechanics.Rotational.Interfaces.Flange_a crank annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_b cyl annotation (Placement(
            transformation(extent={{-10,-110},{10,-90}})));
    equation
      shaft_speed = 30*der(crank.phi)/Modelica.Constants.pi;
      crank.tau + cyl.tau = 0;
      cyl.phi = crank.phi + shift*Modelica.Constants.pi/180.0;
      annotation (
        Icon(graphics={
            Rectangle(
              extent={{-90,10},{-40,-10}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Rectangle(
              extent={{-40,10},{-20,-80}},
              lineColor={160,160,164},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-20,-40},{20,-80}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Rectangle(
              extent={{20,10},{40,-80}},
              lineColor={160,160,164},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{40,10},{90,-10}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Text(extent={{-40,40},{40,20}}, textString=
                                                "%name")}),
        Documentation(info="Each cylinder is shifted on that crank shaft.  This model enforces an angular displacement from one flange to another
so that each cylinder can be rigidly connected to the crankshaft by independently shifted.
"));
    end OffsetShaft;

    model CrankSlider "A crank slider mechanism"
    protected
      Modelica.SIunits.Length d;
      Modelica.SIunits.Angle phi;
      Real cp;
      Real sp;
    public
      Interfaces.EngineGeometryRequired geom annotation (Placement(
            transformation(
            origin={110,0},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a crank annotation (Placement(
            transformation(extent={{-10,-50},{10,-30}})));
      Modelica.Mechanics.Translational.Interfaces.Flange_a piston annotation (Placement(
            transformation(extent={{-10,90},{10,110}})));
    equation
      assert(geom.conrod > geom.crank,
        "Connecting rod length greater than crank length");
      cp = Modelica.Math.cos(phi);
      sp = Modelica.Math.sin(phi);
      phi = crank.phi;
      d = sqrt(geom.conrod^2 - (geom.crank*sp)^2);
      piston.s = (geom.crank + geom.conrod) - (geom.crank*cp + sqrt(geom.
        conrod^2 - geom.crank^2*sp^2));
      crank.tau = piston.f*(sp*geom.crank + cp*sp*geom.crank^2/sqrt(d));
      annotation (
        Icon(graphics={
            Polygon(
              points={{-18,-40},{-46,-44},{-50,-60},{-20,-90},{-4,-86},
                  {0,-60},{-18,-40}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-18,118},{18,82}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-14,114},{14,86}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{0,14},{54,-38}},
              lineColor={192,192,192},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{12,-26},{42,4}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-30,-10},{30,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-16,92},{2,-20},{50,2},{18,102},{12,88},{4,84},
                  {-8,86},{-16,92}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-6,-14},{20,0},{38,-18},{24,-46},{18,-26},{-6,
                  -18},{-6,-14}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{12,-26},{42,4}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{18,106},{20,68},{32,26},{58,-10},{72,70},{34,
                  102},{18,106}},
              lineColor={28,108,200},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-20,102},{-4,64},{4,20},{0,-8},{-28,14},{-20,
                  102}},
              lineColor={28,108,200},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(extent={{-62,-100},{66,-120}}, textString=
                                                    "%name")}),
        Documentation(info="This model represents the crank slider mechanism used to turn translational
force into the rotational torque applied to the crankshaft.
"));
    end CrankSlider;

    model SparkControl "Spark plug control"
      parameter Types.Degrees spark_advance=20 "Before top-dead-center (TDC)";

      Modelica.Blocks.Interfaces.BooleanOutput spark annotation (Placement(
            transformation(extent={{100,-10},{120,10}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a crank annotation (Placement(
            transformation(extent={{-10,-110},{10,-90}})));
    protected
      Types.Degrees cur_pos;
      Types.Degrees next_spark;
    equation
      crank.tau = 0;
      cur_pos = crank.phi*180/Modelica.Constants.pi;
    algorithm
      when initial() then
        next_spark := -spark_advance;
        while (next_spark < cur_pos) loop
          next_spark := next_spark + 720;
        end while;
      end when;
      spark := cur_pos > next_spark;
      when spark then
        next_spark := next_spark + 720;
      end when;
      annotation (
        Icon(graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={28,108,200},
              fillColor={223,223,159},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-20,60},{14,-20}},
              lineColor={0,0,0},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{14,-20},{14,-46},{-6,-50},{-6,-44},{8,-42},{8,
                  -20},{14,-20}},
              lineColor={0,0,0},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-8,-24},{-34,-46},{-14,-36},{-20,-54},{-6,-36},
                  {0,-58},{2,-36},{16,-56},{12,-36},{40,-52},{6,-24},
                  {4,-26},{-4,-26},{-8,-24}},
              lineColor={255,127,0},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Line(points={{60,0},{100,0}}, color={255,0,255}),
            Text(extent={{-64,120},{56,100}}, textString=
                                                  "Spark Controller"),
            Text(extent={{-88,-50},{96,-88}}, textString=
                "Timing: %spark_advance [deg] before TDC")}),
        Documentation(info="This model triggers the firing of the spark plug when the piston reaches a prescribed number of degrees
before top dead center of the compression/combustion strokes.  A real spark control strategy would allow
the spark strategy to change as engine conditions changed but this model just assumes a fixed
\"spark advance\".
"));
    end SparkControl;

    model TimingBelt "Engine timing belt"
      Modelica.Mechanics.Rotational.Interfaces.Flange_a crankshaft annotation (Placement(
            transformation(extent={{-10,-90},{10,-70}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_b camshaft annotation (Placement(
            transformation(extent={{-10,50},{10,70}})));
    equation
      2*camshaft.phi = crankshaft.phi;
      camshaft.tau = 2*crankshaft.tau;
      annotation (
        Icon(graphics={
            Ellipse(
              extent={{-40,100},{40,20}},
              lineColor={0,0,0},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{20,-100},{-20,-60}},
              lineColor={0,0,0},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-20,-82},{-40,56}},
              color={192,192,192},
              thickness=1),
            Line(
              points={{-40,56},{-20,-82}},
              color={0,0,0},
              pattern=LinePattern.Dash),
            Line(
              points={{40,56},{20,-82}},
              color={192,192,192},
              thickness=1),
            Line(
              points={{40,54},{20,-82}},
              color={0,0,0},
              pattern=LinePattern.Dash),
            Text(extent={{-60,0},{60,-20}}, textString=
                                                "%name")}),
        Documentation(info="A timing belt that makes sure the camshaft spins at half the frequency as the crank shaft.
"));
    end TimingBelt;

    model Combustion "Simple combustion model"
      parameter Modelica.SIunits.SpecificEnergy lhv=44e+6
        "Lower heating value";
      parameter Real afr=14.6 "Stoichiometric Air/Fuel Ratio";
      parameter Types.Degrees burn_duration=60 "Duration of combustion";
    protected
      Modelica.SIunits.Energy amplitude;
      Modelica.SIunits.AngularVelocity w;
      Real dps;
      Modelica.SIunits.Time start_burn(start=-1);
      Modelica.SIunits.Time end_burn(start=-1);
      Boolean burning(start=false);
      Real tmp;
    public
      Interfaces.Gas cylinder annotation (Placement(transformation(
              extent={{-10,-50},{10,-30}})));
      Modelica.Blocks.Interfaces.RealInput mass annotation (Placement(
            transformation(
            origin={-60,-110},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Blocks.Interfaces.BooleanInput start annotation (Placement(
            transformation(
            origin={0,110},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a crank annotation (Placement(
            transformation(extent={{-110,-50},{-90,-30}})));
    equation
      assert(burn_duration > 1, "Invalid burn duration");
      cylinder.mdot = 0;
      cylinder.q = if (burning) then -amplitude*Modelica.Math.sin((time -
        start_burn)/(end_burn - start_burn)*Modelica.Constants.pi)^2 else 0.0;
      der(tmp) = cylinder.q;
      w = der(crank.phi);
      dps = w*180/Modelica.Constants.pi;
      crank.tau = 0;
    algorithm
      when start then
        start_burn := time;
        end_burn := time + (burn_duration/dps);
        amplitude := lhv*(mass/(afr + 1))*2.0*dps/burn_duration;
        burning := true;
      end when;
      when time >= end_burn then
        burning := false;
      end when;
      annotation (
        Icon(graphics={
            Rectangle(
              extent={{-8,40},{8,10}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={192,192,192}),
            Polygon(
              points={{4,10},{4,2},{-2,2},{-2,0},{6,0},{6,10},{4,10}},
              lineColor={0,0,0},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-2,10},{2,6}},
              lineColor={0,0,0},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-12,4},{-6,-2},{8,-2},{14,4},{22,4},{16,0},{20,
                  -6},{12,-6},{10,-12},{6,-6},{4,-18},{0,-8},{-6,-14},
                  {-6,-6},{-16,-8},{-12,-2},{-20,2},{-12,4}},
              lineColor={255,255,0},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-20,2},{-26,2},{-16,-2},{-20,-12},{-8,-10},{
                  -10,-20},{-2,-16},{6,-26},{8,-16},{12,-18},{16,-10},
                  {26,-8},{22,-2},{30,4},{22,4},{16,0},{20,-6},{12,-6},
                  {10,-12},{6,-8},{4,-18},{0,-8},{-6,-14},{-6,-6},{
                  -14,-8},{-12,-2},{-20,2}},
              lineColor={255,0,0},
              fillColor={255,127,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-80,-80},{-80,-20},{-28,0},{-28,10},{-8,10},{
                  -8,40},{-92,40},{-92,-80},{-80,-80}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Forward),
            Polygon(
              points={{8,40},{8,10},{32,10},{32,0},{80,-20},{80,-80},
                  {90,-80},{90,40},{8,40},{8,10},{8,40}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Forward),
            Line(points={{0,112},{0,40}}, color={255,0,255}),
            Text(extent={{-60,-80},{60,-100}}, textString=
                                                   "%name")}),
        Documentation(info="This is a simplified combustion models.  This
model works by computing an instantaneous heat
release (i.e. energy given off as a result
of combustion) based on an idealized combustion
transient.  The duration of the burning is
typically determined by the motion of the
fuel/air mixture inside the cylinder but in
the case of this model it is assumed that
the burn duration is a fixed parameter.
"));
    end Combustion;

    model Dynamometer "Ideal Dynamometer"
      parameter Real cycle_fraction=1.0
        "Average over what fraction of the cycle";
      Modelica.SIunits.Energy work;
      Modelica.SIunits.Energy last_work;
      Modelica.SIunits.Torque avg_tau;
      Modelica.SIunits.Angle next_rotation;
      Types.RPM avg_rpm;
      Modelica.SIunits.Time previous_time;

      Modelica.Blocks.Interfaces.RealInput rpm annotation (Placement(
            transformation(extent={{-120,-10},{-100,10}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
    equation
      der(shaft.phi) = rpm*Modelica.Constants.pi/30;
      der(work) = shaft.tau*der(shaft.phi);
    algorithm
      when initial() then
        next_rotation := shaft.phi + cycle_fraction*4*Modelica.Constants.pi;
        last_work := 0;
        previous_time := time;
        avg_rpm := rpm;
      end when;
      when shaft.phi > next_rotation then
        next_rotation := next_rotation + cycle_fraction*4*Modelica.Constants.
          pi;
        avg_tau := (work - pre(last_work))/(cycle_fraction*4*Modelica.
          Constants.pi);
        avg_rpm := 120*cycle_fraction/(time - pre(previous_time));
        last_work := work;
        previous_time := time;
      end when;
      annotation (
        Icon(graphics={
            Rectangle(
              extent={{60,10},{90,-10}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Rectangle(
              extent={{-40,60},{40,-60}},
              lineColor={0,0,0},
              pattern=LinePattern.Solid,
              lineThickness=0.25,
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Polygon(
              points={{-60,10},{-60,20},{-40,40},{-40,-40},{-60,-20},
                  {-60,10}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={128,128,128}),
            Polygon(
              points={{60,20},{40,40},{40,-40},{60,-20},{60,20}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-60,-90},{-50,-90},{-20,-30},{20,-30},{48,-90},
                  {60,-90},{60,-100},{-60,-100},{-60,-90}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Line(points={{-112,0},{-60,0}}),
            Text(extent={{-80,100},{80,60}}, textString=
                                                 "Dynamometer")}),
        Documentation(info="This dynamometer model is ideal.  This means that the dynamometer appear (to anything connected to it) to have
an infinite mass.  It is important that the input signal is continuous.  Furthermore the input signal has units
of \"revolutions per minute\".
"));
    end Dynamometer;

    model IndividualCylinder
      "Collection of parts for a complete individual cylinder"
      extends Interfaces.Cylinder;
      parameter Types.Degrees spark_advance "Spark advance";
      parameter Types.Degrees burn_duration "Burn Duration";
      parameter Types.Degrees evo=40 "Exhaust Valve Opening";
      parameter Types.Degrees ivo=150 "Intake Valve Opening";
      parameter Types.Degrees evc=205 "Exhaust Valve Closing";
      parameter Types.Degrees ivc=310 "Intake Valve Closing";
      parameter Types.Degrees crank_shift=0 "Crankshaft Shift";
      parameter Modelica.SIunits.Diameter ivd=0.032 "Intake Valve Diameter";
      parameter Modelica.SIunits.Diameter evd=0.028 "Exhaust Valve Diameter";
      Engine.Components.MasslessPiston piston annotation (Placement(
            transformation(extent={{-10,-50},{10,-30}})));
      Engine.Components.CrankSlider crankslider annotation (Placement(
            transformation(extent={{-20,-120},{20,-80}})));
      Engine.Components.ControlVolume combustion_chamber annotation (Placement(
            transformation(extent={{-10,-20},{10,0}})));
      Engine.Components.Valve intake_valve(dia=ivd) annotation (Placement(
            transformation(extent={{-40,20},{-20,40}})));
      Engine.Components.Valve exhaust_valve(dia=evd) annotation (Placement(
            transformation(extent={{40,20},{20,40}})));
      Engine.Components.TimingBelt timing_belt annotation (Placement(
            transformation(extent={{-100,-60},{-60,-20}})));
      Engine.Components.Cam intake_cam(vo=ivo, vc=ivc) annotation (Placement(
            transformation(extent={{-60,60},{-40,80}})));
      Engine.Components.Cam exhaust_cam(vo=evo, vc=evc) annotation (Placement(
            transformation(extent={{60,60},{40,80}})));
      Engine.Components.Combustion combustion_model(burn_duration=
            burn_duration) annotation (Placement(transformation(
              extent={{-10,20},{10,40}})));
      Engine.Components.SparkControl spark_control(spark_advance=spark_advance)
          annotation (Placement(transformation(extent={{-24,44},{-4,
                64}})));
      Engine.Components.ChamberVolume chamber_volume annotation (Placement(
            transformation(extent={{56,-20},{76,0}})));
      OffsetShaft offset_shaft(shift=crank_shift) annotation (Placement(
            transformation(extent={{-20,-140},{20,-180}})));
    equation
      connect(crankslider.geom, geom) annotation (Line(points={{22,
              -100},{80,-100},{80,-40},{80,-50},{110,-50}}, color={0,
              0,0}));
      connect(chamber_volume.geom, geom) annotation (Line(points={{77,
              -10},{80,-10},{80,-40},{80,-50},{110,-50}}, color={0,0,
              0}));
      connect(intake_valve.a, intake) annotation (Line(points={{-40,
              30},{-80,30},{-100,30},{-100,80}}, color={255,127,0}));
      connect(exhaust_valve.a, exhaust) annotation (Line(points={{40,
              30},{80,30},{80,80},{100,80}}, color={255,127,0}));
      connect(piston.chamber, combustion_chamber.state) annotation (Line(
            points={{5.55112e-16,-30},{5.55112e-16,-10}}, color={255,
              127,0}));
      connect(intake_cam.valve_lift, intake_valve.lift) annotation (Line(
            points={{-40,70},{-30,70},{-30,40}}, color={0,255,0}));
      connect(exhaust_cam.valve_lift, exhaust_valve.lift) annotation (Line(
            points={{40,70},{30,70},{30,40}}, color={0,255,0}));
      connect(intake_cam.camshaft, timing_belt.camshaft) annotation (Line(
            points={{-52.8,70},{-80,70},{-80,-28}}, color={160,160,
              164}));
      connect(exhaust_cam.camshaft, timing_belt.camshaft) annotation (Line(
            points={{52.8,70},{68,70},{68,80},{-80,80},{-80,-28}},
            color={160,160,164}));
      connect(intake_valve.b, combustion_chamber.state) annotation (Line(
            points={{-30,20},{5.55112e-16,-10}}, color={255,127,0}));
      connect(combustion_chamber.state, exhaust_valve.b) annotation (Line(
            points={{5.55112e-16,-10},{30,20}}, color={255,127,0}));
      connect(combustion_model.cylinder, combustion_chamber.state) annotation (Line(
            points={{5.55112e-16,26},{5.55112e-16,-10}}, color={255,
              127,0}));
      connect(combustion_model.crank, spark_control.crank) annotation (Line(
            points={{-10,26},{-14,26},{-14,44}}, color={160,160,164}));
      connect(spark_control.spark, combustion_model.start) annotation (Line(
            points={{-3,54},{0,54},{5.55112e-16,41}}, color={255,0,
              255}));
      connect(chamber_volume.volume, combustion_chamber.volume) annotation (Line(
            points={{55,-10},{11,-10}}));
      connect(combustion_chamber.mass, combustion_model.mass) annotation (Line(
            points={{-6,1},{-6,19}}));
      connect(piston.geom, geom) annotation (Line(points={{11,-40},{
              80,-40},{80,-50},{110,-50}}, color={0,0,0}));
      connect(piston.piston, crankslider.piston) annotation (Line(
            points={{0,-42.2},{0,-80}},
                                      color={0,255,127}));
      connect(chamber_volume.piston, crankslider.piston) annotation (Line(
            points={{66,-18},{66,-80},{0,-80}}, color={0,255,127}));
      connect(offset_shaft.cyl, crankslider.crank) annotation (Line(
            points={{0,-140},{0,-108}}, color={0,0,0}));
      connect(offset_shaft.crank, crankshaft) annotation (Line(points={{-20,
              -160},{-20,-198},{0,-198}},      color={0,0,0}));
      connect(timing_belt.crankshaft, crankslider.crank) annotation (Line(
            points={{-80,-56},{-80,-108},{1.11022e-15,-108}}, color={
              0,0,0}));
      connect(spark_control.crank, crankslider.crank) annotation (Line(
            points={{-14,44},{-14,-108},{0,-108}}, color={0,0,0}));
      annotation (
        Icon(graphics={
            Polygon(
              points={{-60,-140},{-60,40},{-42,40},{-42,44},{-40,46},
                  {-60,60},{-100,60},{-100,-140},{-60,-140}},
              lineColor={0,0,0},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-100,96},{-60,96},{-40,80},{-20,60},{-20,46},{
                  -18,44},{-18,40},{18,40},{18,44},{20,46},{20,60},{
                  40,80},{60,96},{100,96},{100,100},{-100,100},{-100,
                  96}},
              lineColor={0,0,0},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-58,12},{58,-64}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={192,192,192}),
            Rectangle(
              extent={{-60,6},{60,0}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-60,-8},{60,-14}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-60,-20},{60,-26}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-58,-64},{-40,-52},{40,-52},{58,-64},{-58,-64}},
              lineColor={28,108,200},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-4,-34},{4,-42}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(extent={{-40,-240},{40,-160}}, lineColor={192,192,
                  192}),
            Line(
              points={{0,-200},{30,-174},{0,-38}},
              color={0,0,0},
              thickness=1),
            Rectangle(
              extent={{-42,36},{-18,32}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={192,192,192}),
            Polygon(
              points={{-42,36},{-40,38},{-20,38},{-18,36},{-42,36}},
              lineColor={160,160,164},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-32,38},{-28,96}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={192,192,192}),
            Polygon(
              points={{18,44},{20,46},{40,46},{42,44},{18,44}},
              lineColor={160,160,164},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{18,44},{42,40}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={192,192,192}),
            Rectangle(
              extent={{28,46},{32,96}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={192,192,192}),
            Polygon(
              points={{100,-140},{100,60},{60,60},{40,46},{42,44},{42,
                  40},{60,40},{60,-140},{100,-140}},
              lineColor={0,0,0},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Text(extent={{-60,-100},{60,-120}}, textString=
                                                    "%name")}),
        Documentation(info="All the basic componets of a single cylinder, 2-valve engine
have been compiled in this model.
"));
    end IndividualCylinder;

    model Cam "Valvetrain cam"

      parameter Types.Degrees vo=40 "Valve Open";
      parameter Types.Degrees vc=205 "Valve Close";
      parameter Modelica.SIunits.Length max_lift=0.012 "Maximum valve lift";
      Types.Degrees local_ca "Local camshaft angle";
    protected
      parameter Real norm=1.0/(vc - vo);
    public
      Modelica.Mechanics.Rotational.Interfaces.Flange_a camshaft annotation (Placement(
            transformation(extent={{-38,-10},{-18,10}})));
      Modelica.Mechanics.Translational.Interfaces.Flange_a valve_lift
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    equation
      assert(vc > vo + 20, "Invalid cam timings");
      camshaft.tau = 0;
      valve_lift.s = if (local_ca < vo or local_ca > vc) then 0.0 else
        max_lift*Modelica.Math.sin((local_ca - vo)*norm*Modelica.Constants.pi)^
        2;
      local_ca = mod(camshaft.phi*180.0/Modelica.Constants.pi, 360);

      annotation (
        Icon(graphics={
            Ellipse(
              extent={{-78,50},{22,-50}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-4,44},{30,26},{40,14},{44,0},{38,-20},{24,-32},
                  {10,-38},{-8,-46},{-4,44}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{54,4},{90,-4}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Ellipse(
              extent={{44,6},{56,-6}},
              lineColor={0,0,0},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Text(extent={{-40,80},{40,60}}, textString=
                                                "%name")}),
        Documentation(info="This is an idealized cam model that computes a cam profile from the valve timing (opening and closing) and the
maximum lift.
"));
    end Cam;

    model Reservoir "Infinite reservoir"
      parameter Modelica.SIunits.Pressure P=101800 "Reservoir pressure";
      parameter Modelica.SIunits.Temperature T=300 "Reservoir temperature";
      Interfaces.Gas tap annotation ( Placement(transformation(extent={{-10,-110},{10,-90}})));
    equation
      tap.P = P;
      tap.T = T;
      annotation (
        Icon(graphics={
            Rectangle(
              extent={{-100,100},{100,-90}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(extent={{-42,90},{34,66}}, textString=
                                                "P=%P"),
            Line(points={{-60,10},{-40,30},{-20,30},{0,10},{0,-10},{
                  20,-30},{40,-30},{60,-10},{60,10},{40,30},{20,30},{
                  0,10},{0,-10},{-20,-30},{-40,-30},{-60,-10},{-60,10}},
                color={0,0,0}),
            Text(extent={{-40,70},{36,46}}, textString=
                                                "T=%T"),
            Text(extent={{-60,-74},{60,-52}}, textString=
                                                  "%name")}),
        Documentation(info="This infinite reservoir model is capable of supplying any amount of mass or energy (via the mdot and q flow variables on the
Gas connector) to sustain a specified temperature and pressure.

These \"infinite\" models are interesting because instead of including constitutive relationships between
flow values (mass flow and power) and the potentials of the system (pressure and temperature), they instead
provide algebraic constraints involving only the states.  It is assumed that the flows will be calculated
such that the constraints will be satisfied.  This kind of model is analagous to an ideal voltage source (supplies
as much current as is necessary to sustain a specified voltage) or a mechanical ground (supplies as much
force as is necessary to sustain a specified position).
"));
    end Reservoir;

    model I4_Engine "An Inline 4 Cylinder Engine"
      extends Interfaces.Engine;
      parameter Types.Degrees spark_advance "Spark advance";
      parameter Types.Degrees burn_duration "Burn Duration";
      parameter Types.Degrees evo=40 "Exhaust Valve Opening";
      parameter Types.Degrees ivo=150 "Intake Valve Opening";
      parameter Types.Degrees evc=205 "Exhaust Valve Closing";
      parameter Types.Degrees ivc=310 "Intake Valve Closing";
      parameter Modelica.SIunits.Diameter ivd=0.032 "Intake Valve Diameter";
      parameter Modelica.SIunits.Diameter evd=0.028 "Exhaust Valve Diameter";
      Modelica.SIunits.Power power "Instantaneous engine power output";
      replaceable model CylinderType = IndividualCylinder constrainedby
        Interfaces.Cylinder;
      CylinderType cylinder1(
        crank_shift=0,
        spark_advance=spark_advance,
        burn_duration=burn_duration,
        evo=evo,
        ivo=ivo,
        evc=evc,
        ivc=ivc,
        ivd=ivd,
        evd=evd) annotation (Placement(transformation(extent={{-100,
                -20},{-60,40}})));
      CylinderType cylinder2(
        crank_shift=360,
        spark_advance=spark_advance,
        burn_duration=burn_duration,
        evo=evo,
        ivo=ivo,
        evc=evc,
        ivc=ivc,
        ivd=ivd,
        evd=evd) annotation (Placement(transformation(extent={{0,-20},
                {40,40}})));
      CylinderType cylinder3(
        crank_shift=540,
        spark_advance=spark_advance,
        burn_duration=burn_duration,
        evo=evo,
        ivo=ivo,
        evc=evc,
        ivc=ivc,
        ivd=ivd,
        evd=evd) annotation (Placement(transformation(extent={{-50,
                -20},{-10,40}})));
      CylinderType cylinder4(
        crank_shift=180,
        spark_advance=spark_advance,
        burn_duration=burn_duration,
        evo=evo,
        ivo=ivo,
        evc=evc,
        ivc=ivc,
        ivd=ivd,
        evd=evd) annotation (Placement(transformation(extent={{50,-20},
                {90,40}})));
      Modelica.Mechanics.Rotational.Components.Inertia
        crankshaft_inertia(J=0.03, w(start=157)) annotation (
          Placement(transformation(
            origin={-80,-50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
    equation
      connect(cylinder1.intake, intake) annotation (Line(points={{-100,34},
              {-100,80}},          color={255,127,0}));
      connect(cylinder3.intake, intake) annotation (Line(points={{-50,34},
              {-50,46},{-100,46},{-100,80}},     color={255,127,0}));
      connect(cylinder2.intake, intake) annotation (Line(points={{
              -1.11022e-15,34},{-1.11022e-15,46},{-100,46},{-100,80}},
                                                            color={
              255,127,0}));
      connect(cylinder4.intake, intake) annotation (Line(points={{50,34},
              {50,46},{-100,46},{-100,80}},     color={255,127,0}));
      connect(cylinder1.exhaust, exhaust) annotation (Line(points={{-60,34},
              {-60,80},{100,80}},         color={255,127,0}));
      connect(cylinder4.exhaust, exhaust) annotation (Line(points={{90,34},
              {100,34},{100,80}},        color={255,127,0}));
      connect(cylinder3.exhaust, exhaust) annotation (Line(points={{-10,34},
              {-10,80},{100,80}},         color={255,127,0}));
      connect(cylinder2.exhaust, exhaust) annotation (Line(points={{40,34},
              {40,80},{100,80}},        color={255,127,0}));
      connect(cylinder4.geom, engine_geometry) annotation (Line(
            points={{92,-5},{96,-5},{96,0},{110,0}}, color={0,0,0}));
      connect(cylinder2.geom, engine_geometry) annotation (Line(
            points={{42,-5},{42,10},{42,-50},{96,-50},{96,0},{110,0}},
            color={0,0,0}));
      connect(cylinder3.geom, engine_geometry) annotation (Line(
            points={{-8,-5},{-4,-5},{-4,-50},{96,-50},{96,0},{110,0}},
            color={0,0,0}));
      connect(cylinder1.geom, engine_geometry) annotation (Line(
            points={{-58,-5},{-54,-5},{-54,-50},{96,-50},{96,0},{110,
              0}}, color={0,0,0}));
      connect(cylinder1.crankshaft, cylinder3.crankshaft) annotation (Line(
            points={{-80,-49.4},{-80,-49.4},{-30,-49.4},{-30,-19.6}},
                                              color={128,128,128}));
      connect(cylinder2.crankshaft, cylinder3.crankshaft) annotation (Line(
            points={{20,-49.4},{20,-49.4},{-30,-49.4},{-30,-19.6}},
                                             color={128,128,128}));
      connect(cylinder4.crankshaft, cylinder2.crankshaft) annotation (Line(
            points={{70,-49.4},{70,-49.4},{20,-49.4},{20,-19.6}},
                                            color={128,128,128}));
      connect(crankshaft_inertia.flange_b, cylinder1.crankshaft) annotation (Line(
            points={{-80,-40},{-80,-49.4}}, color={0,0,0}));
      connect(crankshaft_inertia.flange_a, crankshaft) annotation (Line(
            points={{-80,-60},{-80,-70},{-100,-70},{-100,-40}}, color=
             {0,0,0}));
      power = crankshaft.tau*der(crankshaft.phi);
      annotation (
        Icon(graphics={
            Polygon(
              points={{-48,32},{-56,-8},{-56,-48},{-46,-76},{-12,-76},
                  {0,-48},{0,-8},{-8,32},{-46,32},{-48,32}},
              lineColor={0,0,0},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-46,-10},{-16,-68}},
              lineColor={0,0,0},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-36,-30},{-26,-50}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Rectangle(
              extent={{-90,-30},{-30,-50}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Polygon(
              points={{-8,32},{72,32},{84,-6},{84,-48},{74,-76},{-12,
                  -76},{0,-48},{0,-8},{-8,32},{-8,32}},
              lineColor={0,0,0},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{0,-6},{84,-6}}, color={160,160,164}),
            Line(points={{0,-48},{84,-48}}, color={0,0,0}),
            Rectangle(
              extent={{-24,48},{-34,32}},
              lineColor={0,0,0},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{72,48},{62,32}},
              lineColor={0,0,0},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{60,70},{74,40}},
              lineColor={0,0,0},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-36,58},{-46,-30}}, color={0,0,0}),
            Rectangle(
              extent={{-28,62},{68,48}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Ellipse(
              extent={{-36,70},{-24,44}},
              lineColor={0,0,0},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-24,58},{-16,-36}}, color={0,0,0}),
            Rectangle(
              extent={{-16,64},{-10,42}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-8,68},{-2,46}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{4,66},{10,44}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{12,64},{18,42}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{26,68},{32,46}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{34,66},{40,44}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{46,64},{52,42}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{54,66},{60,44}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-16,42},{-10,32}},
              lineColor={0,0,0},
              fillColor={192,192,192},
              fillPattern=FillPattern.Forward),
            Rectangle(
              extent={{-8,44},{-2,32}},
              lineColor={0,0,0},
              fillColor={192,192,192},
              fillPattern=FillPattern.Forward),
            Rectangle(
              extent={{4,44},{10,32}},
              lineColor={0,0,0},
              fillColor={192,192,192},
              fillPattern=FillPattern.Forward),
            Rectangle(
              extent={{12,42},{18,32}},
              lineColor={0,0,0},
              fillColor={192,192,192},
              fillPattern=FillPattern.Forward),
            Rectangle(
              extent={{26,44},{32,32}},
              lineColor={0,0,0},
              fillColor={192,192,192},
              fillPattern=FillPattern.Forward),
            Rectangle(
              extent={{34,44},{40,32}},
              lineColor={0,0,0},
              fillColor={192,192,192},
              fillPattern=FillPattern.Forward),
            Rectangle(
              extent={{46,42},{52,32}},
              lineColor={0,0,0},
              fillColor={192,192,192},
              fillPattern=FillPattern.Forward),
            Rectangle(
              extent={{54,44},{60,32}},
              lineColor={0,0,0},
              fillColor={192,192,192},
              fillPattern=FillPattern.Forward),
            Line(
              points={{-100,80},{-48,32}},
              color={255,127,0},
              thickness=0.5),
            Line(points={{100,80},{62,32}}, color={255,127,0}),
            Text(extent={{-60,-74},{80,-106}}, textString=
                                                   "%name")}),
        Documentation(info="An assembly of components required for an I4 engine.  This model requires a connection to intake and exhaust
gases, the crankshaft and geometry information.
"));
    end I4_Engine;

    model Manifold "A simple filling-and-emptying manifold model"
      parameter Modelica.SIunits.Volume volume=0.004 "Manifold volume";
      Engine.Components.ControlVolume manifold_volume annotation (Placement(
            transformation(extent={{-40,-40},{40,40}})));
      Modelica.Blocks.Sources.Constant volume_value(final k=volume)
        annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
      Interfaces.Gas ambient annotation (Placement(transformation(
              extent={{-10,90},{10,110}})));
      Interfaces.Gas manifold annotation (Placement(transformation(extent={{-10,-110},{10,
                -90}})));
      Modelica.Blocks.Interfaces.RealInput throttle_angle annotation (Placement(
            transformation(extent={{-120,-10},{-100,10}})));
      Engine.Components.Throttle throttle(dia=0.10) annotation (Placement(
            transformation(
            origin={0,60},
            extent={{20,-20},{-20,20}},
            rotation=90)));
    equation
      connect(volume_value.y, manifold_volume.volume) annotation (Line(
            points={{61,-50},{80,-50},{80,0},{44,2.22045e-15}}));
      connect(manifold_volume.state, manifold) annotation (Line(
            points={{2.22045e-15,2.22045e-15},{0,-100}}, color={255,
              127,0}));
      connect(throttle.b, manifold_volume.state) annotation (Line(
            points={{20,60},{20,0},{2.22045e-15,2.22045e-15}}, color=
              {255,127,0}));
      connect(throttle.a, ambient) annotation (Line(points={{
              -1.11022e-16,80},{0,100}}, color={255,127,0}));
      connect(throttle_angle, throttle.throttle_angle) annotation (Line(
            points={{-110,0},{-60,0},{-60,60},{-22,60}}));
      annotation (
        Icon(graphics={
            Rectangle(
              extent={{-80,40},{80,-40}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Rectangle(
              extent={{-80,-40},{-60,-80}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={192,192,192}),
            Rectangle(
              extent={{20,-40},{40,-80}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={192,192,192}),
            Rectangle(
              extent={{-40,-40},{-20,-80}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={192,192,192}),
            Rectangle(
              extent={{60,-40},{80,-80}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={192,192,192}),
            Rectangle(
              extent={{-10,80},{10,40}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={192,192,192}),
            Line(
              points={{-6,56},{6,64}},
              color={0,0,0},
              thickness=0.5),
            Ellipse(
              extent={{-2,62},{2,58}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Line(points={{-100,0},{-90,0},{-90,60},{0,60}}),
            Text(extent={{20,80},{100,60}}, textString=
                                                "%name")}),
        Documentation(info="This very simple model contains a throttle and a control volume which
can be connected to the intake system of an engine (or cylinder) in
order to simulate the effects of manifold filling and emptying.  A
throttle position of 90 degrees corresponds to wide open throttle (WOT)
while a throttle position of 0 degrees corresponds to a closed throttle.
"));
    end Manifold;
  end Components;
  annotation (
    Documentation(info="This package contains numerous engine component models and a complete I4 engine model.
"), Icon(graphics={
        Ellipse(
          extent={{-84,-22},{-38,-42}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-84,-20},{-38,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-64,22},{-59,-30}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={192,192,192}),
        Ellipse(
          extent={{19,-79},{25,-85}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{22,-82},{36,-71},{21,-39}}, color={0,0,0}),
        Rectangle(
          extent={{3,-23},{37,-39}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={192,192,192})}));
end Engine;
