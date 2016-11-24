within FirstBookExamples.Chapter6;
model TernarySystem "Earth, Moon & Sun"
  extends BinarySystem;
  Body moon(
    M=7.349e+22,
    init_v={0,29290 + 1020,0},
    init_x={152484e+6,0,0}) annotation (Placement(transformation(
          extent={{12,-74},{46,-42}})));
  GravitationalAttraction moon_earth annotation (Placement(
        transformation(extent={{12,-30},{50,6}})));
  GravitationalAttraction moon_sun annotation (Placement(
        transformation(extent={{-92,16},{-58,50}})));
equation
  connect(moon_earth.b1, moon.b)
    annotation (Line(points={{12,-12},{6,-12},{6,-58},{12,-58}}));
  connect(moon_earth.b2, earth.b)
    annotation (Line(points={{50,-12},{58,-12},{58,14},{-6,14},{-6,45},
          {2,45}}));
  connect(moon_sun.b1, moon.b)
    annotation (Line(points={{-92,33},{-96,33},{-96,-58},{12,-58}}));
  connect(moon_sun.b2, sun.b)
    annotation (Line(points={{-58,33},{-58,46},{-48,46},{-48,45}}));
  annotation (experiment(StopTime=31.5581e+6),
              __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter6/TernarySystem.mos" "Simulate TernarySystem"));
end TernarySystem;
