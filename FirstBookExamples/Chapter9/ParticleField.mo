within FirstBookExamples.Chapter9;
model ParticleField
  extends FirstBookExamples.Icons.RunnableExample;
  inner function gravity
    extends Modelica.Icons.Function;
    extends TwoBodyField;
  end gravity;
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape b1(
    shapeType="sphere",
    r={0,0,0},
    length=0.1,
    width=0.1,
    height=0.1);
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape b2(
    shapeType="sphere",
    r={0,1,0},
    length=0.1,
    width=0.1,
    height=0.1);
  Particle p1(x_init={2,-2,0}, v_init={0.7,0,0});
  Particle p2(x_init={0,0.5,0}, v_init={-1,-1,0});
  Particle p3(x_init={0.5,2,0}, v_init={-1,-0.5,0});
  annotation (experiment(
      StopTime=5,
      Tolerance=1e-8),
      __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter9/ParticleField.mos" "Simulate ParticleField"));
end ParticleField;
