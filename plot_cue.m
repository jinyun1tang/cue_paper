%Plot Figure 2 of the paper
%Jinyun Tang (jinyuntang@lbl.gov)
%Created on Dec, 2024

close all;
clear all;
addpath('/Users/jinyuntang/work/github/matlab_tools');

[yv1,mu1,q1]=pirt_model();

[yv2,mu2,q2]=compromise_model();

[yv3,yb3,mu3,q3,c1,c2,QC_min]=rDroop_model();

[yv4,yb4,mu4,q4,YRV4,mV4]=VIS_model();

[yv5,yb5,mu5,q5,YRV5,mV5]=sdeb_model();

[yv6,yb6,mu6,q6,YRV6,mV6]=mdeb_model();


fig=1;
ax=multipanel(fig,2,3,[.06,.1],[.26,0.375],[0.04,0.08]);
set_curAX(fig,ax(1));plot(mu1,yv1,'LineWidth',2);hold on;plot(mu1,yv1,'--','LineWidth',2);legend('Structural biomass: Y_V','Total biomass: Y_B','location','east');
set_curAX(fig,ax(2));plot(mu2,yv2,'LineWidth',2);hold on;plot(mu2,yv2,'--','LineWidth',2);legend('Structural biomass: Y_V','Total biomass: Y_B','location','east');
set_curAX(fig,ax(3));plot(mu3,yv3,'LineWidth',2);hold on;plot(mu3,yb3,'--','LineWidth',2);legend('Structural biomass: Y_V','Total biomass: Y_B','location','east');
set_curAX(fig,ax(4));plot(mu4,yv4,'LineWidth',2);hold on;plot(mu4,yb4,'--','LineWidth',2);legend('Structural biomass: Y_V','Total biomass: Y_B','location','east');
set_curAX(fig,ax(5));plot(mu5,yv5,'LineWidth',2);hold on;plot(mu5,yb5,'--','LineWidth',2);legend('Structural biomass: Y_V','Total biomass: Y_B','location','east');
set_curAX(fig,ax(6));plot(mu6,yv6,'LineWidth',2);hold on;plot(mu6,yb6,'--','LineWidth',2);legend('Structural biomass: Y_V','Total biomass: Y_B','location','east');
set(ax,'FontSize',18,'Ylim',[0,1]);
fontsz=20;
put_tag(fig,ax(1),[.025,.95],'(a) Pirt model',24);ylabel('CUE/Y_S','FontSize',fontsz);xlabel('Specific growth rate (\mu/m_V)','FontSize',fontsz);
put_tag(fig,ax(2),[.025,.95],'(b) Compromise model',24);xlabel('Specific growth rate (\mu/m_V)','FontSize',fontsz);
put_tag(fig,ax(3),[.025,.95],'(c) mDroop model',24);xlabel('Specific growth rate (\mu/\mu_m_a_x)','FontSize',fontsz);
put_tag(fig,ax(4),[.025,.95],'(d) VIS model',24);xlabel('Specific growth rate (\mu/v_E)','FontSize',fontsz);ylabel('CUE/Y_S','FontSize',fontsz);
put_tag(fig,ax(5),[.025,.95],'(e) sDEB model',24);xlabel('Specific growth rate (\mu/v_E)','FontSize',fontsz);
put_tag(fig,ax(6),[.025,.95],'(f) mDEB model',24);xlabel('Specific growth rate (\mu/v_E)','FontSize',fontsz);
put_tag(fig,ax(3),[.025,0.80],['c_1=',num2str(c1,3)],fontsz);
put_tag(fig,ax(3),[.025,0.7],['c_2=',num2str(c2,3),'\mu_m_a_x'],fontsz);
put_tag(fig,ax(3),[.025,0.6],['Q_m_i_n=',num2str(QC_min,3)],fontsz);

put_tag(fig,ax(4),[.0125,0.75],['Y_R_V=',num2str(YRV4,3)],fontsz);
put_tag(fig,ax(4),[.0125,0.85],['m_V=',num2str(mV4,3),'v_E'],fontsz);

put_tag(fig,ax(5),[.0125,0.7],['Y_R_V=',num2str(YRV5,3)],fontsz);
put_tag(fig,ax(5),[.0125,0.8],['m_V=',num2str(mV5,3),'v_E'],fontsz);

put_tag(fig,ax(6),[.0125,0.75],['Y_R_V=',num2str(YRV6,3)],fontsz);
put_tag(fig,ax(6),[.0125,0.85],['m_V=',num2str(mV6,3),'v_E'],fontsz);


fig=2;
ax=multipanel(fig,2,3,[.06,.1],[.26,0.375],[0.04,0.08]);
set_curAX(fig,ax(1));plot(q1,yv1,'LineWidth',2);hold on;plot(q1,yv1,'--','LineWidth',2);legend('Structural biomass: Y_V','Total biomass: Y_B');
set_curAX(fig,ax(2));plot(q2,yv2,'LineWidth',2);hold on;plot(q2,yv2,'--','LineWidth',2);legend('Structural biomass: Y_V','Total biomass: Y_B');
set_curAX(fig,ax(3));plot(q3,yv3,'LineWidth',2);hold on;plot(q3,yb3,'--','LineWidth',2);legend('Structural biomass: Y_V','Total biomass: Y_B');
set_curAX(fig,ax(4));plot(q4,yv4,'LineWidth',2);hold on;plot(q4,yb4,'--','LineWidth',2);legend('Structural biomass: Y_V','Total biomass: Y_B');
set_curAX(fig,ax(5));plot(q5,yv5,'LineWidth',2);hold on;plot(q5,yb5,'--','LineWidth',2);legend('Structural biomass: Y_V','Total biomass: Y_B');
set_curAX(fig,ax(6));plot(q6,yv6,'LineWidth',2);hold on;plot(q6,yb6,'--','LineWidth',2);legend('Structural biomass: Y_V','Total biomass: Y_B');

