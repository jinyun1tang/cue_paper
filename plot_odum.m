%Plot figure 1 of the paper
%Jinyun Tang (jinyuntang@lbl.gov)
%Created on May, 2024

close all;
clear all;
clc;

p=(0:0.02:1);
epsl=0.03;

y=(1-p).*(1-epsl./p);
y=y./max(y);
plot(p,y,'LineWidth',2);
xlabel('P_1/c(fX_1)^2','FontSize',18);
ylabel('\eta/\eta_m_a_x','FontSize',18);
ylim([0,1.08]);
set(gca,'FontSize',18);