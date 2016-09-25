package BoundaryConditions 
  extends Modelica.Icons.Library;
  model FixedTemperature "Fixed temperature boundary condition" 
    parameter Modelica.SIunits.Temperature T;
    Interfaces.Node_a n annotation (extent=[-110, -10; -90, 10]);
    annotation (
      Icon(
        Rectangle(extent=[-100, 80; 100, -80], style(pattern=0, fillColor=8))
          , 
        Rectangle(extent=[-100, 80; -20, -80], style(
            color=0, 
            pattern=0, 
            fillColor=9, 
            fillPattern=7)), 
        Text(
          extent=[-20, 40; 100, 0], 
          string="T=%T", 
          style(color=0)), 
        Line(points=[-20, 80; -20, -80], style(color=0, thickness=4)), 
        Line(points=[80, 0; -18, 0; -20, 0], style(color=0, arrow=1)), 
        Text(extent=[-100, 122; 100, 80], string="%name")), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.31, 
        y=0.3, 
        width=0.6, 
        height=0.6), 
      Documentation(info=" "));
  equation 
    n.T = T;
  end FixedTemperature;
  
  model VariableTemperature "Variable temperature boundary condition" 
    Modelica.Blocks.Interfaces.InPort T(final n=1) annotation (extent=[120, -
          10; 100, 10]);
    Interfaces.Node_a n annotation (extent=[-110, -10; -90, 10]);
    annotation (
      Icon(
        Rectangle(extent=[-100, 80; 100, -80], style(pattern=0, fillColor=8))
          , 
        Rectangle(extent=[-100, 80; -20, -80], style(
            color=0, 
            pattern=0, 
            fillColor=9, 
            fillPattern=7)), 
        Text(
          extent=[56, 24; 100, -22], 
          string="T=", 
          style(color=0)), 
        Line(points=[-100, 80; -100, -80], style(color=0)), 
        Line(points=[64, 0; -20, 0], style(color=0, arrow=1)), 
        Line(points=[-20, 80; -20, -80], style(color=0, thickness=4)), 
        Text(extent=[-100, 122; 100, 80], string="%name")), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.35, 
        y=0.3, 
        width=0.6, 
        height=0.6), 
      Documentation(info="This model represents a variable temperature boundary condition.  The temperature value is given by the input
connector to the model.  The effect is that an instance of this model acts as an infinite reservoir able to
absorb or generate as much energy as required to keep the temperature at the specified value.
"));
  equation 
    n.T = T.signal[1];
  end VariableTemperature;
  
  model PrescribedHeatFlux "Prescribed heat flux" 
    Modelica.SIunits.Area A=1.0;
    Modelica.Blocks.Interfaces.InPort q(final n=1) annotation (extent=[100, -
          10; 120, 10], rotation=180);
    Interfaces.Node_a n annotation (extent=[-110, -10; -90, 10]);
    annotation (
      Icon(
        Rectangle(extent=[-100, 80; 100, -80], style(pattern=0, fillColor=8))
          , 
        Rectangle(extent=[-100, 80; -20, -80], style(
            color=0, 
            pattern=0, 
            fillColor=9, 
            fillPattern=7)), 
        Line(points=[-20, 80; -20, -80], style(color=0, thickness=4)), 
        Line(points=[64, 0; -20, 0], style(color=0, arrow=1)), 
        Text(
          extent=[56, 24; 100, -22], 
          string="q=", 
          style(color=0)), 
        Text(extent=[-100, 122; 100, 80], string="%name")), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.39, 
        y=0.34, 
        width=0.6, 
        height=0.6), 
      Documentation(info="This model allows a specified amount of heat to be \"injected\" into a thermal system at a given node.  The amount of heat
is given by the input connector attached to the model.
"));
  equation 
    n.q = A*q.signal[1];
  end PrescribedHeatFlux;
end BoundaryConditions;
