model ThermostatSystem 
  extends BookExamples.Icons.RunnableExample;
  annotation (
    experiment(
      StopTime=100000, 
      Tolerance=1e-8, 
      NumberOfIntervals=500), 
    Coordsys(
      extent=[-100, -100; 100, 100], 
      grid=[2, 2], 
      component=[20, 20]), 
    Window(
      x=0.4, 
      y=0.4, 
      width=0.6, 
      height=0.6), 
    Commands(file="HeatingSystem.mos" "Simulate heating system"),
    Diagram(
      Text(
        extent=[48, 58; 116, 48], 
        string="Digital Thermostat", 
        style(color=0)), 
      Text(
        extent=[50, -62; 118, -72], 
        string="Mechanical Thermostat", 
        style(color=0)), 
      Text(
        extent=[-6, 22; 46, 10], 
        string="Furnace", 
        style(color=0)), 
      Text(
        extent=[-6, -98; 46, -110], 
        string="Furnace", 
        style(color=0))));
  House house1 annotation (extent=[-60, 60; -20, 100]);
  Modelica.Blocks.Sources.Trapezoid amb_temp(
    amplitude={10}, 
    rising={4*60*60}, 
    width={4*60*60}, 
    falling={4*60*60}, 
    period={24*60*60}, 
    offset={273.15}, 
    startTime={9.5*60*60}) annotation (extent=[-100, -10; -80, 10]);
  House house2 annotation (extent=[-60, -60; -20, -20]);
  Furnace furnace1(capacity=15e+3) annotation (extent=[0, 20; 40, 60]);
  Furnace furnace2(capacity=15e+3) annotation (extent=[0, -100; 40, -60]);
  replaceable DigitalThermostat thermostat1(T_on=295, T_off=300)
    annotation (extent=[60, 60; 100, 100]);
  replaceable MechanicalThermostat thermostat2(desired=295)
    annotation (extent=[60, -60; 100, -20]);
equation 
  connect(amb_temp.outPort, house1.Tamb)
    annotation (points=[-79, 5.55112e-016; -70, 0; -70, 80; -60, 80]);
  connect(house2.Tamb, amb_temp.outPort)
    annotation (points=[-60, -40; -70, -40; -70, 0; -79, 5.55112e-016]);
  connect(house1.n, furnace1.thermal)
    annotation (points=[-20, 80; -20, 40; -1.11022e-015, 40], style(color=41));
  connect(furnace2.thermal, house2.n) annotation (points=[-1.11022e-015, -80; -20, 
         -80; -20, -40], style(color=41));
  connect(thermostat1.thermal, house1.n)
    annotation (points=[60, 96; -20, 96; -20, 80], style(color=41));
  connect(thermostat1.p, furnace1.p)
    annotation (points=[60, 80; 12, 80; 12, 60]);
  connect(furnace1.n, thermostat1.n)
    annotation (points=[28, 60; 28, 64; 60, 64]);
  connect(thermostat2.p, furnace2.p)
    annotation (points=[60, -40; 12, -40; 12, -60]);
  connect(thermostat2.thermal, house2.n)
    annotation (points=[60, -24; -20, -24; -20, -40], style(color=41));
  connect(thermostat2.n, furnace2.n)
    annotation (points=[60, -56; 28, -56; 28, -60]);
end ThermostatSystem;
