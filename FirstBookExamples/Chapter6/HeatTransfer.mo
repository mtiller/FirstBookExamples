within FirstBookExamples.Chapter6;
model HeatTransfer "One Dimensional Heat Transfer"
  extends FirstBookExamples.Icons.RunnableExample;
  import Modelica.SIunits;

  // Configuration parameters
  parameter Integer n=10 "Number of Nodes";
  parameter SIunits.Density rho=1.0 "Material Density";
  parameter SIunits.HeatCapacity c_p=1.0;
  parameter SIunits.ThermalConductivity k=1.0;
  parameter SIunits.Length L=10.0 "Domain Length";

  // Temperature Array
  SIunits.Temp_K T[n](start=fill(300, n)) "Nodal Temperatures";
  // Computed parameters
protected
  parameter SIunits.Length dx=L/n "Distance between nodes";
equation
  // Loop over interior nodes
  for i in 2:n - 1 loop
    rho*c_p*der(T[i]) = k*(T[i + 1] - 2*T[i] + T[i - 1])/dx^2;
  end for;

  // Boundary Conditions
  T[1] = if time >= 1 then 1000 else 300;
  T[n] = 300;
  annotation (experiment(StopTime=50),
              __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter6/HeatTransfer.mos" "Simulate HeatTransfer"));
end HeatTransfer;