set(ax,'FontSize',18,'Ylim',[0,1.05],'Xlim',[0,15]);


put_tag(fig,ax(1),[.025,.95],'(a) Pirt model',24);ylabel('CUE/Y_S','FontSize',16);xlabel('Normalized specific carbon uptake rate (q/m_V)','FontSize',16);
put_tag(fig,ax(2),[.025,.95],'(b) Compromise model',24);xlabel('Normalized specific carbon uptake rate (q/m_V)','FontSize',16);
put_tag(fig,ax(3),[.025,.95],'(c) mDroop model',24);xlabel('Normalized specific carbon uptake rate (q/\mu_m_a_x)','FontSize',16);
put_tag(fig,ax(4),[.025,.95],'(d) VIS model',24);xlabel('Normalized specific carbon uptake rate (q/v_E)','FontSize',16);ylabel('CUE/Y_S','FontSize',16);
put_tag(fig,ax(5),[.025,.95],'(e) sDEB model',24);xlabel('Normalized specific carbon uptake rate (q/v_E)','FontSize',16);
put_tag(fig,ax(6),[.025,.95],'(f) mDEB model',24);xlabel('Normalized specific carbon uptake rate (q/v_E)','FontSize',16);
put_tag(fig,ax(3),[.25,0.74],['c_1=',num2str(c1,3)],16);
put_tag(fig,ax(3),[.25,0.64],['c_2=',num2str(c2,3),'\mu_m_a_x'],16);
put_tag(fig,ax(3),[.25,0.54],['Q_m_i_n=',num2str(QC_min,3)],16);
put_tag(fig,ax(3),[.25,0.84],['Y_S=',num2str(0.6,3)],16);


put_tag(fig,ax(4),[.25,0.62],['Y_R_V=',num2str(YRV4,3)],16);
put_tag(fig,ax(4),[.25,0.72],['m_V=',num2str(mV4,3),'v_E'],16);
put_tag(fig,ax(4),[.25,0.52],['Y_S=',num2str(0.6,3)],16);


put_tag(fig,ax(5),[.25,0.6],['Y_R_V=',num2str(YRV5,3)],16);
put_tag(fig,ax(5),[.25,0.7],['m_V=',num2str(mV5,3),'v_E'],16);
put_tag(fig,ax(5),[.25,0.5],['Y_S=',num2str(0.6,3)],16);


put_tag(fig,ax(6),[.25,0.6],['Y_R_V=',num2str(YRV6,3)],16);
put_tag(fig,ax(6),[.25,0.7],['m_V=',num2str(mV6,3),'v_E'],16);
put_tag(fig,ax(6),[.25,0.5],['Y_S=',num2str(0.6,3)],16);
set(ax,'FontSize',18);

function [cue,mu,q]=pirt_model()
%prit model
mu=(0:100).*0.08; %normalized by m_V
cue=mu./(mu+1);
cue=cue./max(cue);
YS=0.6;
q=(mu+1)./YS; %normalzied by m_V
end

function [cue,mu,q]=compromise_model()
mu=(0:100).*0.08;  %normalized by m_V
cue=mu./(mu+1);
cue=cue./max(cue);
YS=0.6;
q=(mu+1)./YS;  %normalized by m_V
end

function [YV,YB,mu,q,c1,c2,QC_min]=rDroop_model()
%Modified Droop model, Thingstad (1987)
QC_min=1.06;        %umol C/(10^9 cells)
%QC_max=2.12;       %umol C/(10^9 cells)
c1=1.0;             %proportionality factor between carbon incoporated and respired for growth
c2=0.05;            %fraction of surplus carbon respired h-1
mu_max=0.5;
YS=0.6;
c2=c2./mu_max;
mu=(1:100)./100;   %noramlzied by mu_max
YV=(1-mu)./((1+c1)+c2)./QC_min;
YB=1./(1+c1+c2./mu_max).*ones(size(mu));
q=((1+c1)+c2)./(1-mu).*QC_min./YS.*mu; %normalized by mu_max

end

function [YV,YB,mu,q,YRV,mV]=VIS_model()
%VIS model
mu=(0:99.99).*0.023;  %normalized by v_E
mV=0.1;          %normalized by v_E
YS=0.6;
YRV=0.8;

YV=mu./((1+mu).*mu+mV.*YRV).*YRV;
YB=(YRV+mu).*mu./((1+mu).*mu+mV.*YRV);
q=mu.*(1+mu)./(YS*YRV)+mV./YS;
%cue=cue./max(cue);
end

function [YV,YB,mu,q,YRV,mV]=sdeb_model()
%sDEB model
mu=(0:99).*0.01; %normalzied by v_E
mV=0.1;
YS=0.6;
YRV=0.8;
YV=mu./(mu+mV).*(1-mu).*YRV;
YB=mu./(mu+mV).*(YRV+mV+(1-YRV).*mu);
q=(mV+mu)./(YS.*YRV.*(1-mu));
end

function [YV,YB,mu,q,YRV,mV]=mdeb_model()
%mDEB model
mV=0.1;
YS=0.6;
YRV=0.8;
mu=(0:99.99).*0.023;  %normalzied by v_E
YV=mu./(mu+mV).*YRV./(1+mu);
YB=mu./(mu+mV).*(YRV+mu+mV)./(1+mu);
q=(1+mu).*(mu+mV)./(YRV*YS);
end