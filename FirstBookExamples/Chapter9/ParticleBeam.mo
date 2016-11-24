within FirstBookExamples.Chapter9;
model ParticleBeam
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
  parameter Modelica.SIunits.Velocity v_init[3]={-4,0,0};
  parameter Modelica.SIunits.Position xoff=10;
  parameter Modelica.SIunits.Position yoff=0;
  parameter Modelica.SIunits.Position dy=0.1;
  parameter Modelica.SIunits.Position dx=1;
  model DistantParticle
    extends Particle(x_init={10,0,0}, v_init=v_init);
  end DistantParticle;

  Particle p11(x_init={xoff + dx*1,yoff + dy*1,0}, v_init=v_init);
  Particle p12(x_init={xoff + dx*1,yoff + dy*2,0}, v_init=v_init);
  Particle p13(x_init={xoff + dx*1,yoff + dy*3,0}, v_init=v_init);
  Particle p14(x_init={xoff + dx*1,yoff + dy*4,0}, v_init=v_init);
  Particle p15(x_init={xoff + dx*1,yoff + dy*5,0}, v_init=v_init);
  Particle p16(x_init={xoff + dx*1,yoff + dy*6,0}, v_init=v_init);
  Particle p17(x_init={xoff + dx*1,yoff + dy*7,0}, v_init=v_init);
  Particle p18(x_init={xoff + dx*1,yoff + dy*8,0}, v_init=v_init);
  Particle p19(x_init={xoff + dx*1,yoff + dy*9,0}, v_init=v_init);

  Particle p21(x_init={xoff + dx*2,yoff + dy*1,0}, v_init=v_init);
  Particle p22(x_init={xoff + dx*2,yoff + dy*2,0}, v_init=v_init);
  Particle p23(x_init={xoff + dx*2,yoff + dy*3,0}, v_init=v_init);
  Particle p24(x_init={xoff + dx*2,yoff + dy*4,0}, v_init=v_init);
  Particle p25(x_init={xoff + dx*2,yoff + dy*5,0}, v_init=v_init);
  Particle p26(x_init={xoff + dx*2,yoff + dy*6,0}, v_init=v_init);
  Particle p27(x_init={xoff + dx*2,yoff + dy*7,0}, v_init=v_init);
  Particle p28(x_init={xoff + dx*2,yoff + dy*8,0}, v_init=v_init);
  Particle p29(x_init={xoff + dx*2,yoff + dy*9,0}, v_init=v_init);

  Particle p31(x_init={xoff + dx*3,yoff + dy*1,0}, v_init=v_init);
  Particle p32(x_init={xoff + dx*3,yoff + dy*2,0}, v_init=v_init);
  Particle p33(x_init={xoff + dx*3,yoff + dy*3,0}, v_init=v_init);
  Particle p34(x_init={xoff + dx*3,yoff + dy*4,0}, v_init=v_init);
  Particle p35(x_init={xoff + dx*3,yoff + dy*5,0}, v_init=v_init);
  Particle p36(x_init={xoff + dx*3,yoff + dy*6,0}, v_init=v_init);
  Particle p37(x_init={xoff + dx*3,yoff + dy*7,0}, v_init=v_init);
  Particle p38(x_init={xoff + dx*3,yoff + dy*8,0}, v_init=v_init);
  Particle p39(x_init={xoff + dx*3,yoff + dy*9,0}, v_init=v_init);

  Particle p41(x_init={xoff + dx*4,yoff + dy*1,0}, v_init=v_init);
  Particle p42(x_init={xoff + dx*4,yoff + dy*2,0}, v_init=v_init);
  Particle p43(x_init={xoff + dx*4,yoff + dy*3,0}, v_init=v_init);
  Particle p44(x_init={xoff + dx*4,yoff + dy*4,0}, v_init=v_init);
  Particle p45(x_init={xoff + dx*4,yoff + dy*5,0}, v_init=v_init);
  Particle p46(x_init={xoff + dx*4,yoff + dy*6,0}, v_init=v_init);
  Particle p47(x_init={xoff + dx*4,yoff + dy*7,0}, v_init=v_init);
  Particle p48(x_init={xoff + dx*4,yoff + dy*8,0}, v_init=v_init);
  Particle p49(x_init={xoff + dx*4,yoff + dy*9,0}, v_init=v_init);
  annotation (experiment(
      StopTime=7,
      Tolerance=1e-8),
      __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter9/ParticleBeam.mos" "Simulate ParticleBeam"));
end ParticleBeam;
