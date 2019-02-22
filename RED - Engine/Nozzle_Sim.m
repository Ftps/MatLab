p0 = 101325*40;     % Chamber pressure
safety_marg = 2;    % Safety margin for yield strenght
d_eng = 0.065;      % Engine diameter
l_eng = 0.40;       % Engine lenght

[dc, de, m_dot, t_burn, T, isp] = area(p0, d_eng, l_eng);

[t1, t2, t3, t4] = thick(p0, safety_marg, d_eng);

[m1, m2, m3, m4] = mass(m_dot, t_burn, d_eng, l_eng, t1, t2, t3, t4);

Type = {'Engine Lenght - m'; 'Engine Diameter - cm'; 'Nozzle (Throat diameter) - cm'; 'Nozzle (Exit diameter) - cm'; 'Chamber Pressure - atm'; 'Thrust - N'; 'Burn Time - s'; 'Specific Impulse - s'};
Data_SI = [l_eng; d_eng*100; dc*100; de*100; p0/101325; T; t_burn; isp];
T = table(Type, Data_SI)

function [al_6, al_2, st_38, st_14] = thick(p0, safe, d_eng)

    t_st_14 = 0.690*10^9;   % Y.S. of A514 Steel
    t_st_38 = 2.617*10^9;   % Y.S. of A538 Steel
    t_al_2 = 0.414*10^9;    % Y.S. of 2014-T6 Aluminium
    t_al_6 = 0.270*10^9;    % Y.S. of 6061-T6 Aluminium
    
    al_2 = p0*d_eng*safe/(2*t_al_2);
    st_14 = p0*d_eng*safe/(2*t_st_14);
    st_38 = p0*d_eng*safe/(2*t_st_38);
    al_6 = p0*d_eng*safe/(2*t_al_6);
    
end

function [dc, de, m_dot, t_burn, T, isp] = area(p0, d_eng, l_eng)

    R = 208.5919;       % Ideal gas constant for this mixture
    T0 = 1600;          % Nakka chamber temperature for KN-Sorbitol propellant
    k = 1.1361;         % Specific heat ratio for the gas mixture
    pe = 101325;        % Outside temperature
    rho_f = 1892.4;     % Solid fuel density
    g = 9.80665;        % Surface gravity of Earth
    pc = p0*((2/(k+1))^(k/(k-1)));
    Tc = T0*2/(k+1);
    dcore = d_eng/3;
    
    r = 0.011;                                      % Burn rate - value obtained from Nakka at 80atm pressure for K-SORB (0.11 for 80, 0.008 for 40
    t_burn = (d_eng-dcore)/(2*r);                           % Burn time
    m_dot = rho_f*l_eng*pi*((d_eng^2)-(dcore^2))/(4*t_burn);    % Mass burn rate
    
    Me = sqrt((2/(k-1))*((p0/pe)^((k-1)/k) - 1));
    Arat = (1/Me)*(((1+(Me^2)*(k-1)/2)*(2/(k+1)))^((k+1)/(2*(k-1))));       % Ratio between exit and throat area
    ac = (m_dot/pc)*sqrt(R*Tc/k)*((k+1)/2)^((k+1)/(2*(1-k)));               % Critical area
    ae = ac*Arat;                                                           % Exit area
    
    dc = 2*sqrt(ac/pi);
    de = 2*sqrt(ae/pi);
    
    Te = T0/(1+(Me^2)*(k-1)/2);
    isp = Me*sqrt(k*R*Te)/g;
    
    T = m_dot*Me*sqrt((k*R*T0)/(1+0.5*(k-1)*Me^2));
end

function [ma6, ma2, ms38, ms14] = mass(m_dot, t_burn, d_eng, l_eng, t1, t2, t3, t4)

    pa6 = 2700;
    pa2 = 2800;
    ps38 = 8000;
    ps14 = 7800;


    ma6 = [pa6*l_eng*pi*(d_eng^2 - (d_eng-t1)^2)/4, m_dot*t_burn];
    ma2 = [pa2*l_eng*pi*(d_eng^2 - (d_eng-t2)^2)/4, m_dot*t_burn];
    ms38 = [ps38*l_eng*pi*(d_eng^2 - (d_eng-t3)^2)/4, m_dot*t_burn];
    ms14 = [ps14*l_eng*pi*(d_eng^2 - (d_eng-t4)^2)/4, m_dot*t_burn];
end