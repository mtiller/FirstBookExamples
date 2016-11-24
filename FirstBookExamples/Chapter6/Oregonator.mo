within FirstBookExamples.Chapter6;
package Oregonator
  extends FirstBookExamples.Icons.BookExample;
  // Based on http://www.georgetown.edu/earleyj/n64298.html
  // http://www.georgetown.edu/earleyj/jeemain.html
  constant Integer A=1 "BrO3(-)";
  constant Integer B=2 "Organic Species";
  constant Integer P=3 "HOBr";
  constant Integer X=4 "HBrO2";
  constant Integer Y=5 "Br(-)";
  constant Integer Z=6 "Ce4+";
  constant Integer nspecies=6;

  package Reactions
    model R_AY
      parameter Real k_AY=1.0;
      extends Chemistry.Basic.Reaction(
        k=k_AY,
        reactants={{1,A},{1,Y}},
        products={{1,X},{1,P}});
    end R_AY;

    model R_XY
      parameter Real k_XY=1.0;
      extends Chemistry.Basic.Reaction(
        k=k_XY,
        reactants={{1,X},{1,Y}},
        products={{2,P}});
    end R_XY;

    model R_AX
      parameter Real k_AX=50.0;
      extends Chemistry.Basic.Reaction(
        k=k_AX,
        reactants={{1,A},{1,X}},
        products={{2,X},{2,Z}});
    end R_AX;

    model R_2X
      parameter Real k_2X=2*0.0013;
      extends Chemistry.Basic.Reaction(
        k=k_2X,
        reactants={{2,X}},
        products={{1,A},{1,P}});
    end R_2X;

    model R_BZ
      parameter Real k_BZ=1.0;
      extends Chemistry.Basic.Reaction(
        k=k_BZ,
        reactants={{1,B},{1,Z}},
        products={{1,Y}});
    end R_BZ;
  end Reactions;

  model ChemicalSystem
    extends FirstBookExamples.Icons.RunnableExample;
    Chemistry.Basic.Volume v(
      nspecies=nspecies,
      v=1,
      i_moles=fill(1, nspecies)) annotation (Placement(transformation(
            extent={{-60,32},{-40,52}})));
    Reactions.R_AY r_ay(nspecies=nspecies, v=1)
      annotation (Placement(transformation(extent={{-20,32},{0,52}})));
    Reactions.R_XY r_xy(nspecies=nspecies, v=1)
      annotation (Placement(transformation(extent={{40,32},{60,52}})));
    Reactions.R_AX r_ax(nspecies=nspecies, v=1)
      annotation (Placement(transformation(extent={{-58,-20},{-38,0}})));
    Reactions.R_2X r_2x(nspecies=nspecies, v=1)
      annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
    Reactions.R_BZ r_bz(nspecies=nspecies, v=1)
      annotation (Placement(transformation(extent={{40,-20},{60,0}})));
    Chemistry.Basic.Stationary c_A(
      stat_species=A,
      nspecies=nspecies,
      c=1.0) annotation (Placement(transformation(extent={{-60,-64},{
              -40,-44}})));
    Chemistry.Basic.Stationary c_B(
      stat_species=B,
      nspecies=nspecies,
      c=1.0) annotation (Placement(transformation(extent={{-20,-64},{
              0,-44}})));

    Real cA=v.moles[A];
    Real cB=v.moles[B];
    Real cP=v.moles[P];
    Real cX=v.moles[X];
    Real cY=v.moles[Y];
    Real cZ=v.moles[Z];
  protected
    Real dcx;
    Real dcy;
    Real dcz;
  equation
    connect(v.p, r_ay.p) annotation (Line(points={{-60,42},{-70,42},{
            -70,60},{-28,60},{-28,42},{-20,42}}));
    connect(v.p, r_xy.p)
      annotation (Line(points={{-60,42},{-70,42},{-70,60},{34,60},{34,
            42},{40,42}}));
    connect(v.p, r_ax.p)
      annotation (Line(points={{-60,42},{-70,42},{-70,-10},{-58,-10}}));
    connect(v.p, r_2x.p) annotation (Line(points={{-60,42},{-70,42},{
            -70,12},{-26,12},{-26,-10},{-20,-10}}));
    connect(v.p, r_bz.p) annotation (Line(points={{-60,42},{-70,42},{
            -70,12},{32,12},{32,-10},{40,-10}}));
    connect(v.p, c_A.p)
      annotation (Line(points={{-60,42},{-70,42},{-70,-54},{-60,-54}}));
    connect(v.p, c_B.p) annotation (Line(points={{-60,42},{-70,42},{
            -70,-34},{-26,-34},{-26,-54},{-20,-54}}));
    dcx = der(cX);
    dcy = der(cY);
    dcz = der(cZ);
    annotation (
      experiment(StopTime=30),
      __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter6/Oregonator.mos" "Simulate Oregonator"));
  end ChemicalSystem;

  model ODESystem
    extends FirstBookExamples.Icons.RunnableExample;

    Real x(start=1);
    Real y(start=1);
    Real z(start=1);
    Real dx;
    Real dy;
    Real dz;
    constant Real alpha=50;
    constant Real beta=1.0;
    constant Real gamma=0.0013;
    constant Real f=2;
    Real rate_xy;
    Real rate_2x;
    Real rate_ax;
    Real rate_ay;
    Real rate_bz;
  equation
    rate_ay = y;
    rate_xy = x*y;
    rate_ax = alpha*x;
    rate_2x = 2*gamma*x*x;
    rate_bz = beta*z;
    dx = -x*y - 2*gamma*x*x + alpha*x + y;
    dy = -x*y - y + (f/2)*beta*z;
    dz = 2*alpha*x - beta*z;
    der(x) = -x*y - 2*gamma*x*x + alpha*x + y;
    der(y) = -x*y - y + (f/2)*beta*z;
    der(z) = 2*alpha*x - beta*z;
    annotation (experiment(StopTime=30));
  end ODESystem;

  model DebugSystem
    extends FirstBookExamples.Icons.RunnableExample;
    extends ChemicalSystem;
    extends ODESystem;
    annotation (experiment(StopTime=30));
  end DebugSystem;
end Oregonator;
