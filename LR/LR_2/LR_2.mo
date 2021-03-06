package LR_2
  model func_1
    Real x(start = 10);
    Real v(start = 0);
    Real F;
    parameter Real K = 10;
    parameter Real k2 = 2;
    parameter Real k3 = 20;
    parameter Real k4 = 1;
  equation
    if x < 0.0000001 then
      F = -K;
    elseif x > 0.0000001 then
      F = K;
    else
      F = 0;
    end if;
    der(v) = (-F) - k2 * x + k3 * sin(k4 * time);
    der(x) = v;
  end func_1;

  model func_2
  
    Real x(start = 10);
    Real v(start = 0);
    Real F;
    Real flag(start=0.0);
    
    parameter Real K = 10;
    parameter Real k2 = 2;
    parameter Real k3 = 20;
    parameter Real k4 = 1;
    parameter Real a = 2;
    
  equation
    if flag ==0.0 then
      if x<a then
        flag=0.0;
        F=-K;
      else
        flag=1.0;
        F=K;
      end if;
    else
      if x>-a then
        flag=1.0;
        F=K;
      else
        flag=0.0;
        F=-K;
      end if;
    end if;      
    
    der(v) = (-F) - k2 * x + k3 * sin(k4 * time);
    der(x) = v;
  
  end func_2;

  model func_3
  
  Real x(start = 10);
    Real v(start = 0);
    Real F;
    
    parameter Real K = 10;
    parameter Real k2 = 2;
    parameter Real k3 = 20;
    parameter Real k4 = 1;
    parameter Real a = 2;
    parameter Real b = 2;
    parameter Real d = 4;  
    
  equation
    if x<=(-d) then
      F=-K;  
    elseif x==(-a) then
        F=(-b);
    elseif x==a then
        F=b;
    elseif ((x>a) and (x<d)) or ((x<(-a)) and (x>(-d))) then
        F=(K/d)*x;
    elseif (x>=d) then
        F=K;
    else
      F=0;
    end if;  
    
    der(v) = (-F) - k2 * x + k3 * sin(k4 * time);
    der(x) = v;
    
  end func_3;

  model func_4
  
    Real x1(start = 10);
    Real v1(start = 0);
    Real x2(start = 10);
    Real v2(start = 0);
    Real F1;
    Real F2;
    
    parameter Real K = 10;
    parameter Real k2 = 2;
    parameter Real k3 = 20;
    parameter Real k4 = 1;
    parameter Real a = 2;
    parameter Real b = 0.5;
    
  equation
    if x1>(b*a) then F1=K;
      elseif x1==(b*a) then F1=K;
      elseif ((x1<(b*a)) and (x1>(-a))) then F1=0;
      elseif x1==(-a) then F1=(-K);
      else F1=(-K);
    end if;  
    
    if x2<(-b*a) then F2=(-K);
      elseif x2==(-b*a) then F2=(-K);
      elseif ((x2>(-b*a)) and (x2<a)) then F2=0;
      elseif x2==a then F2=K;
      else F2=K;
    end if;
            
    der(v1) = (-F2) - k2 * x1 + k3 * sin(k4 * time);  
    der(v2) = (-F1) - k2 * x2 + k3 * sin(k4 * time);
    der(x1) = v1;
    der(x2) = v2;
    
    

  end func_4;

  model func_5
  
    Real x(start = 10);
    Real v(start = 0);
    Real F;
    Real flag(start=0.0);
    
    parameter Real K = 10;
    parameter Real k2 = 2;
    parameter Real k3 = 20;
    parameter Real k4 = 1;
    parameter Real a = 2;
    parameter Real b = 0.5;
    
  equation
    if flag == 0.0 then
      if x<(-b*a) then flag=0.0; F=-K;
      elseif x<a then flag=0.0; F=0;
      else flag=1.0; F=K;
      end if;
    else   
      if x>(b*a) then flag=1.0; F=K;
      elseif x>(-a) then flag=1.0; F=0;
      else flag=0.0; F=-K;
      end if;
    end if;      
    
    der(v) = (-F) - k2 * x + k3 * sin(k4 * time);
    der(x) = v;
  

  end func_5;
end LR_2;
