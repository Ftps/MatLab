g = 0;
x = 0;
u = 0;
t = 0;
l = 0;
a = 0;
o = 0;

while(1)
    fn1 = { 'Eixos Terrestres','Eixos do Horizontal Local','Eixos do Vento',...
              'Eixos da Aeronave' };

    [i1] = listdlg('PromptString','Eixo inicial:',...
                                 'SelectionMode','single',...
                                 'ListString',fn1);
    [i2] = listdlg('PromptString','Eixo final:',...
                                 'SelectionMode','single',...
                                 'ListString',fn1);

    soma = 2^i1+2^i2; % Valor para escolha binária

    if (soma~=6 && soma~=10 && soma~=18 && soma~=12 && soma~=20 && soma~=24)
        titulo ='Erro!';
        msg = 'Erro na escolha de eixos, componentes do vetor não se alteram.';
        icone = 'warn';
        waitfor(msgbox(msg, titulo, icone));
        continue;
    else
        break;
    end
end % ciclo de escolha de eixos

while(1)
    titulo = 'Componentes de Vetor no Eixo Inicial:';
    campos = {'x', 'y', 'z'};
    dados =  inputdlg (campos, titulo, [1 100]); 

    veci = [str2double(dados{1}); str2double(dados{2}); str2double(dados{3})];
    vecf = [0; 0; 0];

    if(isnan(veci(1)) || isnan(veci(2)) || isnan(veci(3)))
        titulo ='Erro!';
        msg = 'Erro na introducao das componentes dos vetores.';
        icone = 'warn';
        waitfor(msgbox(msg, titulo, icone));
        continue;
    else
        break;
    end
end % ciclo para introduzir as coordenadas do vetor no referencial inicial

while(1)
    
    titulo = 'Angulos Necessarios:';
    
    switch(soma)

            case (6)
                campos = {'latitude:', 'longitude:'};
                dados =  inputdlg (campos, titulo, [1 100]); 
                l = str2double(dados{1})*pi/180;
                t = str2double(dados{2})*pi/180;

            case (10)        
                campos = {'latitude:', 'longitude:', '\chi :', '\mu :', '\gamma :'};
                dados =  inputdlg (campos, titulo, [1 100]);
                l = str2double(dados{1})*pi/180;
                t = str2double(dados{2})*pi/180;
                x = str2double(dados{3})*pi/180;
                u = str2double(dados{4})*pi/180;
                g = str2double(dados{5})*pi/180;


            case (12)
                campos = {'\chi :','\mu: ', '\gamma :', '\alpha', '\sigma'};
                dados =  inputdlg (campos, titulo, [1 100]);
                x = str2double(dados{1})*pi/180;
                u = str2double(dados{2})*pi/180;
                g = str2double(dados{3})*pi/180;
                a = str2double(dados{4})*pi/180;
                o = str2double(dados{5})*pi/180;


       case (18)
                campos = {'latitude:', 'longitude:', '\chi :', '\mu :', '\gamma :', '\alpha', '\sigma'};
                dados =  inputdlg (campos, titulo, [1 100]);
                l = str2double(dados{1})*pi/180;
                t = str2double(dados{2})*pi/180;
                x = str2double(dados{3})*pi/180;
                u = str2double(dados{4})*pi/180;
                g = str2double(dados{5})*pi/180;
                a = str2double(dados{6})*pi/180;
                o = str2double(dados{7})*pi/180;


        case (20)
                campos = {'\chi', '\mu :', '\gamma', '\miu', '\alpha', '\sigma'};
                dados =  inputdlg (campos, titulo, [1 100]);
                x = str2double(dados{1})*pi/180;
                u = str2double(dados{2})*pi/180;
                g = str2double(dados{3})*pi/180;
                a = str2double(dados{4})*pi/180;
                o = str2double(dados{5})*pi/180;


         case (22)
                campos = {'\alpha', '\sigma'};
                dados =  inputdlg (campos, titulo, [1 100]);
                a = str2double(dados{1})*pi/180;
                o = str2double(dados{2})*pi/180;

    end

    if(isnan(g) || isnan(x) || isnan(u) || isnan(l) || isnan(t) || isnan(a) || isnan(o))
        titulo ='Erro!';
        msg = 'Erro na introducao dos ângulos.';
        icone = 'warn';
        waitfor(msgbox(msg, titulo, icone));
        continue;
    else
        break;
    end
