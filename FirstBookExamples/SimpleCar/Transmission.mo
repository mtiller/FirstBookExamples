within FirstBookExamples.SimpleCar;
package Transmission "Transmissions and transmission components"
  extends Modelica.Icons.Package;
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
    Modelica.Mechanics.Rotational.Components.Inertia
      inertia_driveline_side(J=0.03)
      "Inertia for driveline side of the transmission" annotation (
        Placement(transformation(extent={{-72,-10},{-52,10}})));
    Modelica.Mechanics.Rotational.Components.IdealGear gear1(ratio=
          first_gear, useSupport=false) annotation (Placement(
          transformation(
          origin={-6,60},
          extent={{-10,-10},{10,10}},
          rotation=180)));
    Modelica.Mechanics.Rotational.Components.IdealGear gear2(ratio=
          second_gear, useSupport=false) annotation (Placement(
          transformation(
          origin={-6,30},
          extent={{-10,-10},{10,10}},
          rotation=180)));
    Modelica.Mechanics.Rotational.Components.IdealGear gear3(ratio=
          third_gear, useSupport=false) annotation (Placement(
          transformation(
          origin={-6,0},
          extent={{-10,-10},{10,10}},
          rotation=180)));
    Modelica.Mechanics.Rotational.Components.IdealGear gear4(ratio=
          fourth_gear, useSupport=false) annotation (Placement(
          transformation(
          origin={-6,-30},
          extent={{-10,-10},{10,10}},
          rotation=180)));
    Modelica.Mechanics.Rotational.Components.IdealGear gear5(ratio=
          fifth_gear, useSupport=false) annotation (Placement(
          transformation(
          origin={-6,-60},
          extent={{-10,-10},{10,10}},
          rotation=180)));
    Modelica.Mechanics.Rotational.Components.Clutch first_gear_clutch(
        fn_max=2000) annotation (Placement(transformation(extent={{24,
              50},{44,70}})));
    Modelica.Mechanics.Rotational.Components.Clutch
      second_gear_clutch(fn_max=2000) annotation (Placement(
          transformation(extent={{24,20},{44,40}})));
    Modelica.Mechanics.Rotational.Components.Clutch third_gear_clutch(
        fn_max=2000) annotation (Placement(transformation(extent={{24,
              -10},{44,10}})));
    Modelica.Mechanics.Rotational.Components.Clutch
      fourth_gear_clutch(fn_max=2000) annotation (Placement(
          transformation(extent={{24,-40},{44,-20}})));
    Modelica.Mechanics.Rotational.Components.Clutch fifth_gear_clutch(
        fn_max=2000) annotation (Placement(transformation(extent={{24,
              -70},{44,-50}})));
    Modelica.Mechanics.Rotational.Components.Inertia
      inertia_engine_side(J=0.03) "Inertia on the engine side"
      annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  equation
    connect(driveline, inertia_driveline_side.flange_a) annotation (Line(
          points={{-100,0},{-72,5.55112e-16}}, color={128,128,128}));
    connect(gear1.flange_a, first_gear_clutch.flange_a) annotation (Line(
          points={{4,60},{24,60}}));
    connect(gear1.flange_b, inertia_driveline_side.flange_b) annotation (Line(
          points={{-16,60},{-34,60},{-34,0},{-52,5.55112e-16}}, color=
           {128,128,128}));
    connect(gear2.flange_b, inertia_driveline_side.flange_b) annotation (Line(
          points={{-16,30},{-34,30},{-34,0},{-52,5.55112e-16}}, color=
           {128,128,128}));
    connect(gear2.flange_a, second_gear_clutch.flange_a) annotation (Line(
          points={{4,30},{24,30}}, color={128,128,128}));
    connect(gear3.flange_a, third_gear_clutch.flange_a) annotation (Line(
          points={{4,-7.21645e-16},{24,5.55112e-16}}, color={128,128,
            128}));
    connect(gear3.flange_b, inertia_driveline_side.flange_b) annotation (Line(
          points={{-16,1.83187e-15},{-52,5.55112e-16}}, color={128,
            128,128}));
    connect(gear4.flange_a, fourth_gear_clutch.flange_a) annotation (Line(
          points={{4,-30},{24,-30}}, color={128,128,128}));
    connect(gear4.flange_b, inertia_driveline_side.flange_b) annotation (Line(
          points={{-16,-30},{-34,-30},{-34,0},{-52,5.55112e-16}},
          color={128,128,128}));
    connect(gear5.flange_a, fifth_gear_clutch.flange_a) annotation (Line(
          points={{4,-60},{24,-60}}, color={128,128,128}));
    connect(gear5.flange_b, inertia_driveline_side.flange_b) annotation (Line(
          points={{-16,-60},{-34,-60},{-34,0},{-52,5.55112e-16}},
          color={128,128,128}));
    connect(inertia_engine_side.flange_b, engine) annotation (Line(
          points={{80,5.55112e-16},{100,0}}, color={128,128,128}));
    connect(inertia_engine_side.flange_a, third_gear_clutch.flange_b)
      annotation (Line(points={{60,5.55112e-16},{44,5.55112e-16}},
          color={128,128,128}));
    connect(inertia_engine_side.flange_a, second_gear_clutch.flange_b)
      annotation (Line(points={{60,5.55112e-16},{60,30},{44,30}},
          color={128,128,128}));
    connect(first_gear_clutch.flange_b, inertia_engine_side.flange_a)
      annotation (Line(points={{44,60},{60,60},{60,5.55112e-16}},
          color={128,128,128}));
    connect(fourth_gear_clutch.flange_b, inertia_engine_side.flange_a)
      annotation (Line(points={{44,-30},{60,-30},{60,5.55112e-16}},
          color={128,128,128}));
    connect(fifth_gear_clutch.flange_b, inertia_engine_side.flange_a)
      annotation (Line(points={{44,-60},{60,-60},{60,5.55112e-16}},
          color={128,128,128}));
    for i in 1:5 loop
      der(clutch_activation_levels[i]) = if noEvent(clutch_activation_levels[i]
          > clutch_requested_levels[i]) then -k_off*(clutch_activation_levels[i]
          - clutch_requested_levels[i]) else -k_on*(clutch_activation_levels[i]
         - clutch_requested_levels[i]);
    end for;
    first_gear_clutch.f_normalized = clutch_activation_levels[1];
    second_gear_clutch.f_normalized = clutch_activation_levels[2];
    third_gear_clutch.f_normalized = clutch_activation_levels[3];
    fourth_gear_clutch.f_normalized = clutch_activation_levels[4];
    fifth_gear_clutch.f_normalized = clutch_activation_levels[5];
  algorithm
    clutch_requested_levels := zeros(5);
    if (gear_selector.gear >= 1 and gear_selector.gear <= 5) then
      clutch_requested_levels[gear_selector.gear] := 1;
    end if;
    annotation (
      Icon(graphics={
          Rectangle(
            extent={{-92,10},{-60,-10}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Rectangle(
            extent={{90,10},{60,-10}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Polygon(
            points={{60,10},{60,40},{50,40},{30,20},{-20,20},{-40,10},
                {-60,10},{-60,-10},{-40,-10},{-30,-30},{-20,-30},{-16,
                -26},{-6,-36},{30,-36},{40,-26},{50,-40},{60,-40},{60,
                10}},
            lineColor={128,128,128},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{56,26},{50,26},{40,18}}, color={0,0,0}),
          Line(points={{56,14},{50,14},{42,10}}, color={0,0,0}),
          Line(points={{56,0},{36,0}}, color={0,0,0}),
          Line(points={{56,-16},{50,-16},{44,-14}}, color={0,0,0}),
          Line(points={{56,-30},{52,-30},{46,-26}}, color={0,0,0}),
          Line(points={{-12,-24},{-10,-24},{36,-24}}, color={0,0,0}),
          Line(points={{-32,4},{-18,12},{24,12}}, color={0,0,0}),
          Line(points={{-20,-2},{-18,-2},{8,-2}}, color={0,0,0}),
          Text(extent={{-60,60},{60,40}}, textString=
                                              "%name")}),
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
  end FiveSpeed;

  model SimpleShiftStrategy "A simple shifting strategy"
    extends Interfaces.ShiftStrategy;
    parameter Integer ngears=5;
    parameter Types.KilometersPerHour up_shift_schedule[ngears - 1];
    Integer cur_gear;

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
    annotation (
      Documentation(info="This simple shifting strategy specifies the speeds at which the transmission should
upshift (increase the gear).  No provision has been included in this transmission
for downshifting (since the only current application of this strategy is in a
racing simulation).

The up_shift_schedule array contains the top speed for each gear (except the last
gear since there is no gear after that to upshift to).  Speeds are specified in
kilometers per hour.

"));
  end SimpleShiftStrategy;

  model SportsCarTransmission
    "Five speed transmission with typical gear ratios of a sports car"
    extends Transmission.FiveSpeed(
      first_gear=3.97,
      second_gear=2.34,
      third_gear=1.46,
      fourth_gear=1.0,
      fifth_gear=0.79);
    annotation (
      Documentation(info="This is a specialized five speed transmission.  The particular gear ratios used for this
transmission correspond to the gear ratios of a sports car."));
  end SportsCarTransmission;
  annotation (
    Documentation(info="This package contains transmission related models."));
end Transmission;
