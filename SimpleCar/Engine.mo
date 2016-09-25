package Engine "Engine models and components" 
  extends Modelica.Icons.Library2;
  
  package GasProperties "Gas property related definitions" 
    partial model BasePropertyModel "Basic property model interface" 
      Modelica.SIunits.Pressure P "Gas pressure";
      Modelica.SIunits.Temperature T "Gas temperature";
      Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy of gas";
      Modelica.SIunits.SpecificEnergy u "Specific energy of gas";
      Real gamma "ratio of specific heats";
      Modelica.SIunits.MolarMass mw "Molecular weight of gas";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.39, 
          y=0.34, 
          width=0.6, 
          height=0.6), 
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
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.39, 
          y=0.34, 
          width=0.6, 
          height=0.6), 
        Documentation(info="This property model assumes the gas is a perfect gas with the properties of air at room temperature.
This is an overly simplified model of air but sufficient for demonstrating the basics of engine
thermodynamics.
"));
    equation 
      h = cp*T;
      u = cv*T;
      mw = mole_weight;
      gamma = cp/cv;
    end SimpleAirProperties;
  end GasProperties;
  model GeometrySource "Engine geometry specification" 
    parameter Modelica.SIunits.Length bore "Engine bore";
    parameter Modelica.SIunits.Length stroke "Engine stroke";
    parameter Modelica.SIunits.Length conrod "Connecting rod length";
    parameter Real comp_ratio=9.5 "Compression ratio";
    Interfaces.EngineGeometryProvided geom annotation (extent=[-120, -10; -100
          , 10], rotation=180);
    annotation (
      Icon(
        Polygon(points=[-60, -100; -60, 40; -42, 40; -42, 44; -40, 46; -60, 60
              ; -100, 60; -100, -100; -60, -100], style(color=0, fillColor=8))
          , 
        Rectangle(extent=[-58, 12; 58, -64], style(gradient=1, fillColor=8)), 
        Rectangle(extent=[-60, 6; 60, 0], style(color=0, fillColor=0)), 
        Rectangle(extent=[-60, -8; 60, -14], style(color=0, fillColor=0)), 
        Rectangle(extent=[-60, -20; 60, -26], style(color=0, fillColor=0)), 
        Polygon(points=[-58, -64; -40, -52; 40, -52; 58, -64; -58, -64], style
            (pattern=0, fillColor=7)), 
        Ellipse(extent=[-4, -34; 4, -42], style(color=0, fillColor=0)), 
        Rectangle(extent=[-42, 44; -18, 40], style(gradient=1, fillColor=8)), 
        Polygon(points=[-42, 44; -40, 46; -20, 46; -18, 44; -42, 44], style(
              color=9, fillColor=8)), 
        Rectangle(extent=[-32, 46; -28, 94], style(gradient=1, fillColor=8)), 
        Polygon(points=[18, 44; 20, 46; 40, 46; 42, 44; 18, 44], style(color=9
              , fillColor=8)), 
        Rectangle(extent=[18, 44; 42, 40], style(gradient=1, fillColor=8)), 
        Rectangle(extent=[28, 46; 32, 96], style(gradient=1, fillColor=8)), 
        Polygon(points=[100, -100; 100, 60; 60, 60; 40, 46; 42, 44; 42, 40; 60
              , 40; 60, -100; 100, -100], style(color=0, fillColor=8)), 
        Polygon(points=[-100, 96; -60, 96; -40, 80; -20, 60; -20, 46; -18, 44
              ; -18, 40; 18, 40; 18, 44; 20, 46; 20, 60; 40, 80; 60, 96; 100, 
              96; 100, 100; -100, 100; -100, 96], style(color=0, fillColor=8))
          , 
        Text(extent=[-60, -66; 60, -100], string="%name")), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.45, 
        y=0.16, 
        width=0.6, 
        height=0.6), 
      Documentation(info="This model takes basic engine geometry parameters and computes the complete
set of engine geometry characteristics.
"));
  equation 
    assert(bore > 0, "Invalid bore value");
    assert(stroke > 0, "Invalid stroke value");
    assert(conrod > 0, "Invalid connecting rod length");
    assert(comp_ratio > 1, "Invalid compression ratio");
    geom.bore = bore;
    geom.stroke = stroke;
    geom.conrod = conrod;
    geom.Vc = geom.Vd/(comp_ratio - 1);
    geom.Ap = Modelica.Constants.PI*(bore/2)^2;
    geom.Vd = stroke*geom.Ap;
    geom.crank = stroke/2.0;
  end GeometrySource;
  model SportsCarGeometry "Geometry of a sports car with an I4 engine" 
    extends GeometrySource(
      bore=.09604, 
      stroke=.0794, 
      comp_ratio=9.5, 
      conrod=0.157);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.1, 
        y=0.1, 
        width=0.6, 
        height=0.6), 
      Documentation(info="This model has default engine geometry parameters that would be typical of a sports car.
"));
  end SportsCarGeometry;
  package Components "A collection of components used to build engines" 
    extends Modelica.Icons.Library2;
    
    replaceable model PropertyModel = GasProperties.SimpleAirProperties;
    model ChamberVolume 
      "Computes combustion chamber volume as a function of piston position" 
      Modelica.Mechanics.Translational.Interfaces.Flange_a piston annotation (
          extent=[-10, -90; 10, -70]);
      Modelica.Blocks.Interfaces.OutPort volume(final n=1) annotation (extent=
            [-120, -10; -100, 10], rotation=180);
      Interfaces.EngineGeometryRequired geom annotation (extent=[100, -10; 120
            , 10], rotation=180);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.54, 
          y=0.18, 
          width=0.39, 
          height=0.79), 
        Icon(
          Polygon(points=[-60, -100; -60, 40; -42, 40; -42, 44; -40, 46; -60, 
                60; -100, 60; -100, -100; -60, -100], style(
              color=0, 
              fillColor=7, 
              fillPattern=7)), 
          Polygon(points=[-100, 96; -60, 96; -40, 80; -20, 60; -20, 46; -18, 
                44; -18, 40; 18, 40; 18, 44; 20, 46; 20, 60; 40, 80; 60, 96; 
                100, 96; 100, 100; -100, 100; -100, 96], style(
              color=0, 
              fillColor=7, 
              fillPattern=7)), 
          Rectangle(extent=[-58, 12; 58, -64], style(gradient=1, fillColor=8))
            , 
          Rectangle(extent=[-60, 6; 60, 0], style(color=0, fillColor=0)), 
          Rectangle(extent=[-60, -8; 60, -14], style(color=0, fillColor=0)), 
          Rectangle(extent=[-60, -20; 60, -26], style(color=0, fillColor=0)), 
          Polygon(points=[-58, -64; -40, -52; 40, -52; 58, -64; -58, -64], 
              style(pattern=0, fillColor=7)), 
          Ellipse(extent=[-4, -34; 4, -42], style(color=0, fillColor=0)), 
          Rectangle(extent=[-42, 36; -18, 32], style(gradient=1, fillColor=8))
            , 
          Polygon(points=[-42, 36; -40, 38; -20, 38; -18, 36; -42, 36], style(
                color=9, fillColor=8)), 
          Rectangle(extent=[-32, 38; -28, 96], style(gradient=1, fillColor=8))
            , 
          Polygon(points=[18, 44; 20, 46; 40, 46; 42, 44; 18, 44], style(color
                =9, fillColor=8)), 
          Rectangle(extent=[18, 44; 42, 40], style(gradient=1, fillColor=8)), 
          Rectangle(extent=[28, 46; 32, 96], style(gradient=1, fillColor=8)), 
          Polygon(points=[100, -100; 100, 60; 60, 60; 40, 46; 42, 44; 42, 40; 
                60, 40; 60, -100; 100, -100], style(
              color=0, 
              fillColor=7, 
              fillPattern=7)), 
          Text(extent=[-58, 126; 60, 94], string="%name")), 
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
    equation 
      volume.signal[1] = geom.Vc + geom.Ap*piston.s;
      piston.f = 0;
    end ChamberVolume;
    model ControlVolume "Thermodynamic control volume" 
    protected 
      Modelica.SIunits.Energy U(start=147) "Total energy";
      Modelica.SIunits.Mass m(start=4e-4) "Total mass";
      Modelica.SIunits.Pressure P(start=101800) = state.P "Pressure";
      Modelica.SIunits.Temperature T(start=300) = state.T "Temperature";
      Modelica.SIunits.MassFlowRate mdot=state.mdot "Net mass flow";
      Modelica.SIunits.Power q=state.q "Net power";
      Modelica.SIunits.Volume V=volume.signal[1] "Chamber volume";
      Modelica.SIunits.AmountOfSubstance N "Number of moles of gas";
      Real R=Modelica.Constants.R;
      Real logV;
      Real logP;
    public 
      Modelica.Blocks.Interfaces.InPort volume(final n=1) annotation (extent=[
            100, -10; 120, 10], rotation=180);
    public 
      Modelica.Blocks.Interfaces.OutPort mass annotation (extent=[-70, 100; -
            50, 120], rotation=90);
    public 
      Interfaces.Gas state "Gas state" annotation (extent=[-10, -10; 10, 10], 
          layer="icon");
    protected 
      PropertyModel props(T=T, P=P) annotation (extent=[-80, 40; -40, 80]);
      annotation (
        Icon(
          Rectangle(extent=[-60, 60; 60, -60], style(color=0, fillPattern=0))
            , 
          Ellipse(extent=[14, 46; 18, 50], style(color=69, fillColor=69)), 
          Line(points=[16, 48; 4, 60; -18, 42], style(
              color=0, 
              pattern=3, 
              fillColor=0)), 
          Ellipse(extent=[52, 20; 56, 24], style(color=69, fillColor=69)), 
          Ellipse(extent=[-54, 18; -50, 22], style(color=69, fillColor=69)), 
          Line(points=[54, 22; 60, 14; 52, 2], style(
              color=0, 
              pattern=3, 
              fillColor=0)), 
          Line(points=[-54, 40; -60, 32; -52, 20], style(color=0, pattern=3))
            , 
          Ellipse(extent=[0, 18; 4, 14], style(color=69, fillColor=69)), 
          Line(points=[2, 16; -18, 10], style(
              color=0, 
              pattern=3, 
              fillColor=0)), 
          Ellipse(extent=[-40, -42; -36, -46], style(color=69, fillColor=69))
            , 
          Line(points=[-38, -44; -34, -60; -30, -34], style(color=0, pattern=3
              )), 
          Ellipse(extent=[24, -24; 28, -28], style(
              color=69, 
              pattern=3, 
              fillColor=69)), 
          Line(points=[26, -26; 38, -52], style(color=0, pattern=3)), 
          Text(extent=[-50, 108; 80, 80], string="%name"), 
          Polygon(points=[-80, 68; -80, 80; -60, 60; -60, -60; 60, -60; 60, 60
                ; -60, 60; -80, 80; 80, 80; 80, -80; -80, -80; -80, 68], style(
              color=0, 
              fillColor=7, 
              fillPattern=8))), 
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.32, 
          y=0.32, 
          width=0.6, 
          height=0.6), 
        Documentation(info="This model contains the basic equations of a thermodynamic control volume.  These include the conservation of mass and energy
as well as the ideal gas law and gas property equations.  The volume of the control volume is an input to this model
and the current mass contained within the control volume is an output.  The output signal for mass is necessary to
connect a combustion model.
"));
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
      mass.signal[1] = m;
      logV = Modelica.Math.log(V);
      logP = Modelica.Math.log(P);
    end ControlVolume;
    model Orifice "Isentropic flow restriction" 
      parameter Modelica.SIunits.Area Aref "Reference Area";
    protected 
      Modelica.SIunits.MassFlowRate mdot "Flow from 'a' to 'b'";
      Modelica.SIunits.SpecificEnthalpy h "Upstream enthalpy";
      Modelica.SIunits.SpecificEnthalpy gamma "Upstream gamma";
      Real pratio "Pressure ratio";
      Real Cd "Discharge Coefficient";
    public 
      Interfaces.Gas a annotation (extent=[-110, -10; -90, 10]);
      Interfaces.Gas b annotation (extent=[-10, -110; 10, -90]);
    protected 
      PropertyModel a_props(T=a.T, P=a.P) annotation (extent=[-56.6667, 10; -
            10, 56.6667]);
      PropertyModel b_props(T=b.T, P=b.P) annotation (extent=[10, 10; 56.6667
            , 56.6667]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.23, 
          y=0.19, 
          width=0.6, 
          height=0.6), 
        Documentation(info="This is a base model for other models which model isentropic flow (e.g. throttles, engine valves)
"));
    equation 
      a.mdot = mdot;
      b.mdot = -mdot;
      a.q = mdot*h;
      b.q = -mdot*h;
      if noEvent(a.P > b.P) then
        h = a_props.h;
        gamma = a_props.gamma;
        pratio = b.P/a.P;
        if (pratio <= (2.0/(gamma + 1.0))^(gamma/(gamma - 1.0))) then
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
        if (pratio <= (2.0/(gamma + 1.0))^(gamma/(gamma - 1.0))) then
          mdot = -Cd*Aref*b.P/((Modelica.Constants.R/b_props.mw)*b.T)^0.5*
            gamma^0.5*(2.0/(gamma + 1.0))^((gamma + 1.0)/(2.0*(gamma - 1.0)));
        else
          mdot = -Cd*Aref*b.P/((Modelica.Constants.R/b_props.mw)*b.T)^0.5*
            pratio^(1.0/gamma)*(2.0*gamma/(gamma - 1.0)*(1.0 - pratio^((gamma
             - 1.0)/gamma)))^0.5;
        end if;
      end if;
    end Orifice;
    model Throttle "Orifice with throttle plate" 
      parameter Modelica.SIunits.Diameter dia=0.1 "Throttle diameter";
      extends Orifice(final Aref=Modelica.Constants.PI*(dia/2)^2);
      Modelica.Blocks.Interfaces.InPort throttle_angle(final n=1) 
        "Throttle Angle [deg]" annotation (extent=[-10, 100; 10, 120], rotation
          =270);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.16, 
          y=0.29, 
          width=0.31, 
          height=0.63), 
        Icon(
          Rectangle(extent=[-60, 80; 60, -80], style(gradient=1, fillColor=8))
            , 
          Line(points=[30, 32; -30, -28], style(color=0, thickness=2)), 
          Ellipse(extent=[-6, 8; 6, -4], style(color=0, fillColor=0)), 
          Text(extent=[20, 100; 100, 80], string="%name")), 
        Documentation(info="A very simple engine throttle.  The input signal is the throttle angle.
"));
    equation 
      Cd = Modelica.Math.sin(throttle_angle.signal[1]*Modelica.Constants.
        PI/180)^2;
    end Throttle;
    model Valve "Engine poppet valve" 
      parameter Modelica.SIunits.Diameter dia=0.012 "Valve diameter";
      parameter Modelica.SIunits.Length max_lift=0.012 "Maximum Valve Lift";
      parameter Real max_discharge=0.7 "Maximum Discharge Coefficient";
      extends Orifice(final Aref=Modelica.Constants.PI*(dia/2)^2);
    protected 
      parameter Real c_over_l=max_discharge/max_lift;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Icon(
          Rectangle(extent=[-40, -60; 40, -70], style(gradient=1, fillColor=8)
            ), 
          Polygon(points=[-40, -60; -28, -52; 30, -52; 40, -60; -40, -60], 
              style(
              color=0, 
              gradient=1, 
              fillColor=9)), 
          Rectangle(extent=[-10, 90; 10, -52], style(gradient=1, fillColor=8))
            , 
          Polygon(points=[-40, -54; -28, -46; -28, -40; -40, -30; -60, -16; -
                100, -16; -100, -100; -60, -100; -60, -70; -60, -58; -40, -58; 
                -40, -54], style(
              color=0, 
              fillColor=7, 
              fillPattern=7)), 
          Polygon(points=[-100, 40; -60, 40; -10, 16; -10, 100; -100, 100; -
                100, 40], style(
              color=0, 
              fillColor=7, 
              fillPattern=7)), 
          Polygon(points=[10, 6; 20, 0; 30, -40; 30, -46; 40, -54; 40, -58; 60
                , -58; 60, -100; 100, -100; 100, 100; 10, 100; 10, 6], style(
              color=0, 
              fillColor=7, 
              fillPattern=7)), 
          Text(extent=[12, 64; 100, 44], string="%name")), 
        Window(
          x=0.39, 
          y=0.31, 
          width=0.6, 
          height=0.6), 
        Documentation(info="This is a very simple model of an engine valve the is derived from the \"Orifice\" model of isentropic flow.
The valve model must be connected to two different gas volumes (or reservoirs).  In addition, a translational
connector is used to represent the lift of the valve.
"));
    public 
      Modelica.Mechanics.Translational.Interfaces.Flange_a lift annotation (
          extent=[-10, 90; 10, 110], layer="icon");
    equation 
      lift.f = 0;
      Cd = c_over_l*lift.s;
      // Cd = 0.0;
    end Valve;
    model MasslessPiston "A massless piston" 
      parameter Modelica.SIunits.Pressure Pcc=101800 "Crankcase pressure";
      Interfaces.EngineGeometryRequired geom annotation (extent=[100, -10; 120
            , 10], rotation=180);
      Interfaces.Gas chamber annotation (extent=[-10, 90; 10, 110]);
      Modelica.Mechanics.Translational.Interfaces.Flange_a piston annotation (
          extent=[-10, -32; 10, -12]);
      annotation (
        Icon(
          Rectangle(extent=[-94, 90; 94, -100], style(gradient=1, fillColor=8)
            ), 
          Rectangle(extent=[-100, 80; 100, 74], style(color=0, fillColor=0)), 
          Rectangle(extent=[-100, 42; 100, 36], style(color=0, fillColor=0)), 
          Rectangle(extent=[-100, 60; 100, 54], style(color=0, fillColor=0)), 
          Polygon(points=[-94, -100; -60, -58; 60, -58; 94, -100; -94, -100], 
              style(pattern=0, fillColor=7)), 
          Ellipse(extent=[-20, -2; 20, -42], style(color=0, fillColor=0)), 
          Text(extent=[-40, -70; 42, -90], string="%name")), 
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.39, 
          y=0.22, 
          width=0.6, 
          height=0.6), 
        Documentation(info="This piston is used to translate pressure inside the cylinder into force (presumably applied to the crank slider mechanism).
This piston has no mass.
"));
    equation 
      piston.f = geom.Ap*(chamber.P - Pcc);
      chamber.mdot = 0;
      chamber.q = 0;
      
    end MasslessPiston;
    model OffsetShaft "Angular displacement" 
      parameter Types.Degrees shift=0 "Shift from crankshaft";
      Types.RPM shaft_speed;
      Modelica.Mechanics.Rotational.Interfaces.Flange_a crank annotation (
          extent=[-110, -10; -90, 10]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_b cyl annotation (extent
          =[-10, -110; 10, -90]);
      annotation (
        Icon(
          Rectangle(extent=[-90, 10; -40, -10], style(
              color=9, 
              gradient=2, 
              fillColor=8)), 
          Rectangle(extent=[-40, 10; -20, -80], style(color=9, fillColor=8)), 
          Rectangle(extent=[-20, -40; 20, -80], style(
              color=9, 
              gradient=2, 
              fillColor=8)), 
          Rectangle(extent=[20, 10; 40, -80], style(color=9, fillColor=8)), 
          Rectangle(extent=[40, 10; 90, -10], style(gradient=2, fillColor=8))
            , 
          Text(extent=[-40, 40; 40, 20], string="%name")), 
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.39, 
          y=0.34, 
          width=0.6, 
          height=0.6), 
        Documentation(info="Each cylinder is shifted on that crank shaft.  This model enforces an angular displacement from one flange to another
so that each cylinder can be rigidly connected to the crankshaft by independently shifted.
"));
    equation 
      shaft_speed = 30*der(crank.phi)/Modelica.Constants.pi;
      crank.tau + cyl.tau = 0;
      cyl.phi = crank.phi + shift*Modelica.Constants.PI/180.0;
    end OffsetShaft;
    model CrankSlider "A crank slider mechanism" 
    protected 
      Modelica.SIunits.Length d;
      Modelica.SIunits.Angle phi;
      Real cp;
      Real sp;
    public 
      Interfaces.EngineGeometryRequired geom annotation (extent=[100, -10; 120
            , 10], rotation=180);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a crank annotation (
          extent=[-10, -50; 10, -30]);
      annotation (
        Icon(
          Polygon(points=[-18, -40; -46, -44; -50, -60; -20, -90; -4, -86; 0, 
                -60; -18, -40], style(color=8, fillColor=8)), 
          Ellipse(extent=[-18, 118; 18, 82], style(color=9, fillColor=9)), 
          Ellipse(extent=[-14, 114; 14, 86], style(color=0, fillColor=7)), 
          Ellipse(extent=[0, 14; 54, -38], style(color=8, fillColor=9)), 
          Ellipse(extent=[12, -26; 42, 4], style(color=8, fillColor=8)), 
          Ellipse(extent=[-30, -10; 30, -70], style(color=8, fillColor=8)), 
          Polygon(points=[-16, 92; 2, -20; 50, 2; 18, 102; 12, 88; 4, 84; -8, 
                86; -16, 92], style(color=9, fillColor=9)), 
          Polygon(points=[-6, -14; 20, 0; 38, -18; 24, -46; 18, -26; -6, -18; 
                -6, -14], style(color=8, fillColor=8)), 
          Ellipse(extent=[12, -26; 42, 4], style(color=8, fillColor=8)), 
          Polygon(points=[18, 106; 20, 68; 32, 26; 58, -10; 72, 70; 34, 102; 
                18, 106], style(pattern=0, fillColor=7)), 
          Polygon(points=[-20, 102; -4, 64; 4, 20; 0, -8; -28, 14; -20, 102], 
              style(pattern=0, fillColor=7)), 
          Text(extent=[-62, -100; 66, -120], string="%name")), 
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.54, 
          y=0.23, 
          width=0.29, 
          height=0.64), 
        Documentation(info="This model represents the crank slider mechanism used to turn translational
force into the rotational torque applied to the crankshaft.
"));
      Modelica.Mechanics.Translational.Interfaces.Flange_a piston annotation (
          extent=[-10, 90; 10, 110]);
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
    end CrankSlider;
    model SparkControl "Spark plug control" 
      parameter Types.Degrees spark_advance=20 "Before top-dead-center (TDC)";
    protected 
      Types.Degrees cur_pos;
      Types.Degrees next_spark;
    public 
      Modelica.Blocks.Interfaces.BooleanOutPort spark annotation (extent=[100
            , -10; 120, 10]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a crank annotation (
          extent=[-10, -110; 10, -90]);
      annotation (
        Diagram, 
        Icon(
          Rectangle(extent=[-100, 100; 100, -100], style(fillColor=52)), 
          Rectangle(extent=[-20, 60; 14, -20], style(color=0, fillColor=9)), 
          Polygon(points=[14, -20; 14, -46; -6, -50; -6, -44; 8, -42; 8, -20; 
                14, -20], style(color=0, fillColor=9)), 
          Polygon(points=[-8, -24; -34, -46; -14, -36; -20, -54; -6, -36; 0, -
                58; 2, -36; 16, -56; 12, -36; 40, -52; 6, -24; 4, -26; -4, -26
                ; -8, -24], style(color=45, fillColor=49)), 
          Line(points=[60, 0; 100, 0], style(color=81)), 
          Text(extent=[-64, 120; 56, 100], string="Spark Controller"), 
          Text(extent=[-88, -50; 96, -88], string=
                "Timing: %spark_advance [deg] before TDC")), 
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.18, 
          y=0.22, 
          width=0.38, 
          height=0.67), 
        Documentation(info="This model triggers the firing of the spark plug when the piston reaches a prescribed number of degrees
before top dead center of the compression/combustion strokes.  A real spark control strategy would allow
the spark strategy to change as engine conditions changed but this model just assumes a fixed
\"spark advance\".
"));
    equation 
      crank.tau = 0;
      cur_pos = crank.phi*180/Modelica.Constants.PI;
    algorithm 
      when initial() then
        next_spark := -spark_advance;
        while (next_spark < cur_pos) loop
          next_spark := next_spark + 720;
        end while;
      end when;
      spark.signal[1] := cur_pos > next_spark;
      when spark.signal[1] then
        next_spark := next_spark + 720;
      end when;
    end SparkControl;
    model TimingBelt "Engine timing belt" 
      Modelica.Mechanics.Rotational.Interfaces.Flange_a crankshaft annotation 
        (extent=[-10, -90; 10, -70]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_b camshaft annotation (
          extent=[-10, 50; 10, 70]);
      annotation (
        Icon(
          Ellipse(extent=[-40, 100; 40, 20], style(color=0, fillColor=8)), 
          Ellipse(extent=[20, -100; -20, -60], style(color=0, fillColor=8)), 
          Line(points=[-20, -82; -40, 56], style(color=8, thickness=4)), 
          Line(points=[-40, 56; -20, -82], style(color=0, pattern=2)), 
          Line(points=[40, 56; 20, -82], style(color=8, thickness=4)), 
          Line(points=[40, 54; 20, -82], style(color=0, pattern=2)), 
          Text(extent=[-60, 0; 60, -20], string="%name")), 
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.3, 
          y=0.17, 
          width=0.6, 
          height=0.6), 
        Documentation(info="A timing belt that makes sure the camshaft spins at half the frequency as the crank shaft.
"));
    equation 
      2*camshaft.phi = crankshaft.phi;
      camshaft.tau = 2*crankshaft.tau;
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
      Interfaces.Gas cylinder annotation (extent=[-10, -50; 10, -30]);
      Modelica.Blocks.Interfaces.InPort mass(final n=1) annotation (extent=[-
            70, -100; -50, -120], rotation=270);
      Modelica.Blocks.Interfaces.BooleanInPort start(final n=1) annotation (
          extent=[-10, 100; 10, 120], rotation=270);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a crank annotation (
          extent=[-110, -50; -90, -30]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.41, 
          y=0.28, 
          width=0.26, 
          height=0.6), 
        Icon(
          Rectangle(extent=[-8, 40; 8, 10], style(
              color=0, 
              gradient=1, 
              fillColor=8)), 
          Polygon(points=[4, 10; 4, 2; -2, 2; -2, 0; 6, 0; 6, 10; 4, 10], 
              style(color=0, fillColor=8)), 
          Rectangle(extent=[-2, 10; 2, 6], style(color=0, fillColor=9)), 
          Polygon(points=[-12, 4; -6, -2; 8, -2; 14, 4; 22, 4; 16, 0; 20, -6; 
                12, -6; 10, -12; 6, -6; 4, -18; 0, -8; -6, -14; -6, -6; -16, -8
                ; -12, -2; -20, 2; -12, 4], style(color=49, fillColor=49)), 
          Polygon(points=[-20, 2; -26, 2; -16, -2; -20, -12; -8, -10; -10, -20
                ; -2, -16; 6, -26; 8, -16; 12, -18; 16, -10; 26, -8; 22, -2; 30
                , 4; 22, 4; 16, 0; 20, -6; 12, -6; 10, -12; 6, -8; 4, -18; 0, -
                8; -6, -14; -6, -6; -14, -8; -12, -2; -20, 2], style(color=41, 
                fillColor=45)), 
          Polygon(points=[-80, -80; -80, -20; -28, 0; -28, 10; -8, 10; -8, 40
                ; -92, 40; -92, -80; -80, -80], style(
              color=0, 
              fillColor=7, 
              fillPattern=7)), 
          Polygon(points=[8, 40; 8, 10; 32, 10; 32, 0; 80, -20; 80, -80; 90, -
                80; 90, 40; 8, 40; 8, 10; 8, 40], style(
              color=0, 
              fillColor=7, 
              fillPattern=7)), 
          Line(points=[0, 112; 0, 40], style(color=81)), 
          Text(extent=[-60, -80; 60, -100], string="%name")), 
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
    equation 
      assert(burn_duration > 1, "Invalid burn duration");
      cylinder.mdot = 0;
      cylinder.q = if (burning) then -amplitude*Modelica.Math.sin((time - 
        start_burn)/(end_burn - start_burn)*Modelica.Constants.PI)^2 else 0.0;
      der(tmp) = cylinder.q;
      w = der(crank.phi);
      dps = w*180/Modelica.Constants.PI;
      crank.tau = 0;
    algorithm 
      when start.signal[1] then
        start_burn := time;
        end_burn := time + (burn_duration/dps);
        amplitude := lhv*(mass.signal[1]/(afr + 1))*2.0*dps/burn_duration;
        burning := true;
      end when;
      when time >= end_burn then
        burning := false;
      end when;
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
      
      Modelica.Blocks.Interfaces.InPort rpm(final n=1) annotation (extent=[-
            120, -10; -100, 10]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft annotation (
          extent=[90, -10; 110, 10]);
      annotation (
        Icon(
          Rectangle(extent=[60, 10; 90, -10], style(
              gradient=2, 
              fillColor=8, 
              fillPattern=1)), 
          Rectangle(extent=[-40, 60; 40, -60], style(
              color=3, 
              pattern=1, 
              thickness=1, 
              gradient=2, 
              arrow=0, 
              fillColor=8, 
              fillPattern=1)), 
          Polygon(points=[-60, 10; -60, 20; -40, 40; -40, -40; -60, -20; -60, 
                10], style(
              color=10, 
              gradient=2, 
              fillColor=10, 
              fillPattern=1)), 
          Polygon(points=[60, 20; 40, 40; 40, -40; 60, -20; 60, 20], style(
              color=10, 
              fillColor=10, 
              fillPattern=1)), 
          Polygon(points=[-60, -90; -50, -90; -20, -30; 20, -30; 48, -90; 60, 
                -90; 60, -100; -60, -100; -60, -90], style(
              color=0, 
              fillColor=0, 
              fillPattern=1)), 
          Line(points=[-112, 0; -60, 0]), 
          Text(extent=[-80, 100; 80, 60], string="Dynamometer")), 
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.38, 
          y=0.22, 
          width=0.6, 
          height=0.6), 
        Documentation(info="This dynamometer model is ideal.  This means that the dynamometer appear (to anything connected to it) to have
an infinite mass.  It is important that the input signal is continuous.  Furthermore the input signal has units
of \"revolutions per minute\".
"));
    equation 
      der(shaft.phi) = rpm.signal[1]*Modelica.Constants.pi/30;
      der(work) = shaft.tau*der(shaft.phi);
    algorithm 
      when initial() then
        next_rotation := shaft.phi + cycle_fraction*4*Modelica.Constants.pi;
        last_work := 0;
        previous_time := time;
        avg_rpm := rpm.signal[1];
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
    end Dynamometer;
    annotation (Coordsys(
        extent=[0, 0; 624, 417], 
        grid=[1, 1], 
        component=[20, 20]), Window(
        x=0.26, 
        y=0.11, 
        width=0.4, 
        height=0.4, 
        library=1, 
        autolayout=1));
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
      Engine.Components.MasslessPiston piston annotation (extent=[-10, -50; 10
            , -30]);
      Engine.Components.CrankSlider crankslider annotation (extent=[-20, -120
            ; 20, -80]);
      annotation (
        Coordsys(
          extent=[-100, -200; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.07, 
          y=0.03, 
          width=0.99, 
          height=0.91), 
        Icon(
          Polygon(points=[-60, -140; -60, 40; -42, 40; -42, 44; -40, 46; -60, 
                60; -100, 60; -100, -140; -60, -140], style(color=0, fillColor=
                  8)), 
          Polygon(points=[-100, 96; -60, 96; -40, 80; -20, 60; -20, 46; -18, 
                44; -18, 40; 18, 40; 18, 44; 20, 46; 20, 60; 40, 80; 60, 96; 
                100, 96; 100, 100; -100, 100; -100, 96], style(color=0, 
                fillColor=8)), 
          Rectangle(extent=[-58, 12; 58, -64], style(gradient=1, fillColor=8))
            , 
          Rectangle(extent=[-60, 6; 60, 0], style(color=0, fillColor=0)), 
          Rectangle(extent=[-60, -8; 60, -14], style(color=0, fillColor=0)), 
          Rectangle(extent=[-60, -20; 60, -26], style(color=0, fillColor=0)), 
          Polygon(points=[-58, -64; -40, -52; 40, -52; 58, -64; -58, -64], 
              style(pattern=0, fillColor=7)), 
          Ellipse(extent=[-4, -34; 4, -42], style(color=0, fillColor=0)), 
          Ellipse(extent=[-40, -240; 40, -160], style(color=8)), 
          Line(points=[0, -200; 30, -174; 0, -38], style(color=0, thickness=4)
            ), 
          Rectangle(extent=[-42, 36; -18, 32], style(gradient=1, fillColor=8))
            , 
          Polygon(points=[-42, 36; -40, 38; -20, 38; -18, 36; -42, 36], style(
                color=9, fillColor=8)), 
          Rectangle(extent=[-32, 38; -28, 96], style(gradient=1, fillColor=8))
            , 
          Polygon(points=[18, 44; 20, 46; 40, 46; 42, 44; 18, 44], style(color
                =9, fillColor=8)), 
          Rectangle(extent=[18, 44; 42, 40], style(gradient=1, fillColor=8)), 
          Rectangle(extent=[28, 46; 32, 96], style(gradient=1, fillColor=8)), 
          Polygon(points=[100, -140; 100, 60; 60, 60; 40, 46; 42, 44; 42, 40; 
                60, 40; 60, -140; 100, -140], style(color=0, fillColor=8)), 
          Text(extent=[-60, -100; 60, -120], string="%name")), 
        Documentation(info="All the basic componets of a single cylinder, 2-valve engine
have been compiled in this model.
"), 
        Diagram);
      Engine.Components.ControlVolume combustion_chamber annotation (extent=[-
            10, -20; 10, 0]);
      Engine.Components.Valve intake_valve(dia=ivd) annotation (extent=[-40, 
            20; -20, 40]);
      Engine.Components.Valve exhaust_valve(dia=evd) annotation (extent=[40, 
            20; 20, 40]);
      Engine.Components.TimingBelt timing_belt annotation (extent=[-100, -60; 
            -60, -20]);
      Engine.Components.Cam intake_cam(vo=ivo, vc=ivc) annotation (extent=[-60
            , 60; -40, 80]);
      Engine.Components.Cam exhaust_cam(vo=evo, vc=evc) annotation (extent=[60
            , 60; 40, 80]);
      Engine.Components.Combustion combustion_model(burn_duration=
            burn_duration) annotation (extent=[-10, 20; 10, 40]);
      Engine.Components.SparkControl spark_control(spark_advance=spark_advance
        ) annotation (extent=[-24, 44; -4, 64]);
      Engine.Components.ChamberVolume chamber_volume annotation (extent=[56, -
            20; 76, 0]);
      OffsetShaft offset_shaft(shift=crank_shift) annotation (extent=[-20, -
            140; 20, -180]);
    equation 
      connect(crankslider.geom, geom) annotation (points=[22, -100; 80, -
            100; 80, -40; 80, -50; 110, -50], style(color=0));
      connect(chamber_volume.geom, geom) annotation (points=[77, -10; 80, -10
            ; 80, -40; 80, -50; 110, -50], style(color=0));
      connect(intake_valve.a, intake) annotation (points=[-40, 30; -80, 30; -
            100, 30; -100, 80], style(color=45));
      connect(exhaust_valve.a, exhaust) annotation (points=[40, 30; 80, 30; 80
            , 80; 100, 80], style(color=45));
      connect(piston.chamber, combustion_chamber.state) annotation (points=[
            5.55112e-16, -30; 5.55112e-16, -10], style(color=45));
      connect(intake_cam.valve_lift, intake_valve.lift) annotation (points=[-
            40, 70; -30, 70; -30, 40], style(color=57));
      connect(exhaust_cam.valve_lift, exhaust_valve.lift) annotation (points=[
            40, 70; 30, 70; 30, 40], style(color=57));
      connect(intake_cam.camshaft, timing_belt.camshaft) annotation (points=[-
            52.8, 70; -80, 70; -80, -28], style(color=9));
      connect(exhaust_cam.camshaft, timing_belt.camshaft) annotation (points=[
            52.8, 70; 68, 70; 68, 80; -80, 80; -80, -28], style(color=9));
      connect(intake_valve.b, combustion_chamber.state) annotation (points=[-
            30, 20; 5.55112e-16, -10], style(color=45));
      connect(combustion_chamber.state, exhaust_valve.b) annotation (points=[
            5.55112e-16, -10; 30, 20], style(color=45));
      connect(combustion_model.cylinder, combustion_chamber.state) annotation 
        (points=[5.55112e-16, 26; 5.55112e-16, -10], style(color=45));
      connect(combustion_model.crank, spark_control.crank) annotation (points=
            [-10, 26; -14, 26; -14, 44], style(color=9));
      connect(spark_control.spark, combustion_model.start) annotation (points=
            [-3, 54; 0, 54; 5.55112e-16, 41], style(color=81));
      connect(chamber_volume.volume, combustion_chamber.volume) annotation (
          points=[55, -10; 11, -10]);
      connect(combustion_chamber.mass, combustion_model.mass) annotation (
          points=[-6, 1; -6, 19]);
      connect(piston.geom, geom) annotation (points=[11, -40; 80, -40; 80, -50
            ; 110, -50], style(color=0));
      connect(piston.piston, crankslider.piston) annotation (points=[0, -42; 0
            , -80], style(color=61));
      connect(chamber_volume.piston, crankslider.piston) annotation (points=[
            66, -18; 66, -80; 0, -80], style(color=61));
      connect(offset_shaft.cyl, crankslider.crank) annotation (points=[0, -140
            ; 0, -108], style(color=0));
      connect(offset_shaft.crank, crankshaft) annotation (points=[-20, -160; -
            20, -200; 0, -200], style(color=0));
      connect(timing_belt.crankshaft, crankslider.crank) annotation (points=[-
            80, -56; -80, -108; 1.11022e-15, -108], style(color=0));
      connect(spark_control.crank, crankslider.crank) annotation (points=[-14
            , 44; -14, -108; 0, -108], style(color=0));
    end IndividualCylinder;
    model Cam "Valvetrain cam" 
      
      parameter Types.Degrees vo=40 "Valve Open";
      parameter Types.Degrees vc=205 "Valve Close";
      parameter Modelica.SIunits.Length max_lift=0.012 "Maximum valve lift";
      Types.Degrees local_ca "Local camshaft angle";
    protected 
      parameter Real norm=1.0/(vc - vo);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Icon(
          Ellipse(extent=[-78, 50; 22, -50], style(color=8, fillColor=8)), 
          Polygon(points=[-4, 44; 30, 26; 40, 14; 44, 0; 38, -20; 24, -32; 10
                , -38; -8, -46; -4, 44], style(color=8, fillColor=8)), 
          Rectangle(extent=[54, 4; 90, -4], style(
              color=0, 
              gradient=2, 
              fillColor=8)), 
          Ellipse(extent=[44, 6; 56, -6], style(color=0, fillColor=9)), 
          Text(extent=[-40, 80; 40, 60], string="%name")), 
        Window(
          x=0.19, 
          y=0.2, 
          width=0.6, 
          height=0.6), 
        Documentation(info="This is an idealized cam model that computes a cam profile from the valve timing (opening and closing) and the
maximum lift.
"));
    public 
      Modelica.Mechanics.Rotational.Interfaces.Flange_a camshaft annotation (
          extent=[-38, -10; -18, 10]);
      Modelica.Mechanics.Translational.Interfaces.Flange_a valve_lift 
        annotation (extent=[90, -10; 110, 10]);
    equation 
      assert(vc > vo + 20, "Invalid cam timings");
      camshaft.tau = 0;
      valve_lift.s = if (local_ca < vo or local_ca > vc) then 0.0 else 
        max_lift*Modelica.Math.sin((local_ca - vo)*norm*Modelica.Constants.PI)^
        2;
      local_ca = mod(camshaft.phi*180.0/Modelica.Constants.PI, 360);
      
    end Cam;
    model Reservoir "Infinite reservoir" 
      parameter Modelica.SIunits.Pressure P=101800 "Reservoir pressure";
      parameter Modelica.SIunits.Temperature T=300 "Reservoir temperature";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Diagram, 
        Window(
          x=0.39, 
          y=0.26, 
          width=0.6, 
          height=0.6), 
        Icon(
          Rectangle(extent=[-100, 100; 100, -90], style(color=0, fillColor=7))
            , 
          Text(extent=[-42, 90; 34, 66], string="P=%P"), 
          Line(points=[-60, 10; -40, 30; -20, 30; 0, 10; 0, -10; 20, -30; 40, 
                -30; 60, -10; 60, 10; 40, 30; 20, 30; 0, 10; 0, -10; -20, -30; 
                -40, -30; -60, -10; -60, 10], style(color=0)), 
          Text(extent=[-40, 70; 36, 46], string="T=%T"), 
          Text(extent=[-60, -74; 60, -52], string="%name")), 
        Documentation(info="This infinite reservoir model is capable of supplying any amount of mass or energy (via the mdot and q flow variables on the
Gas connector) to sustain a specified temperature and pressure.

These \"infinite\" models are interesting because instead of including constitutive relationships between
flow values (mass flow and power) and the potentials of the system (pressure and temperature), they instead
provide algebraic constraints involving only the states.  It is assumed that the flows will be calculated
such that the constraints will be satisfied.  This kind of model is analagous to an ideal voltage source (supplies
as much current as is necessary to sustain a specified voltage) or a mechanical ground (supplies as much
force as is necessary to sustain a specified position).
"));
      Interfaces.Gas tap annotation (extent=[-10, -110; 10, -90], layer="icon"
        );
    equation 
      tap.P = P;
      tap.T = T;
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
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Icon(
          Polygon(points=[-48, 32; -56, -8; -56, -48; -46, -76; -12, -76; 0, -
                48; 0, -8; -8, 32; -46, 32; -48, 32], style(color=0, fillColor=
                  9)), 
          Ellipse(extent=[-46, -10; -16, -68], style(color=0, fillColor=8)), 
          Ellipse(extent=[-36, -30; -26, -50], style(
              color=0, 
              gradient=2, 
              fillColor=8)), 
          Rectangle(extent=[-90, -30; -30, -50], style(gradient=2, fillColor=8
              )), 
          Polygon(points=[-8, 32; 72, 32; 84, -6; 84, -48; 74, -76; -12, -76; 
                0, -48; 0, -8; -8, 32; -8, 32], style(color=0, fillColor=8)), 
          Line(points=[0, -6; 84, -6], style(color=9)), 
          Line(points=[0, -48; 84, -48], style(color=0)), 
          Rectangle(extent=[-24, 48; -34, 32], style(color=0, fillColor=10)), 
          Rectangle(extent=[72, 48; 62, 32], style(color=0, fillColor=10)), 
          Ellipse(extent=[60, 70; 74, 40], style(color=0, fillColor=8)), 
          Line(points=[-36, 58; -46, -30], style(color=0)), 
          Rectangle(extent=[-28, 62; 68, 48], style(gradient=2, fillColor=8))
            , 
          Ellipse(extent=[-36, 70; -24, 44], style(color=0, fillColor=8)), 
          Line(points=[-24, 58; -16, -36], style(color=0)), 
          Rectangle(extent=[-16, 64; -10, 42], style(color=9, fillColor=9)), 
          Rectangle(extent=[-8, 68; -2, 46], style(color=9, fillColor=9)), 
          Rectangle(extent=[4, 66; 10, 44], style(color=9, fillColor=9)), 
          Rectangle(extent=[12, 64; 18, 42], style(color=9, fillColor=9)), 
          Rectangle(extent=[26, 68; 32, 46], style(color=9, fillColor=9)), 
          Rectangle(extent=[34, 66; 40, 44], style(color=9, fillColor=9)), 
          Rectangle(extent=[46, 64; 52, 42], style(color=9, fillColor=9)), 
          Rectangle(extent=[54, 66; 60, 44], style(color=9, fillColor=9)), 
          Rectangle(extent=[-16, 42; -10, 32], style(
              color=0, 
              fillColor=8, 
              fillPattern=7)), 
          Rectangle(extent=[-8, 44; -2, 32], style(
              color=0, 
              fillColor=8, 
              fillPattern=7)), 
          Rectangle(extent=[4, 44; 10, 32], style(
              color=0, 
              fillColor=8, 
              fillPattern=7)), 
          Rectangle(extent=[12, 42; 18, 32], style(
              color=0, 
              fillColor=8, 
              fillPattern=7)), 
          Rectangle(extent=[26, 44; 32, 32], style(
              color=0, 
              fillColor=8, 
              fillPattern=7)), 
          Rectangle(extent=[34, 44; 40, 32], style(
              color=0, 
              fillColor=8, 
              fillPattern=7)), 
          Rectangle(extent=[46, 42; 52, 32], style(
              color=0, 
              fillColor=8, 
              fillPattern=7)), 
          Rectangle(extent=[54, 44; 60, 32], style(
              color=0, 
              fillColor=8, 
              fillPattern=7)), 
          Line(points=[-100, 80; -48, 32], style(color=45, thickness=2)), 
          Line(points=[100, 80; 62, 32], style(color=45)), 
          Text(extent=[-60, -74; 80, -106], string="%name")), 
        Window(
          x=0.39, 
          y=0.34, 
          width=0.6, 
          height=0.6), 
        Documentation(info="An assembly of components required for an I4 engine.  This model requires a connection to intake and exhaust
gases, the crankshaft and geometry information.
"));
      replaceable model CylinderType = IndividualCylinder extends 
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
        evd=evd) annotation (extent=[-100, -20; -60, 40]);
      CylinderType cylinder2(
        crank_shift=360, 
        spark_advance=spark_advance, 
        burn_duration=burn_duration, 
        evo=evo, 
        ivo=ivo, 
        evc=evc, 
        ivc=ivc, 
        ivd=ivd, 
        evd=evd) annotation (extent=[0, -20; 40, 40]);
      CylinderType cylinder3(
        crank_shift=540, 
        spark_advance=spark_advance, 
        burn_duration=burn_duration, 
        evo=evo, 
        ivo=ivo, 
        evc=evc, 
        ivc=ivc, 
        ivd=ivd, 
        evd=evd) annotation (extent=[-50, -20; -10, 40]);
      CylinderType cylinder4(
        crank_shift=180, 
        spark_advance=spark_advance, 
        burn_duration=burn_duration, 
        evo=evo, 
        ivo=ivo, 
        evc=evc, 
        ivc=ivc, 
        ivd=ivd, 
        evd=evd) annotation (extent=[50, -20; 90, 40]);
      Modelica.Mechanics.Rotational.Inertia crankshaft_inertia(J=0.03, w(start
            =157)) annotation (extent=[-90, -60; -70, -40], rotation=90);
    equation 
      connect(cylinder1.intake, intake) annotation (points=[-100, 36; -100
            , 80], style(color=45));
      connect(cylinder3.intake, intake) annotation (points=[-50, 36; -50, 46; 
            -100, 46; -100, 80], style(color=45));
      connect(cylinder2.intake, intake) annotation (points=[-1.11022e-15, 38; 
            0, 46; -100, 46; -100, 80], style(color=45));
      connect(cylinder4.intake, intake) annotation (points=[50, 36; 50, 46; -
            100, 46; -100, 80], style(color=45));
      connect(cylinder1.exhaust, exhaust) annotation (points=[-60, 36; -60, 80
            ; 100, 80], style(color=45));
      connect(cylinder4.exhaust, exhaust) annotation (points=[90, 36; 100, 36
            ; 100, 80], style(color=45));
      connect(cylinder3.exhaust, exhaust) annotation (points=[-10, 36; -10, 80
            ; 100, 80], style(color=45));
      connect(cylinder2.exhaust, exhaust) annotation (points=[40, 38; 40, 80; 
            100, 80], style(color=45));
      connect(cylinder4.geom, engine_geometry) annotation (points=[92, 10; 96
            , 10; 96, 0; 110, 0], style(color=0));
      connect(cylinder2.geom, engine_geometry) annotation (points=[42, 12; 46
            , 10; 46, -50; 96, -50; 96, 0; 110, 0], style(color=0));
      connect(cylinder3.geom, engine_geometry) annotation (points=[-8, 10; -4
            , 10; -4, -50; 96, -50; 96, 0; 110, 0], style(color=0));
      connect(cylinder1.geom, engine_geometry) annotation (points=[-58, 10; -
            54, 10; -54, -50; 96, -50; 96, 0; 110, 0], style(color=0));
      connect(cylinder1.crankshaft, cylinder3.crankshaft) annotation (points=[
            -80, -19.6; -30, -19.6], style(color=10));
      connect(cylinder2.crankshaft, cylinder3.crankshaft) annotation (points=[
            20, -19.6; -30, -19.6], style(color=10));
      connect(cylinder4.crankshaft, cylinder2.crankshaft) annotation (points=[
            70, -19.6; 20, -19.6], style(color=10));
      connect(crankshaft_inertia.flange_b, cylinder1.crankshaft) annotation (
          points=[-80, -40; -80, -19.6], style(color=0));
      connect(crankshaft_inertia.flange_a, crankshaft) annotation (points=[-80
            , -60; -80, -70; -100, -70; -100, -40], style(color=0));
      power = crankshaft.tau*der(crankshaft.phi);
    end I4_Engine;
    model Manifold "A simple filling-and-emptying manifold model" 
      parameter Modelica.SIunits.Volume volume=0.004 "Manifold volume";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Icon(
          Rectangle(extent=[-80, 40; 80, -40], style(gradient=2, fillColor=8))
            , 
          Rectangle(extent=[-80, -40; -60, -80], style(gradient=1, fillColor=8
              )), 
          Rectangle(extent=[20, -40; 40, -80], style(gradient=1, fillColor=8))
            , 
          Rectangle(extent=[-40, -40; -20, -80], style(gradient=1, fillColor=8
              )), 
          Rectangle(extent=[60, -40; 80, -80], style(gradient=1, fillColor=8))
            , 
          Rectangle(extent=[-10, 80; 10, 40], style(gradient=1, fillColor=8))
            , 
          Line(points=[-6, 56; 6, 64], style(color=0, thickness=2)), 
          Ellipse(extent=[-2, 62; 2, 58], style(color=0, fillColor=0)), 
          Line(points=[-100, 0; -90, 0; -90, 60; 0, 60]), 
          Text(extent=[20, 80; 100, 60], string="%name")), 
        Window(
          x=0.34, 
          y=0.19, 
          width=0.6, 
          height=0.6), 
        Documentation(info="This very simple model contains a throttle and a control volume which
can be connected to the intake system of an engine (or cylinder) in
order to simulate the effects of manifold filling and emptying.  A
throttle position of 90 degrees corresponds to wide open throttle (WOT)
while a throttle position of 0 degrees corresponds to a closed throttle.
"));
      Engine.Components.ControlVolume manifold_volume annotation (extent=[-40
            , -40; 40, 40]);
      Modelica.Blocks.Sources.Constant volume_value(final k={volume}) 
        annotation (extent=[40, -60; 60, -40]);
      Interfaces.Gas ambient annotation (extent=[-10, 90; 10, 110]);
      Interfaces.Gas manifold annotation (extent=[-10, -110; 10, -90], layer=
            "icon");
      Modelica.Blocks.Interfaces.InPort throttle_angle(final n=1) annotation (
          extent=[-120, -10; -100, 10], layer="icon");
      Engine.Components.Throttle throttle(dia=0.10) annotation (extent=[-20, 
            80; 20, 40], rotation=90);
    equation 
      connect(volume_value.outPort, manifold_volume.volume) annotation (
          points=[61, -50; 80, -50; 80, 0; 44, 2.22045e-015]);
      connect(manifold_volume.state, manifold) annotation (points=[
            2.22045e-015, 2.22045e-015; 0, -100], style(color=45));
      connect(throttle.b, manifold_volume.state) annotation (points=[20, 60; 
            20, 0; 2.22045e-015, 2.22045e-015], style(color=45));
      connect(throttle.a, ambient) annotation (points=[-1.11022e-016, 80; 0, 
            100], style(color=45));
      connect(throttle_angle, throttle.throttle_angle) annotation (points=[-
            110, 0; -60, 0; -60, 60; -22, 60]);
    end Manifold;
  end Components;
  annotation (
    Coordsys(
      extent=[0, 0; 842, 836], 
      grid=[1, 1], 
      component=[20, 20]), 
    Window(
      x=0.42, 
      y=0.12, 
      width=0.54, 
      height=0.8, 
      library=1, 
      autolayout=1), 
    Documentation(info="This package contains numerous engine component models and a complete I4 engine model.
"), 
    Icon(
      Ellipse(extent=[-84, -22; -38, -42], style(color=0, fillColor=8)), 
      Ellipse(extent=[-84, -20; -38, -40], style(gradient=3, fillColor=8)), 
      Rectangle(extent=[-64, 22; -59, -30], style(
          color=0, 
          gradient=1, 
          fillColor=8)), 
      Ellipse(extent=[19, -79; 25, -85], style(color=0, fillColor=0)), 
      Line(points=[22, -82; 36, -71; 21, -39], style(color=0)), 
      Rectangle(extent=[3, -23; 37, -39], style(gradient=1, fillColor=8))));
end Engine;