end % ciclo para introduir a informação necessária para realizar a mudança de eixos

wh = [cos(g)*cos(x) cos(g)*sin(x) -sin(g);                                                      %
      sin(u)*sin(g)*cos(x)-cos(u)*sin(x) cos(u)*cos(x)+sin(u)*sin(g)*sin(x) sin(u)*cos(g);      % matriz mudança de Eixos do Horizonte Local para Eixos do Vento
      sin(u)*sin(x)+cos(u)*sin(g)*cos(x) cos(u)*sin(g)*sin(x)-sin(u)*cos(x) cos(u)*cos(g)];     %

ht = [cos(t) 0 sin(t);                                                                          %
      -sin(t)*sin(l) cos(l) cos(t)*sin(l);                                                      % matriz mudança de Eixos Terrestres para Eixos do Horizonte Local
      -sin(t)*cos(l) -sin(l) cos(t)*cos(l)];                                                    %

bw = [cos(a)*cos(o) cos(a)*sin(o) -sin(a);                                                      %
      -sin(o) cos(o) 0;                                                                         % matriz mudança de Eixos do Vento para Eixos da Aeronave
      sin(a)*cos(o) sin(a)*sin(o) cos(a)];                                                      %

switch(soma)  % swtich para reaizar a transformação pretendida ao vetor
    case 6
        if i1 < i2
           vecf = ht*veci;
           str1 = sprintf('Eixos Terrestres, vetor = (%d)i + (%d)j + (%d)k', veci(1), veci(2), veci(3));
           str2 = sprintf('Eixos do Horizonte Local, vetor = (%d)i + (%d)j + (%d)k',vecf(1), vecf(2), vecf(3));
        else
           vecf = ht'*veci;
           str1 = sprintf('Eixos do Horizonte Local, vetor = (%d)i + (%d)j + (%d)k', veci(1), veci(2), veci(3));
           str2 = sprintf('Eixos Terrestres, vetor = (%d)i + (%d)j + (%d)k', veci(1), veci(2), veci(3));
        end
    case 10
        if i1 < i2
           vecf = wh*ht*veci;
           str1 = sprintf('Eixos Terrestres, vetor = (%d)i + (%d)j + (%d)k', veci(1), veci(2), veci(3));
           str2 = sprintf('Eixos do Vento, vetor = (%d)i + (%d)j + (%d)k',vecf(1), vecf(2), vecf(3));
        else
           vecf = ht'*wh'*veci;
           str1 = sprintf('Eixos do Vento, vetor = (%d)i + (%d)j + (%d)k', veci(1), veci(2), veci(3));
           str2 = sprintf('Eixos Terrestres, vetor = (%d)i + (%d)j + (%d)k',vecf(1), vecf(2), vecf(3));
        end
    case 12
        if i1 < i2
           vecf = wh*veci;
           str1 = sprintf('Eixos do Horizonte Local, vetor = (%d)i + (%d)j + (%d)k', veci(1), veci(2), veci(3));
           str2 = sprintf('Eixos do Vento, vetor = (%d)i + (%d)j + (%d)k',vecf(1), vecf(2), vecf(3));
        else
           vecf = wh'*veci;
           str1 = sprintf('Eixos do Vento, vetor = (%d)i + (%d)j + (%d)k', veci(1), veci(2), veci(3));
           str2 = sprintf('Eixos do Horizonte Local, vetor = (%d)i + (%d)j + (%d)k',vecf(1), vecf(2), vecf(3));
        end
    case 18
        if i1 < i2
           vecf = bw*wh*ht*veci;
           str1 = sprintf('Eixos Terrestres, vetor = (%d)i + (%d)j + (%d)k', veci(1), veci(2), veci(3));
           str2 = sprintf('Eixos da Aeronave, vetor = (%d)i + (%d)j + (%d)k',vecf(1), vecf(2), vecf(3));
        else
           vecf = ht'*wh'*bw'*veci;
           str1 = sprintf('Eixos da Aeronave, vetor = (%d)i + (%d)j + (%d)k', veci(1), veci(2), veci(3));
           str2 = sprintf('Eixos Terrestres, vetor = (%d)i + (%d)j + (%d)k',vecf(1), vecf(2), vecf(3));
        end
    case 20
        if i1 < i2
           vecf = bw*wh*veci;
           str1 = sprintf('Eixos do Horizonte Local, vetor = (%d)i + (%d)j + (%d)k', veci(1), veci(2), veci(3));
           str2 = sprintf('Eixos da Aeronave, vetor = (%d)i + (%d)j + (%d)k',vecf(1), vecf(2), vecf(3));
        else
           vecf = wh'*bw'*veci;
           str1 = sprintf('Eixos da Aeronave, vetor = (%d)i + (%d)j + (%d)k', veci(1), veci(2), veci(3));
           str2 = sprintf('Eixos do Horizonte Local, vetor = (%d)i + (%d)j + (%d)k',vecf(1), vecf(2), vecf(3));
        end
    case 24
        if i1 < i2
           vecf = bw*veci;
           str1 = sprintf('Eixos do Vento, vetor = (%d)i + (%d)j + (%d)k', veci(1), veci(2), veci(3));
           str2 = sprintf('Eixos da Aeronave, vetor = (%d)i + (%d)j + (%d)k',vecf(1), vecf(2), vecf(3));
        else
           vecf = bw'*veci;
           str1 = sprintf('Eixos da Aeronave, vetor = (%d)i + (%d)j + (%d)k', veci(1), veci(2), veci(3));
           str2 = sprintf('Eixos do Vento, vetor = (%d)i + (%d)j + (%d)k',vecf(1), vecf(2), vecf(3));
        end
