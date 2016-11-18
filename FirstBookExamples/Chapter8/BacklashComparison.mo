within FirstBookExamples.Chapter8;
package BacklashComparison
  extends FirstBookExamples.Icons.BookExample;
  partial model NoRigid
    import Modelica.Mechanics.Rotational;

    Modelica.Mechanics.Rotational.Components.Inertia I1 annotation (
        Placement(transformation(extent={{-38,-8},{-18,12}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Components.Inertia I2(J=3)
      annotation (Placement(transformation(extent={{18,-8},{38,12}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=
          false) annotation (Placement(transformation(extent={{-66,-8},
              {-46,12}}, rotation=0)));
    Modelica.Blocks.Sources.Sine signal annotation (Placement(
          transformation(extent={{-98,-8},{-78,12}}, rotation=0)));
    replaceable
      Modelica.Mechanics.Rotational.Interfaces.PartialCompliant
      backlash annotation (Placement(transformation(extent={{-10,-8},
              {10,12}}, rotation=0)));
  equation
    connect(signal.y, torque.u) annotation (Line(points={{-77,2},{-68,
            2}}));
    connect(torque.flange, I1.flange_a)
      annotation (Line(points={{-46,2},{-38,2}}));
    connect(I1.flange_b, backlash.flange_a)
      annotation (Line(points={{-18,2},{-10,2}}));
    connect(backlash.flange_b, I2.flange_a) annotation (Line(points={
            {10,2},{18,2}}));
  end NoRigid;

  partial model Rigid
    extends NoRigid;
    import Modelica.Mechanics.Rotational;
    Modelica.Mechanics.Rotational.Components.IdealGear gear(
        useSupport=false) annotation (Placement(transformation(extent=
             {{48,-8},{68,12}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia I3 annotation (
        Placement(transformation(extent={{78,-8},{98,12}}, rotation=0)));
  equation
    connect(gear.flange_b, I3.flange_a) annotation (Line(points={{68,
            2},{78,2}}));
    connect(I2.flange_b, gear.flange_a) annotation (Line(points={{38,
            2},{48,2}}));
  end Rigid;

  model NoRigid_Nonlinear
    extends NoRigid(redeclare SpringBacklash backlash(b=0.01));
  end NoRigid_Nonlinear;

  model Rigid_Nonlinear
    extends Rigid(I2(J=2), redeclare SpringBacklash backlash(b=0.01));
  end Rigid_Nonlinear;

  model NoRigid_COR
    extends NoRigid(redeclare BacklashCOR backlash(b=0.01, I2=3));
  end NoRigid_COR;

  model Rigid_COR
    extends Rigid(I2(J=2), redeclare BacklashCOR backlash(b=0.01, I2=2));
  end Rigid_COR;

  model Comparison
    extends FirstBookExamples.Icons.RunnableExample;
    NoRigid_Nonlinear nr_nl;
    Rigid_Nonlinear r_nl;
    NoRigid_COR nr_cor;
    Rigid_COR r_cor;
    annotation (experiment(StopTime=1),
                __Dymola_Commands(file="BacklashComparison.mos" "Run backlash comparison"));
  end Comparison;
end BacklashComparison;
