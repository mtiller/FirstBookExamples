within FirstBookExamples.Chapter9;
package Pneumatic
  package Interfaces
    connector Port
      Real x;
    end Port;
  end Interfaces;

  model Valve
    Pneumatic.Interfaces.Port p1 annotation (Placement(transformation(
            extent={{-110,10},{-90,30}})));
    Interfaces.Port p2 annotation (Placement(transformation(extent={{
              90,10},{110,30}})));
    connector Port
      extends Interfaces.Port;
    end Port;
    Port p3 annotation (Placement(transformation(extent={{-110,-30},{
              -90,-10}})));
  end Valve;

  model Pump
    import FirstBookExamples.Chapter9.Pneumatic.Interfaces.Port;
    Port p1 annotation (Placement(transformation(extent={{-110,-10},{
              -90,10}})));
  end Pump;

  encapsulated model Test
    import FirstBookExamples.Chapter9.Pneumatic;
    Pneumatic.Valve v annotation (Placement(transformation(extent={{
              -60,0},{-40,20}})));
    Pneumatic.Pump p annotation (Placement(transformation(extent={{20,
              0},{40,20}})));
  end Test;
end Pneumatic;
