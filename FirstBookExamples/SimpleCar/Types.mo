within FirstBookExamples.SimpleCar;
package Types "Types used in vehicle modeling"
  extends Modelica.Icons.Package;
  type Degrees = Real (final unit="deg");
  type KilometersPerHour = Real (final unit="km/h");
  type RPM = Real (final unit="rev/min");
  annotation (
    Documentation(info="This package contains various types used in vehicle modeling and shared by the components and subsystem
models found throughout the 'SimpleCar' package.
"));
end Types;
