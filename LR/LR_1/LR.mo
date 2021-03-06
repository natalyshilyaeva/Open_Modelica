package LR
  model lr_1
    Real x[5];
    Real y[5];
  initial equation
    for i in 1:5 loop
      x[i] = 2 - 2 / 5 * (i - 1);
      y[i] = 0;
    end for;
  equation
    for i in 1:5 loop
      der(x[i]) = (-9 * x[i]) + 20 * y[i];
      der(y[i]) = 4 * x[i] * y[i] - 5 * x[i] - 10 * y[i];
    end for;
  end lr_1;

  model lr_2
    import Modelica.SIunits;
    Modelica.SIunits.Angle phi (start=10);
    Modelica.SIunits.AngularVelocity omega (start=0);
    
    parameter Modelica.SIunits.Mass m=2;
    parameter Modelica.SIunits.Length l=20;
    parameter Modelica.SIunits.Acceleration g=9.81;
    parameter Modelica.Mechanics.MultiBody.Frames.Orientation O= Modelica.Mechanics.MultiBody.Frames.axesRotations({1,2,3},{0,0,0},{0,0,0});
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape Palka (shapeType="cylinder", length=l, width=l/50, height=l/50, lengthDirection={sin(phi),-cos(phi),0}, widthDirection={0,0,1}, color={255,0,0}, specularCoefficient=0.5, r={0,0,0}, R=O, r_shape={0,0,0});
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape Sphere (shapeType="sphere", length=l, width=l/3, height=l/3, lengthDirection={sin(phi),-cos(phi),0}, widthDirection={0,0,1}, color={0,255,0}, specularCoefficient=0.5, r={l*sin(phi),l*(-cos(phi)),0}, R=O, r_shape={0,0,0});
  equation
    omega = der(phi);
    m*(l^2)*der(omega) = -m*g*l*sin(phi);
  end lr_2;
end LR;
