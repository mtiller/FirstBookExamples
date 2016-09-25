package Interfaces 
  
  extends Modelica.Icons.Library;
  connector Node "A connector for thermal interactions" 
    
    import Modelica.SIunits;
    SIunits.Temperature T(start=300) "Nodal temperature";
    flow SIunits.HeatFlowRate q "Net heat flow";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.37, 
        y=0.34, 
        width=0.6, 
        height=0.6), 
      Documentation(info="This connector is used for thermal interactions between components.  The \"across\" variable for this connector
is temperature and the \"through\" varible is heat flow rate.  The Modelica sign convention of flow into
a component being considered positive should be followed when using this connector (or any of the derived
connectors).
"));
  end Node;
  connector Node_a "A solid-filled thermal node" 
    extends Node;
    annotation (
      Icon(Rectangle(extent=[-100, 100; 100, -100], style(color=45, fillColor=
                45))), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.19, 
        y=0.23, 
        width=0.24, 
        height=0.59), 
      Diagram(Rectangle(extent=[-100, 100; 100, -100], style(color=45, 
              fillColor=45)), Text(
          extent=[-50, 50; 150, -150], 
          string="%name", 
          style(color=0))));
  end Node_a;
  connector Node_b "A outlined thermal node connector." 
    extends Node;
    annotation (
      Diagram(Rectangle(extent=[-100, 100; 100, -100], style(
            color=45, 
            thickness=2, 
            fillColor=7)), Text(
          extent=[-50, 50; 150, -150], 
          string="%name", 
          style(color=0, fillPattern=0))), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.15, 
        y=0.36, 
        width=0.29, 
        height=0.58), 
      Icon(Rectangle(extent=[-100, 100; 100, -100], style(
            color=45, 
            thickness=2, 
            fillColor=7))));
  end Node_b;
  partial model Element1D "Basic thermal element" 
  protected 
    Modelica.SIunits.HeatFlowRate q "Heat flow rate from a->b";
    Modelica.SIunits.Temperature dT "a.T-b.T";
  public 
    Node_a a annotation (extent=[-110, -10; -90, 10]);
    Node_b b annotation (extent=[90, -10; 110, 10]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.12, 
        y=0.34, 
        width=0.6, 
        height=0.6), 
      Documentation(info="This partial model contains the basic connectors and variables to allow most thermal models to be
created with a minimum of effort by simplying extending from this model.  This model defines and
includes equations for the temperature drop across the element, dT, and the heat flow rate through
the element, q.

By extending this model, it should be possible to write simple constitutive equations for many
types of heat transfer.
"));
  equation 
    dT = a.T - b.T;
    a.q = q;
    b.q = -q;
  end Element1D;
  annotation (Coordsys(
      extent=[0, 0; 434, 373], 
      grid=[1, 1], 
      component=[20, 20]), Window(
      x=0.46, 
      y=0.05, 
      width=0.28, 
      height=0.42, 
      library=1, 
      autolayout=1));
end Interfaces;
