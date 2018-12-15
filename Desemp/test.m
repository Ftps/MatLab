vec = -4 + 8*rand(1,3);

mag = sqrt(sum(vec.*vec));

figure('Name','Transformacao de Vetores','rend','painters','pos',[0 0 1600 800])

subplot(1,2,1);

quiver3(0,0,0,vec(1), vec(2), vec(3)')
hold on
quiver3(-mag,0,0,2*mag,0,0,'k')
quiver3(0,-mag,0,0,2*mag,0,'k')
quiver3(0,0,-mag,0,0,2*mag,'k')
quiver3(vec(1),0,0,0,vec(2),0,'--r')
quiver3(0,vec(2),0,vec(1),0,0,'--r')
quiver3(vec(1),vec(2),0,0,0,vec(3),'--r')
view(135,30)
axis([-mag mag -mag mag -mag mag ])
xlabel('Eixo X');
ylabel('Eixo Y');
zlabel('Eixo Z');

subplot(1,2,2);

quiver3(0,0,0,vec(1), vec(2), vec(3))
hold on
quiver3(-mag,0,0,2*mag,0,0,'k')
quiver3(0,-mag,0,0,2*mag,0,'k')
quiver3(0,0,-mag,0,0,2*mag,'k')
quiver3(vec(1),0,0,0,vec(2),0,'--r')
quiver3(0,vec(2),0,vec(1),0,0,'--r')
quiver3(vec(1),vec(2),0,0,0,vec(3),'--r')
view(135,30)
axis([-mag mag -mag mag -mag mag ])
xlabel('Eixo X');
ylabel('Eixo Y');
zlabel('Eixo Z');

title(subplot(1,2,1), 'Eixos dos Ventos');
title(subplot(1,2,2), 'Eixos do Corpo');

hold off
