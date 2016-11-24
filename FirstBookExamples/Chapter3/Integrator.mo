within FirstBookExamples.Chapter3;
block Integrator
  parameter Real init_val=0;
  input Signal in_sig annotation (Placement(transformation(extent={{
            -110,-10},{-90,10}})));
  output Signal out_sig(val(start=init_val))
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  der(out_sig.val) = in_sig.val;
end Integrator;
