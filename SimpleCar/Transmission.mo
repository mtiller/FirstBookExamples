package Transmission "Transmissions and transmission components" 
  extends Modelica.Icons.Library2;
  model FiveSpeed "A simple five speed transmission" 
    extends Interfaces.Transmission;
    parameter Real first_gear=4.14 "Gear ratio of first gear";
    parameter Real second_gear=2.37 "Gear ratio of second gear";
    parameter Real third_gear=1.42 "Gear ratio of third gear";
    parameter Real fourth_gear=1.0 "Gear ratio of fourth gear";
    parameter Real fifth_gear=0.76 "Gear ratio of fifth gear";
    parameter Real k_on=2 "Gain for clutch engagements";
    parameter Real k_off=6 "Gain for clutch disengagement";
  protected 
    Real clutch_activation_levels[5] "Clutch Pseudo-pressure";
    Real clutch_requested_levels[5] "Requested clutch pseudo-pressure";
    Modelica.Mechanics.Rotational.Inertia inertia_driveline_side(J=0.03) 
      "Inertia for driveline side of the transmission" annotation (extent=[-72
          , -10; -52, 10]);
    Modelica.Mechanics.Rotational.IdealGear gear1(ratio=first_gear) 
      annotation (extent=[-16, 50; 4, 70], rotation=180);
    Modelica.Mechanics.Rotational.IdealGear gear2(ratio=second_gear) 
      annotation (extent=[-16, 20; 4, 40], rotation=180);
    Modelica.Mechanics.Rotational.IdealGear gear3(ratio=third_gear) 
      annotation (extent=[-16, -10; 4, 10], rotation=180);
    Modelica.Mechanics.Rotational.IdealGear gear4(ratio=fourth_gear) 
      annotation (extent=[-16, -40; 4, -20], rotation=180);
    Modelica.Mechanics.Rotational.IdealGear gear5(ratio=fifth_gear) 
      annotation (extent=[-16, -70; 4, -50], rotation=180);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.29, 
        y=0.22, 
        width=0.6, 
        height=0.6), 
      Icon(
        Rectangle(extent=[-92, 10; -60, -10], style(gradient=2, fillColor=8))
          , 
        Rectangle(extent=[90, 10; 60, -10], style(gradient=2, fillColor=8)), 
        Polygon(points=[60, 10; 60, 40; 50, 40; 30, 20; -20, 20; -40, 10; -60
              , 10; -60, -10; -40, -10; -30, -30; -20, -30; -16, -26; -6, -36; 
              30, -36; 40, -26; 50, -40; 60, -40; 60, 10], style(color=10, 
              fillColor=8)), 
        Line(points=[56, 26; 50, 26; 40, 18], style(color=0)), 
        Line(points=[56, 14; 50, 14; 42, 10], style(color=0)), 
        Line(points=[56, 0; 36, 0], style(color=0)), 
        Line(points=[56, -16; 50, -16; 44, -14], style(color=0)), 
        Line(points=[56, -30; 52, -30; 46, -26], style(color=0)), 
        Line(points=[-12, -24; -10, -24; 36, -24], style(color=0)), 
        Line(points=[-32, 4; -18, 12; 24, 12], style(color=0)), 
        Line(points=[-20, -2; -18, -2; 8, -2], style(color=0)), 
        Text(extent=[-60, 60; 60, 40], string="%name")), 
      Documentation(info="This transmission has five different gears representing the different \"speeds\" of the
transmission.  This is the mechanical side of the transmission.  The logic of which
gear the transmission should be in is external and provided via a gear selector
connector.  This is neither a traditional automatic or manual transmission.  The
type of transmission that this model is closest to is probably an automatic
shift manual.  The idea behind this transmission is that everytime a new gear
is selected, the clutch pressure for that gear is reduced (using the gain parameter
k_off) and the clutch pressure of the new gear is increased.  This should approximate
the dynamics of disengaging and engaging the clutch in a manual transmission.
"));
    Modelica.Mechanics.Rotational.Clutch first_gear_clutch(fn_max=2000) 
      annotation (extent=[24, 50; 44, 70]);
    Modelica.Mechanics.Rotational.Clutch second_gear_clutch(fn_max=2000) 
      annotation (extent=[24, 20; 44, 40]);
    Modelica.Mechanics.Rotational.Clutch third_gear_clutch(fn_max=2000) 
      annotation (extent=[24, -10; 44, 10]);
    Modelica.Mechanics.Rotational.Clutch fourth_gear_clutch(fn_max=2000) 
      annotation (extent=[24, -40; 44, -20]);
    Modelica.Mechanics.Rotational.Clutch fifth_gear_clutch(fn_max=2000) 
      annotation (extent=[24, -70; 44, -50]);
    Modelica.Mechanics.Rotational.Inertia inertia_engine_side(J=0.03) 
      "Inertia on the engine side" annotation (extent=[60, -10; 80, 10]);
  equation 
    connect(driveline, inertia_driveline_side.flange_a) annotation (points=[
          -100, 0; -72, 5.55112e-16], style(color=10));
    connect(gear1.flange_a, first_gear_clutch.flange_a) annotation (points=[4
          , 60; 24, 60]);
    connect(gear1.flange_b, inertia_driveline_side.flange_b) annotation (
        points=[-16, 60; -34, 60; -34, 0; -52, 5.55112e-16], style(color=10));
    connect(gear2.flange_b, inertia_driveline_side.flange_b) annotation (
        points=[-16, 30; -34, 30; -34, 0; -52, 5.55112e-16], style(color=10));
    connect(gear2.flange_a, second_gear_clutch.flange_a) annotation (points=[4
          , 30; 24, 30], style(color=10));
    connect(gear3.flange_a, third_gear_clutch.flange_a) annotation (points=[4
          , -7.21645e-16; 24, 5.55112e-16], style(color=10));
    connect(gear3.flange_b, inertia_driveline_side.flange_b) annotation (
        points=[-16, 1.83187e-15; -52, 5.55112e-16], style(color=10));
    connect(gear4.flange_a, fourth_gear_clutch.flange_a) annotation (points=[4
          , -30; 24, -30], style(color=10));
    connect(gear4.flange_b, inertia_driveline_side.flange_b) annotation (
        points=[-16, -30; -34, -30; -34, 0; -52, 5.55112e-16], style(color=10))
      ;
    connect(gear5.flange_a, fifth_gear_clutch.flange_a) annotation (points=[4
          , -60; 24, -60], style(color=10));
    connect(gear5.flange_b, inertia_driveline_side.flange_b) annotation (
        points=[-16, -60; -34, -60; -34, 0; -52, 5.55112e-16], style(color=10))
      ;
    connect(inertia_engine_side.flange_b, engine) annotation (points=[80, 
          5.55112e-16; 100, 0], style(color=10));
    connect(inertia_engine_side.flange_a, third_gear_clutch.flange_b) 
      annotation (points=[60, 5.55112e-16; 44, 5.55112e-16], style(color=10));
    connect(inertia_engine_side.flange_a, second_gear_clutch.flange_b) 
      annotation (points=[60, 5.55112e-16; 60, 30; 44, 30], style(color=10));
    connect(first_gear_clutch.flange_b, inertia_engine_side.flange_a) 
      annotation (points=[44, 60; 60, 60; 60, 5.55112e-16], style(color=10));
    connect(fourth_gear_clutch.flange_b, inertia_engine_side.flange_a) 
      annotation (points=[44, -30; 60, -30; 60, 5.55112e-16], style(color=10));
    connect(fifth_gear_clutch.flange_b, inertia_engine_side.flange_a) 
      annotation (points=[44, -60; 60, -60; 60, 5.55112e-16], style(color=10));
    for i in 1:5 loop
      der(clutch_activation_levels[i]) = if noEvent(clutch_activation_levels[i
        ] > clutch_requested_levels[i]) then -k_off*(clutch_activation_levels[i
        ] - clutch_requested_levels[i]) else -k_on*(clutch_activation_levels[i]
         - clutch_requested_levels[i]);
    end for;
    first_gear_clutch.inPort.signal[1] = clutch_activation_levels[1];
    second_gear_clutch.inPort.signal[1] = clutch_activation_levels[2];
    third_gear_clutch.inPort.signal[1] = clutch_activation_levels[3];
    fourth_gear_clutch.inPort.signal[1] = clutch_activation_levels[4];
    fifth_gear_clutch.inPort.signal[1] = clutch_activation_levels[5];
  algorithm 
    clutch_requested_levels := zeros(5);
    if (gear_selector.gear >= 1 and gear_selector.gear <= 5) then
      clutch_requested_levels[gear_selector.gear] := 1;
    end if;
  end FiveSpeed;
  model SportsCarTransmission 
    "Five speed transmission with typical gear ratios of a sports car" 
    extends FiveSpeed(
      first_gear=3.97, 
      second_gear=2.34, 
      third_gear=1.46, 
      fourth_gear=1.0, 
      fifth_gear=0.79);
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
      Documentation(info="This is a specialized five speed transmission.  The particular gear ratios used for this
transmission correspond to the gear ratios of a sports car."));
  end SportsCarTransmission;
  annotation (
    Coordsys(
      extent=[0, 0; 434, 373], 
      grid=[1, 1], 
      component=[20, 20]), 
    Window(
      x=0.46, 
      y=0.03, 
      width=0.28, 
      height=0.42, 
      library=1, 
      autolayout=1), 
    Documentation(info="This package contains transmission related models."), 
    Icon(
      Polygon(points=[51, -26; 51, 4; 41, 4; 21, -16; -29, -16; -49, -26; -69
            , -26; -69, -46; -49, -46; -39, -66; -29, -66; -25, -62; -15, -72; 
            21, -72; 31, -62; 41, -76; 51, -76; 51, -26], style(color=10, 
            fillColor=8)), 
      Line(points=[-41, -32; -27, -24; 15, -24], style(color=0)), 
      Line(points=[-29, -38; -27, -38; -1, -38], style(color=0)), 
      Line(points=[-21, -60; -19, -60; 27, -60], style(color=0)), 
      Line(points=[47, -66; 43, -66; 37, -62], style(color=0)), 
      Line(points=[47, -52; 41, -52; 35, -50], style(color=0)), 
      Line(points=[47, -36; 27, -36], style(color=0)), 
      Line(points=[47, -22; 41, -22; 33, -26], style(color=0)), 
      Line(points=[47, -10; 41, -10; 31, -18], style(color=0))));
  model SimpleShiftStrategy "A simple shifting strategy" 
    extends Interfaces.ShiftStrategy;
    parameter Integer ngears=5;
    parameter Types.KilometersPerHour up_shift_schedule[ngears - 1];
    Integer cur_gear;
    
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.39, 
        y=0.25, 
        width=0.6, 
        height=0.6), 
      Documentation(info="This simple shifting strategy specifies the speeds at which the transmission should
upshift (increase the gear).  No provision has been included in this transmission
for downshifting (since the only current application of this strategy is in a
racing simulation).

The up_shift_schedule array contains the top speed for each gear (except the last
gear since there is no gear after that to upshift to).  Speeds are specified in
kilometers per hour.

"));
  equation 
    gear_request.gear = cur_gear;
    //  cur_gear = 1;
    assert(min(up_shift_schedule) > 1, "Error in shift schedule");
  algorithm 
    when initial() then
      cur_gear := 1;
    end when;
    when (cur_gear < ngears and kph > up_shift_schedule[cur_gear]) then
      cur_gear := cur_gear + 1;
    end when;
  end SimpleShiftStrategy;
end Transmission;
