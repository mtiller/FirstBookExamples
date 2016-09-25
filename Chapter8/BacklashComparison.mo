package BacklashComparison 
  extends BookExamples.Icons.BookExample;
  partial model NoRigid 
    import Modelica.Mechanics.Rotational;
    
    Rotational.Inertia I1 annotation (extent=[-38, -8; -18, 12]);
    Rotational.Inertia I2(J=3) annotation (extent=[18, -8; 38, 12]);
    Rotational.Torque torque annotation (extent=[-66, -8; -46, 12]);
    Modelica.Blocks.Sources.Sine signal annotation (extent=[-98, -8; -78, 12]);
    replaceable Rotational.Interfaces.Compliant backlash
      annotation (extent=[-10, -8; 10, 12]);
  equation 
    connect(signal.outPort, torque.inPort) annotation (points=[-77, 2; -68, 2]);
    connect(torque.flange_b, I1.flange_a) annotation (points=[-46, 2; -38, 2]);
    connect(I1.flange_b, backlash.flange_a)
      annotation (points=[-18, 2; -10, 2]);
    connect(backlash.flange_b, I2.flange_a) annotation (points=[10, 2; 18, 2]);
  end NoRigid;

  partial model Rigid 
    extends NoRigid;
    import Modelica.Mechanics.Rotational;
    Rotational.IdealGear gear annotation (extent=[48, -8; 68, 12]);
    Rotational.Inertia I3 annotation (extent=[78, -8; 98, 12]);
  equation 
    connect(gear.flange_b, I3.flange_a) annotation (points=[68, 2; 78, 2]);
    connect(I2.flange_b, gear.flange_a) annotation (points=[38, 2; 48, 2]);
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
    extends BookExamples.Icons.RunnableExample;
    annotation (experiment(StopTime=1),
                Commands(file="BacklashComparison.mos" "Run backlash comparison"));
    NoRigid_Nonlinear nr_nl;
    Rigid_Nonlinear r_nl;
    NoRigid_COR nr_cor;
    Rigid_COR r_cor;
  end Comparison;
end BacklashComparison;
