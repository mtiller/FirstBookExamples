within FirstBookExamples;
package CupOfCoffee "Rudimentary model"
    extends Modelica.Icons.Package;

  model CupOfCoffee_1
    Real T(start=380);
  equation
    der(T) = -0.2*(T - 300);
  end CupOfCoffee_1;

  model CupOfCoffee_2 "Add some text"
    Real T(start=380) "Coffee Temperature";
  equation
    der(T) = -0.2*(T - 300) "Newton's Law of Cooling";
  end CupOfCoffee_2;

  model CupOfCoffee_3 "Use parameters"
    parameter Real T0=380 "Initial temp.";
    parameter Real Tamb=300 "Ambient temperature";
    parameter Real C=0.2;
    Real T(start=T0) "Coffee Temperature";
  equation
    der(T) = -C*(T - Tamb) "Newton's Law of Cooling";
  end CupOfCoffee_3;

  model CupOfCoffee_4 "More physical"
    import Modelica.SIunits.*;
    parameter Temperature T0=380 "Initial temp.";
    parameter Temperature Tamb=300 "Ambient temperature";
    parameter Density rho=1000 "Coffee density";
    parameter SpecificHeatCapacity cv=4179 "Coffee specific heat";
    parameter CoefficientOfHeatTransfer h=25 "Convection coefficient";
    parameter Volume V=4e-4 "Volume of coffee";
    parameter Area A=4e-3 "Area of coffee";
    Temperature T(start=T0) "Coffee Temperature";
  equation
    rho*V*cv*der(T) = -h*A*(T - Tamb) "First law of thermodynamics";
  end CupOfCoffee_4;

  model CupOfCoffee_5
    ThermalCapacitance coffee(
      T0=380,
      rho=1000,
      V=4e-4,
      cv=4179);
    Convection cooling(
      h=25,
      A=4e-3,
      Tamb=300);
  equation
    connect(coffee.p, cooling.p);
  end CupOfCoffee_5;

  model CupOfCoffee_6
    ThermalCapacitance coffee(
      T0=380,
      rho=1000,
      V=4.08e-4,
      cv=4179);
    ThermalCapacitance cup(
      T0=300,
      rho=3700,
      V=8.45e-5,
      cv=880);
    Boundary cup2coffee(h=100, A=2.53e-2);
    Convection coffee_cooling(
      h=25,
      A=4e-3,
      Tamb=300);
    Convection cup_cooling(
      h=25,
      A=2.79e-2,
      Tamb=300);
  equation
    connect(coffee.p, cup2coffee.p1);
    connect(coffee.p, coffee_cooling.p);
    connect(cup.p, cup2coffee.p2);
    connect(cup.p, cup_cooling.p);
  end CupOfCoffee_6;

  model CupOfCoffee_7 "Additional physics"
    import Modelica.SIunits.*;
    import Modelica.Constants.*;
    parameter CoefficientOfHeatTransfer h_air=25
      "Convection coefficient with air";
    parameter CoefficientOfHeatTransfer h_fluid=100
      "Convection coefficient with fluid";
    parameter Customer customer;
    parameter Service service;
    parameter CoffeeProperties coffee;
    parameter CupProperties cup;
    Temperature T "Coffee Temperature";
    Temperature Tcup "Coffee cup temperature";
    Mass M "Mass of coffee in the cup";
    Area A "Surface area exposed to ambient";
    Length H "Height of coffee in the cup";
    Volume V "Volume of coffee in cup";
    Boolean drinking "true when drinking";
    Boolean empty "true when cup is empty";
    MassFlowRate mdot_drink "drinking mass flow rate";
    discrete MassFlowRate mdot_refill "refilling mass flow rate";
    Energy U "coffee internal energy";
    Area Acup_int "internal surface area of cup";
  initial equation
    H = 0.9*cup.H;
    T = service.Tcoffee;
    Tcup = service.Tamb;
  algorithm
    when sample(service.start_refill, service.dt_refill) then
      mdot_refill := service.dm_refill;
    end when;
    when H>=0.9*cup.H then
      mdot_refill := 0;
    end when;
  equation
    U = M*coffee.cv*T;
    der(U) = -h_air*A*(T - service.Tamb) - h_fluid*Acup_int*(T - Tcup) - mdot_drink*coffee.cp*
      T + mdot_refill*coffee.cp*service.Tcoffee
      "First law of thermodynamics for coffee";
    cup.M*cup.cv*der(Tcup) = -h_air*cup.A_ext*(Tcup - service.Tamb) - h_fluid*Acup_int*(
      Tcup - T) "First law of thermodynamics for cup";
    A = pi*cup.D^2/4 "Area of coffee exposed to air";
    Acup_int = pi*cup.D*(cup.H-H) "Area on inside of mug exposed to air";
    V = A*H "Volume of coffee in the cup";
    M = coffee.rho*V "Mass of coffee in the cup";
    der(M) = -mdot_drink + mdot_refill "Conservation of mass for coffee";
    empty = M <= 1e-9;
    drinking = mod(time, customer.dt_drink) <= customer.drink_duration and not empty;
    mdot_drink = if drinking then customer.sip_rate else 0;
  end CupOfCoffee_7;

  connector ThermalPort
    Modelica.SIunits.Temperature T;
    flow Modelica.SIunits.HeatFlowRate q;
  end ThermalPort;

  model ThermalCapacitance
    import Modelica.SIunits.*;
    parameter Temperature T0;
    parameter Density rho;
    parameter SpecificHeatCapacity cv;
    parameter Volume V;
    ThermalPort p;
  initial equation
    p.T = T0;
  equation
    rho*V*cv*der(p.T) = p.q;
  end ThermalCapacitance;

  model Convection "Convection to the ambient"
    import Modelica.SIunits.*;
    parameter CoefficientOfHeatTransfer h;
    parameter Temperature Tamb;
    parameter Area A;
    ThermalPort p;
  equation
    p.q = h*A*(p.T - Tamb);
  end Convection;

  model Boundary "Convective boundary"
    import Modelica.SIunits.*;
    parameter CoefficientOfHeatTransfer h;
    parameter Area A;
    ThermalPort p1;
    ThermalPort p2;
  equation
    p1.q + p2.q = 0 "No storage of energy";
    p1.q = h*A*(p1.T - p2.T);
  end Boundary;

  record Customer
    import Modelica.SIunits.*;
    Time dt_drink=60 "amount of time between sips";
    Mass dm_drink=1.48e-2 "amount of mass consumed during each sip";
    Time drink_duration=1 "duration for each drink";
    MassFlowRate sip_rate=dm_drink/drink_duration "Rate of drinking coffee";
    Time start_drink=1 "time when drinking starts";
  end Customer;

  record Service
    import Modelica.SIunits.*;
    Time start_refill=1750 "time when refilling starts";
    Time dt_refill=1750 "amount of time between refills";
    Mass dm_refill=0.3 "amount of mass added during each refill";
    Time refill_duration=20 "duration for each refill";
    Temperature Tcoffee=360 "Temperature of refill coffee";
    parameter Temperature Tamb=300 "Ambient temperature";
  end Service;

  record CoffeeProperties
    import Modelica.SIunits.*;
    parameter Density rho=1000 "Coffee density";
    parameter SpecificHeatCapacity cv=4179
      "Coffee specific heat (constant volume)";
    parameter SpecificHeatCapacity cp=cv
      "Coffee specific heat (constant pressure)";
  end CoffeeProperties;

  record CupProperties
    import Modelica.SIunits.*;
    import Modelica.Constants.*;
    Height H=0.127 "Height of coffee cup";
    Diameter D=0.0508 "Diameter of cup base";
    Density rho=3700 "density of the cup";
    Mass M=rho*V "mass of the cup";
    SpecificHeatCapacity cv=880 "Cup specific heat (constant volume)";
    Length t=0.003175 "cup wall thickness";
    Volume V=pi*t*H*(D + t)+pi*(D/2)^2*t "volume of the cup";
    Area A_ext=pi*H*(D + 2*t) "external surface area of cup";
  end CupProperties;

  model CupOfCoffeeAnimation "animated model of cup of coffee"
    CupOfCoffee.CupOfCoffee_7 coffee_example;
    Modelica.SIunits.Temperature coffeeTemp;
    Modelica.SIunits.Temperature mugTemp;
    Modelica.SIunits.Height h;
    function ComputeCoffeeColor
      input Modelica.SIunits.Temperature T;
      output Real color[3];
    protected
      Modelica.SIunits.Temperature Tmin=293;
      Modelica.SIunits.Temperature Tmax=380;
      Real per=(min(max(Tmin, T), Tmax) - Tmin)/(Tmax - Tmin);
    algorithm
      color := {100 + 155*per,100 - 50*per,100 - 50*per};
    end ComputeCoffeeColor;

    function ComputeMugColor
      input Modelica.SIunits.Temperature T;
      output Real color[3];
    protected
      Modelica.SIunits.Temperature Tmin=293;
      Modelica.SIunits.Temperature Tmax=380;
      Real per=(min(max(Tmin, T), Tmax) - Tmin)/(Tmax - Tmin);
    algorithm
      color := {100 + 155*per,100 - 50*per,100 - 50*per};
    end ComputeMugColor;
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape coffee(
      shapeType="cylinder",
      length=h,
      width=1.0,
      color=ComputeCoffeeColor(coffeeTemp),
      height=1.0,
      lengthDirection={0,1,0}) annotation (Placement(transformation(extent={{
              -20,20},{0,40}}, rotation=0)));
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape cup_bottom(
      shapeType="cylinder",
      length=-0.2,
      width=1.2,
      height=1.2,
      lengthDirection={0,1,0},
      color=ComputeMugColor(mugTemp));
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape cup_wall(
      shapeType="pipe",
      length=1.2,
      width=1.2,
      height=1.2,
      lengthDirection={0,1,0},
      extra=0.8,
      color=ComputeMugColor(mugTemp));
  equation
    coffeeTemp = coffee_example.T;
    mugTemp = coffee_example.Tcup;
    h=coffee_example.H/coffee_example.cup.H/0.9;
    annotation (uses);
  end CupOfCoffeeAnimation;

  model TestAll
    CupOfCoffee_1 cup1;
    CupOfCoffee_2 cup2;
    CupOfCoffee_3 cup3;
    CupOfCoffee_4 cup4;
    CupOfCoffee_5 cup5;
    CupOfCoffee_6 cup6;
    CupOfCoffee_7 cup7;
  end TestAll;
  annotation (
    preferredView="info", Documentation(info="<html>
<p>This package contains an example that shows you the thermal effects of a coffee cup being filled and emptied.</p>
<p>At the same time it shows and how the coffee and the cup itself is cooling down and warming up again. </p>
<p>You can find a visual explanation in the video: <a href=\"modelica://FirstBookExamples/Resources/Images/coffee.wmv\">FirstBookExamples/Resources/Images/coffee.wmv</a>.</p>
</html>"));
end CupOfCoffee;