end

show_vector(veci, vecf, str1, str2) % representação gráfica e numérica dos vetores inicial e final


%%%% Função que representa graficamente e numericamente os vetores inicial e final %%%% 

function [ ] = show_vector(veci, vecf, str1, str2)
    
    mag = sqrt(sum(veci.*veci));

    figure('Name','Transformacao de Vetores','rend','painters','pos',[0 0 1600 800])

    subplot(1,2,1);

    quiver3(0,0,0,veci(1), veci(2), veci(3)') % vetor inicial
    hold on
    quiver3(-mag,0,0,2*mag,0,0,'k')     %
    quiver3(0,-mag,0,0,2*mag,0,'k')     % eixos iniciais
    quiver3(0,0,-mag,0,0,2*mag,'k')     %
    quiver3(veci(1),0,0,0,veci(2),0,'--r')          %
    quiver3(0,veci(2),0,veci(1),0,0,'--r')          % componentes do vetor inicial
    quiver3(veci(1),veci(2),0,0,0,veci(3),'--r')    %
    view(135,30)
    axis([-mag mag -mag mag -mag mag ])
    xlabel('Eixo X');
    ylabel('Eixo Y');
    zlabel('Eixo Z');

    subplot(1,2,2);

    quiver3(0,0,0,vecf(1), vecf(2), vecf(3))    %vetor final
    hold on
    quiver3(-mag,0,0,2*mag,0,0,'k')     %
    quiver3(0,-mag,0,0,2*mag,0,'k')     % eixos finais
    quiver3(0,0,-mag,0,0,2*mag,'k')     %
    quiver3(vecf(1),0,0,0,vecf(2),0,'--r')          %
    quiver3(0,vecf(2),0,vecf(1),0,0,'--r')          % componentes do vetor final
    quiver3(vecf(1),vecf(2),0,0,0,vecf(3),'--r')    %
    view(135,30)
    axis([-mag mag -mag mag -mag mag ])
    xlabel('Eixo X');
    ylabel('Eixo Y');
    zlabel('Eixo Z');

    title(subplot(1,2,1), str1);
    title(subplot(1,2,2), str2);

    hold off
end