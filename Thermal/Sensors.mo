package Sensors 
  extends Modelica.Icons.Library;
  model TemperatureSensor "Absolute temperature sensor" 
    Modelica.Blocks.Interfaces.OutPort T annotation (extent=[90, -10; 110, 10]
      );
    Interfaces.Node_a n annotation (extent=[-110, -10; -90, 10]);
    annotation (
      Diagram, 
      Icon(
        Ellipse(extent=[-20, -98; 20, -60], style(
            color=0, 
            thickness=2, 
            fillColor=41)), 
        Rectangle(extent=[-12, 40; 12, -68], style(color=41, fillColor=41)), 
        Line(points=[12, 0; 90, 0]), 
        Line(points=[-90, 0; -12, 0], style(color=41)), 
        Line(points=[-12, 52; -22, 52], style(color=0, thickness=4)), 
        Line(points=[-12, 30; -22, 30], style(color=0, thickness=4)), 
        Line(points=[-12, 70; -22, 70], style(color=0, thickness=4)), 
        Line(points=[-12, 10; -22, 10], style(color=0, thickness=4)), 
        Line(points=[-12, -10; -22, -10], style(color=0, thickness=4)), 
        Line(points=[-12, -30; -22, -30], style(color=0, thickness=4)), 
        Line(points=[-12, -50; -22, -50], style(color=0, thickness=4)), 
        Polygon(points=[-12, 40; -12, 80; -10, 86; -6, 88; 0, 90; 6, 88; 10, 
              86; 12, 80; 12, 40; -12, 40], style(color=0, thickness=2)), 
        Line(points=[-12, 40; -12, -64], style(color=0, thickness=2)), 
        Line(points=[12, 40; 12, -64], style(color=0, thickness=2)), 
        Text(extent=[-100, 130; 100, 90], string="%name")), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.34, 
        y=0.2, 
        width=0.28, 
        height=0.66), 
      Documentation(info="This is an ideal absolute temperature sensor.  The
sensor itself has not thermal interaction with
whatever it is connected to.  Furthermore, not
thermocouple-like lags are associated with this
sensor model.
"));
  equation 
    T.signal[1] = n.T;
  end TemperatureSensor;
  
  model HeatFlow "Heat flow rate sensor" 
    extends Modelica.Icons.RotationalSensor;
    Interfaces.Node_a a annotation (extent=[-110, -10; -90, 10]);
    Interfaces.Node_b b annotation (extent=[90, -10; 110, 10]);
    Modelica.Blocks.Interfaces.OutPort heat "Heat flow from a->b" annotation (
        extent=[-10, -110; 10, -90], rotation=270);
    annotation (
      Diagram, 
      Icon(
        Text(
          extent=[-22, -17; 22, -55], 
          string="q", 
          style(color=41)), 
        Line(points=[-70, 0; -90, 0], style(color=41)), 
        Line(points=[69, 0; 90, 0], style(color=41)), 
        Line(points=[0, -70; 0, -90]), 
        Text(extent=[-100, 110; 100, 70], string="%name")), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.28, 
        y=0.32, 
        width=0.6, 
        height=0.6), 
      Documentation(info="This model is capable of monitoring the heat flow through a given thermal path.  The sensed value of heat
flow is the amount that passes through this sensor while keeping the temperature drop across the
sensor zero.  This is an ideal model so it does not absorb any energy and it has no direct effect on the
thermal response of a system it is included in.
"));
  equation 
    a.q + b.q = 0;
    heat.signal[1] = a.q;
    a.T = b.T;
  end HeatFlow;
end Sensors;
