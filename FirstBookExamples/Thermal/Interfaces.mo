within FirstBookExamples.Thermal;
package Interfaces

  extends Modelica.Icons.Package;
  connector Node "A connector for thermal interactions"

    import Modelica.SIunits;
    SIunits.Temperature T(start=300) "Nodal temperature";
    flow SIunits.HeatFlowRate q "Net heat flow";
    annotation (
      Documentation(info="This connector is used for thermal interactions between components.  The \"across\" variable for this connector
is temperature and the \"through\" varible is heat flow rate.  The Modelica sign convention of flow into
a component being considered positive should be followed when using this connector (or any of the derived
connectors).
"));
  end Node;

  connector Node_a "A solid-filled thermal node"
    extends Node;
    annotation (
      Icon(graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={255,127,0},
            fillColor={255,127,0},
            fillPattern=FillPattern.Solid)}),
      Diagram(graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={255,127,0},
            fillColor={255,127,0},
            fillPattern=FillPattern.Solid), Text(
            extent={{-50,50},{150,-150}},
            lineColor={0,0,0},
            textString=
                 "%name")}));
  end Node_a;

  connector Node_b "A outlined thermal node connector."
    extends Node;
    annotation (
      Diagram(graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={255,127,0},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid), Text(
            extent={{-50,50},{150,-150}},
            lineColor={0,0,0},
            textString=
                 "%name")}),
      Icon(graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={255,127,0},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}));
  end Node_b;

  partial model Element1D "Basic thermal element"
  protected
    Modelica.SIunits.HeatFlowRate q "Heat flow rate from a->b";
    Modelica.SIunits.Temperature dT "a.T-b.T";
  public
    Node_a a annotation (Placement(transformation(extent={{-110,-10},
              {-90,10}})));
    Node_b b annotation (Placement(transformation(extent={{90,-10},{
              110,10}})));
  equation
    dT = a.T - b.T;
    a.q = q;
    b.q = -q;
    annotation (
      Documentation(info="This partial model contains the basic connectors and variables to allow most thermal models to be
created with a minimum of effort by simplying extending from this model.  This model defines and
includes equations for the temperature drop across the element, dT, and the heat flow rate through
the element, q.

By extending this model, it should be possible to write simple constitutive equations for many
types of heat transfer.
"));
  end Element1D;
end Interfaces;
