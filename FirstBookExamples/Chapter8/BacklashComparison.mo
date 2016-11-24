within FirstBookExamples.Chapter8;
package BacklashComparison
  extends FirstBookExamples.Icons.BookExample;
  partial model NoRigid
    import Modelica.Mechanics.Rotational;

    Modelica.Mechanics.Rotational.Components.Inertia I1(J=1)
                                                        annotation (
        Placement(transformation(extent={{-40,-10},{-20,10}})));
    Modelica.Mechanics.Rotational.Components.Inertia I2(J=3)
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque
                 annotation (Placement(transformation(extent={{-70,-10},
              {-50,10}})));
    Modelica.Blocks.Sources.Sine signal(freqHz=1)
                                        annotation (Placement(
          transformation(extent={{-100,-10},{-80,10}})));
    replaceable
      Modelica.Mechanics.Rotational.Interfaces.PartialCompliant
      backlash annotation (Placement(transformation(extent={{-10,-10},
              {10,10}})));
  equation
    connect(torque.flange, I1.flange_a)
      annotation (Line(points={{-50,0},{-42,0},{-40,0}}));
    connect(I1.flange_b, backlash.flange_a)
      annotation (Line(points={{-20,0},{-14,0},{-10,0}}));
    connect(backlash.flange_b, I2.flange_a) annotation (Line(points={{10,0},{
            20,0}}));
    connect(torque.tau, signal.y)
      annotation (Line(points={{-72,0},{-79,0}}, color={0,0,127}));
  end NoRigid;

  partial model Rigid
    extends NoRigid;
    import Modelica.Mechanics.Rotational;
    Modelica.Mechanics.Rotational.Components.IdealGear gear(
        useSupport=false, ratio=1)
                          annotation (Placement(transformation(extent={{50,-10},
              {70,10}})));
    Modelica.Mechanics.Rotational.Components.Inertia I3(J=1)
                                                        annotation (
        Placement(transformation(extent={{80,-10},{100,10}})));
  equation
    connect(gear.flange_b, I3.flange_a) annotation (Line(points={{70,0},{
            80,0}}));
    connect(I2.flange_b, gear.flange_a) annotation (Line(points={{40,0},{
            50,0}}));
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
                __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter8/BacklashComparison.mos" "Run backlash comparison"));
  end Comparison;
end BacklashComparison;
