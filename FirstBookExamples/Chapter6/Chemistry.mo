within FirstBookExamples.Chapter6;
package Chemistry "A sample chemistry package"
  extends Modelica.Icons.Package;
  package Types
    extends Modelica.Icons.Package;
    type MolarFlowRate = Real (quantity="MolarFlowRate", unit="mol/s");
  end Types;

  package Interfaces
    extends Modelica.Icons.Package;
    connector Mixture "A chemical mixture"
      parameter Integer nspecies;
      Modelica.SIunits.Concentration c[nspecies];
      flow Chemistry.Types.MolarFlowRate r[nspecies];
    end Mixture;
  end Interfaces;

  package Functions
    extends Modelica.Icons.Package;
    function CalcReactionRate
      extends Modelica.Icons.Function;
      input Integer nspecies "Number of species";
      input Real k "Reaction coefficient";
      input Real c[nspecies] "Species concentrations";
      input Integer reactants[:, 2] "Reactant information";
      output Real rate "Reaction rate";
    algorithm
      // Compute rate=k*[A]^a*[B]^b...
      rate := k;
      for i in 1:size(reactants, 1) loop
        rate := rate*c[reactants[i, 2]]^reactants[i, 1];
      end for;
      assert(rate >= -1e-12, "chemical reaction moving backward");
    end CalcReactionRate;

    function CalcMultiplier
      extends Modelica.Icons.Function;
      input Integer nspecies;
      input Integer reactants[:, 2];
      input Integer products[:, 2];
      output Real m[nspecies];
    algorithm
      m := zeros(nspecies);
      m[reactants[:, 2]] := reactants[:, 1];
      m[products[:, 2]] := m[products[:, 2]] - products[:, 1];
    end CalcMultiplier;
  end Functions;

  package Sensors
    extends Modelica.Icons.Package;
    model ConcentrationSensor
      parameter Integer nspecies;
      Interfaces.Mixture p(nspecies=nspecies);
      Modelica.Blocks.Interfaces.RealOutput c[nspecies];
    equation
      c = p.c;
    end ConcentrationSensor;
  end Sensors;

  package Basic
    extends Modelica.Icons.Package;
    partial model Reaction
      parameter Modelica.SIunits.Volume v=0.001;
      parameter Integer nspecies;
      Interfaces.Mixture p(nspecies=nspecies);
      parameter Real k "Reaction coefficient";
      parameter Integer reactants[:, 2];
      parameter Integer products[:, 2];
    protected
      Types.MolarFlowRate reaction_rate "Reaction rate";
      parameter Real mult[nspecies]=Chemistry.Functions.CalcMultiplier(nspecies,
           reactants, products);
    equation
      reaction_rate = Chemistry.Functions.CalcReactionRate(nspecies, k, p.c,
        reactants);
      p.r = mult*reaction_rate*v;
    end Reaction;

    model Reservoir "Reservoir of fixed composition"
      parameter Integer nspecies=nspecies;
      parameter Modelica.SIunits.Concentration c[nspecies];
      Interfaces.Mixture p(nspecies=nspecies);
    equation
      p.c = c;
    end Reservoir;

    model Stationary "Stationary concentration"
      parameter Integer nspecies=1;
      parameter Integer stat_species=1;
      parameter Modelica.SIunits.Concentration c;
      Interfaces.Mixture p(nspecies=nspecies);
    protected
      Types.MolarFlowRate r;
    equation
      p.c[stat_species] = c;
      for i in 1:nspecies loop
        p.r[i] = if i == stat_species then r else 0.0;
      end for;
    end Stationary;

    model Volume "Volume containing a chemical mixture"
      import Modelica.SIunits;
      parameter Integer nspecies;
      parameter SIunits.Volume v=0.001;
      parameter SIunits.AmountOfSubstance i_moles[nspecies]=fill(1, nspecies);
      Interfaces.Mixture p(nspecies=nspecies);
    protected
      Modelica.SIunits.AmountOfSubstance moles[nspecies](start=i_moles);
    equation
      der(moles) = p.r;
      p.c = moles/v;
    end Volume;
  end Basic;

  package Tests
    extends Modelica.Icons.Package;
    model NonReactingVolume "Does nothing"
      Chemistry.Basic.Volume v(nspecies=5)
        annotation (Placement(transformation(extent={{-16,-12},{20,20}})));
    end NonReactingVolume;

    model ThreeSpecies_SingleReaction
      model BimolecularReaction
        extends Chemistry.Basic.Reaction(
          k=2.1e-5,
          reactants={{1,1},{1,2},{2,3}},
          products={{1,5},{1,6}});
      end BimolecularReaction;
      Chemistry.Basic.Volume v(nspecies=6, v=1)
        annotation (Placement(transformation(extent={{-28,2},{-8,22}})));
      BimolecularReaction reaction(nspecies=6, v=1)
        annotation (Placement(transformation(extent={{6,32},{26,52}})));
      Chemistry.Basic.Stationary s1(
        stat_species=1,
        nspecies=6,
        c=0.2)
              annotation (Placement(transformation(extent={{-28,-32},
                {-8,-12}})));
      Chemistry.Basic.Stationary s4(
        stat_species=4,
        nspecies=6,
        c=0.1)
              annotation (Placement(transformation(extent={{6,-56},{
                26,-36}})));
    equation
      connect(reaction.p, v.p)
        annotation (Line(points={{6,42},{-48,42},{-48,12},{-28,12}}));
      connect(s1.p, v.p)
        annotation (Line(points={{-28,-22},{-38,-22},{-38,12},{-28,12}}));
      connect(s4.p, v.p)
        annotation (Line(points={{6,-46},{-48,-46},{-48,12},{-28,12}}));
    end ThreeSpecies_SingleReaction;
  end Tests;
end Chemistry;
