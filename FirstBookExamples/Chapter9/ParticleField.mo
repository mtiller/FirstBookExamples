within FirstBookExamples.Chapter9;
model ParticleField
  extends FirstBookExamples.Icons.RunnableExample;
  inner function gravity
    extends TwoBodyField;
  end gravity;
  Sphere b1(
    x=0,
    y=0,
    z=0,
    R=0.05);
  // Dymola specific
  Sphere b2(
    x=0,
    y=1,
    z=0,
    R=0.05);
  // Dymola specific
  Particle p1(x_init={2,-2,0}, v_init={0.7,0,0});
  Particle p2(x_init={0,0.5,0}, v_init={-1,-1,0});
  Particle p3(x_init={0.5,2,0}, v_init={-1,-0.5,0});
  annotation (experiment(
      StopTime=5,
      Tolerance=1e-8,
      NumberOfIntervals=500),
      __Dymola_Commands(file="ParticleField.mos" "Simulate ParticleField"));
end ParticleField;
