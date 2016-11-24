within FirstBookExamples.Chapter7;
package SensorComparison
  extends FirstBookExamples.Icons.BookExample;

  model SamplingCase1
    extends SensorBenchmark(redeclare SampleHoldSensor sensor(sample_interval=
            0.01));
  end SamplingCase1;

  model SamplingCase2
    extends SensorBenchmark(redeclare SampleHoldSensor sensor(sample_interval=
            0.015));
  end SamplingCase2;

  model CountingCase1
    extends SensorBenchmark(controller(k=10),   redeclare CountingSensor sensor(
          divisions=64, sample_interval=0.02));
  end CountingCase1;

  model CountingCase2
    extends SensorBenchmark(controller(k=10),   redeclare CountingSensor sensor(
          divisions=64, sample_interval=0.06));
  end CountingCase2;

  model PeriodCase1
    extends SensorBenchmark(redeclare PeriodSensor sensor(divisions=16));
  end PeriodCase1;

  model PeriodCase2
    extends SensorBenchmark(redeclare PeriodSensor sensor(divisions=8));
  end PeriodCase2;

  model QuantizedCase1
    extends SensorBenchmark(redeclare QuantizedSensor sensor(sample_interval=
            0.01, bits=8));
  end QuantizedCase1;

  model QuantizedCase2
    extends SensorBenchmark(redeclare QuantizedSensor sensor(sample_interval=
            0.01, bits=4));
  end QuantizedCase2;

  model TestSampling
    extends FirstBookExamples.Icons.RunnableExample;
    SensorBenchmark ideal;
    SamplingCase1 sampling1;
    SamplingCase2 sampling2;
    annotation (experiment(StopTime=2));
  end TestSampling;

  model TestCounting
    extends FirstBookExamples.Icons.RunnableExample;
    SensorBenchmark ideal(controller(k=10));
    CountingCase1 counting1;
    CountingCase2 counting2;
    annotation (experiment(StopTime=2));
  end TestCounting;

  model TestPeriod
    extends FirstBookExamples.Icons.RunnableExample;
    SensorBenchmark ideal;
    PeriodCase1 period1;
    PeriodCase2 period2;
    annotation (experiment(StopTime=2));
  end TestPeriod;

  model TestQuantized
    extends FirstBookExamples.Icons.RunnableExample;
    SensorBenchmark ideal;
    QuantizedCase1 quantized1;
    QuantizedCase2 quantized2;
    annotation (experiment(StopTime=2));
  end TestQuantized;

  model TestAll
    extends FirstBookExamples.Icons.RunnableExample;
    SensorBenchmark ideal1;
    SensorBenchmark ideal2(controller(k=10));
    SamplingCase1 sampling1;
    SamplingCase2 sampling2;
    CountingCase1 counting1;
    CountingCase2 counting2;
    PeriodCase1 period1;
    PeriodCase2 period2;
    QuantizedCase1 quantized1;
    QuantizedCase2 quantized2;
    annotation (experiment(StopTime=2),
                 __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter7/SensorComparison.mos" "Run sensor comparison"));
  end TestAll;
  annotation (experiment(StopTime=2),
              __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter7/SensorComparison.mos" "Run sensor comparison"));
end SensorComparison;
