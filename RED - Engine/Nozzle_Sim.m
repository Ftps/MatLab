p0 = 101325*60;     % Chamber pressure
safety_marg = 2;    % Safety margin for yield strenght
d_eng = 0.048;       % Engine diameter
l_eng = 0.368;       % Engine lenght

[dc, de, m_dot, t_burn, T] = area(p0, d_eng, l_eng);

[t1, t2, t3, t4] = thick(p0, safety_marg, d_eng);

[m1, m2, m3, m4] = mass(m_dot, t_burn, d_eng, l_eng, t1, t2, t3, t4);

function [al_6, al_2, st_38, st_14] = thick(p0, safe, d_eng)

    t_st_14 = 690*10^6;     % Y.S. of A514 Steel
    t_st_38 = 2.617*10^9;   % Y.S. of A538 Steel
    t_al_2 = 414*10^6;      % Y.S. of 2014-T6 Aluminium
    t_al_6 = 270*10^6;      % Y.S. of 6061-T6 Aluminium
    
    al_2 = p0*d_eng*safe/(2*t_al_2);
    st_14 = p0*d_eng*safe/(2*t_st_14);
    st_38 = p0*d_eng*safe/(2*t_st_38);
    al_6 = p0*d_eng*safe/(2*t_al_6);
    
end

function [dc, de, m_dot, t_burn, T] = area(p0, d_eng, l_eng)

    R = 208.5919;       % Ideal gas constant for this mixture
    T0 = 1600;          % Nakka chamber temperature for KN-Sorbitol propellant
    k = 1.1361;         % Specific heat ratio for the gas mixture
    pe = 101325;        % Outside temperature
    rho_f = 1892.4;     % Solid fuel density
    
    r = 0.011;                                      % Burn rate - value obtained from Nakka at 80atm pressure for K-SORB
    t_burn = d_eng/(4*r);                           % Burn time
    m_dot = rho_f*l_eng*pi*(d_eng^2)/(4*t_burn);    % Mass burn rate
    
    rho_0 =p0/(R*T0);
    Me = sqrt((2/(k-1))*((p0/pe)^((k-1)/k) - 1));
    Arat = (1/Me)*(sqrt((1+(Me^2)*(k-1)/2)/(1+(k-1)/2))^((k+1)/(k-1)));     % Ratio between exit and throat area
    ac = (m_dot/(rho_0*sqrt(k*R*T0)))*(1+(k-1)/2)^((k+1)/(2*(1-k)));        % Critical area
    ae = ac*Arat;                                                           % Exit area
    
    dc = sqrt(4*ac/pi);
    de = sqrt(4*ae/pi);
    
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