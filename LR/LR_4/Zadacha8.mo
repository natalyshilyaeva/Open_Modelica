package Zadacha8
  model Water
  
    parameter Real pv = 1000;       //плотность воды
    parameter Real rs = 1;          //коэффициент пропорцианальности
    parameter Real R = 3;           //плотность воды
    parameter Real pi = 3.14;     //число пи
    Real Vpv;         //объем пробки под водой
    Real xv;          //разница уровня воды, в сравнении с прошлым
    Real mpr;         //присоединенная масса
    Real Fa;          //сила архимеда
    Real Fs;          //сила сопротивления
    ValInput h;
    ValInput xp;
    ValInput r;
    ValInput Vp;
    ValInput g;
    ValOutput mpr_Out;
    ValOutput Fa_Out;
    ValOutput Fs_Out;
   
  equation
  
    Fa = pv*Vpv*g.Val;
    Fs = -r.Val*Vp.Val;
    mpr = pv*Vpv;
    xv = (r.Val^2)*xp.Val/((R^2)-(r.Val^2));
  
    if ((xp.Val + xv) < h.Val) and ((xp.Val + xv) > 0) then 
      Vpv = pi*(r.Val^2)*(xp.Val + xv);
    elseif ((xp.Val + xv) > h.Val) then 
      Vpv = pi*(r.Val^2)*h.Val;  
    else Vpv = 0;  //elseif (xp.Val + xv) < 0 then
    end if;
    mpr_Out.Val = mpr;
    Fa_Out.Val = Fa;
    Fs_Out.Val = Fs;
  
  end Water;

  connector ValOutput
    output Real Val;
  end ValOutput;

  connector ValInput
    input Real Val;
  end ValInput;

  model Environment
  
    parameter Real g = 9.8;         //ускорение свободного падения
    ValOutput g_Out;
    
  equation
    
    g_Out.Val = g;
  
  end Environment;

  model Cork
  
    parameter Real r = 0.6;         //радиус пробки
    parameter Real h = 0.5;         //высота пробки
    parameter Real s = 1;           //площадь дна пробки
    parameter Real p = 2;           //плотность пробки
    parameter Real V0 = 1;          //скорость пробки в начальный момент
    parameter Real x0 = 5;          //глубина погружения пробки в начальный момент
    parameter Real f = 0;           //флаг
    Real xp(start = 5);       //разница положения дна пробки , в сравнении с прошлым уровнем воды
    Real Vp(start = 1);       //скорость пробки
    Real m;                   //масса пробки
    ValInput mpr;
    ValInput Fa;
    ValInput Fs;
    ValInput g;  
    ValOutput h_Out;
    ValOutput xp_Out;
    ValOutput r_Out;
    ValOutput Vp_Out;
    
  equation
    
    m = p*h*s;
   
    der(xp) = Vp; 
    (mpr.Val + m)*der(Vp) = m*g.Val-Fa.Val-Fs.Val; 
    
    h_Out.Val = h;
    xp_Out.Val = xp;
    r_Out.Val = r;  
    Vp_Out.Val = Vp;
    
  end Cork;

  model Bung

    Water W;
    Cork C;
    Environment E;
    
  equation
  
    connect(W.mpr_Out, C.mpr);
    connect(W.Fa_Out, C.Fa);
    connect(W.Fs_Out, C.Fs);
    connect(C.h_Out, W.h);
    connect(C.xp_Out, W.xp);
    connect(C.r_Out, W.r);
    connect(C.Vp_Out, W.Vp);  
    connect(E.g_Out, W.g);
    connect(E.g_Out, C.g);
  
  annotation(
      experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-6, Interval = 0.002));end Bung;
end Zadacha8;
