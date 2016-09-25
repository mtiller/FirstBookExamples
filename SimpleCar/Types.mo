package Types "Types used in vehicle modeling" 
  extends Modelica.Icons.Library;
  type Degrees = Real (final unit="deg");
  type KilometersPerHour = Real (final unit="km/h");
  type RPM = Real (final unit="rev/min");
  annotation (
    Coordsys(
      extent=[0, 0; 944, 593], 
      grid=[1, 1], 
      component=[20, 20]), 
    Window(
      x=0.37, 
      y=0.34, 
      width=0.6, 
      height=0.6, 
      library=1, 
      autolayout=1), 
    Documentation(info="This package contains various types used in vehicle modeling and shared by the components and subsystem
models found throughout the 'SimpleCar' package.
"));
end Types;
