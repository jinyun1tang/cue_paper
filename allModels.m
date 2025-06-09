%run all models using constant temperature
%Jinyun Tang (jinyuntang@lbl.gov)
%Created on May, 2025

close all;
clear all;
addpath('./Models/');
addpath('/Users/jinyuntang/work/github/matlab_tools/ds2nfu/');
global pirtModelPar;
global ComproModelPar;
global mDroopModelPar;
global VISModelPar;
global sDEBModelPar;
global mDEBModelPar;
setPars();
y01=sPirtModel(pirtModelPar);dydt1=PirtModel([y01,0,0,0],pirtModelPar.T0,pirtModelPar);
y02=sComproModel(ComproModelPar);dydt2=ComproModel([y02,0,0,0],ComproModelPar.T0,ComproModelPar);
y03=smDroopModel(mDroopModelPar);dydt3=mDroopModel([y03,0,0,0],mDroopModelPar.T0,mDroopModelPar);
y04=sVISModel(VISModelPar);dydt4=VISModel([y04,0,0,0],VISModelPar.T0,VISModelPar);
y05=ssDEBModel(sDEBModelPar);dydt5=sDEBModel([y05,0,0,0],sDEBModelPar.T0,sDEBModelPar);
y06=smDEBModel(mDEBModelPar);dydt6=mDEBModel([y06,0,0,0],mDEBModelPar.T0,mDEBModelPar);
nyr=50;
if isfile('dnpp.mat')
    load('dnpp.mat');
else
    dnpp=randn(nyr,1).*50;
end
tspan=[0,nyr];
ns=5000;
par=pirtModelPar;par.dnpp=dnpp;

[t1,y1]=euler_driver([y01,0,0,0],tspan,ns,@PirtModel,par);
figure;
for jj=1:3
    subplot(4,1,jj);
    plot(t1',y1(:,jj));title(par.poolnames{jj});
end
subplot(4,1,4);
plot(diff(y1(:,par.vid.hup))./y1(2:end,par.vid.Cb),1-diff(y1(:,par.vid.CO2))./diff(y1(:,par.vid.hup)));
title('Pirt model CUE');

par=ComproModelPar;par.dnpp=dnpp;
[t2,y2]=euler_driver([y02,0,0,0],tspan,ns,@ComproModel,par);
figure;
for jj=1:3
    subplot(4,1,jj);
    plot(t2',y2(:,jj));title(par.poolnames{jj});
end

subplot(4,1,4);
plot(diff(y2(:,par.vid.hup))./y2(2:end,par.vid.Cb),1-diff(y2(:,par.vid.CO2))./diff(y2(:,par.vid.hup)));
title('Compromise model CUE');

par=mDroopModelPar;par.dnpp=dnpp;
[t3,y3]=euler_driver([y03,0,0,0],tspan,ns,@mDroopModel,par);
figure;
for jj=1:4
    subplot(5,1,jj);
    if(jj==3)
        plot(t3',y3(:,jj)-y3(:,4));
    else
        plot(t3',y3(:,jj));
    end    
    title(par.poolnames{jj});
end
subplot(5,1,5);
plot(diff(y3(:,par.vid.hup))./y3(2:end,par.vid.BV),1-diff(y3(:,par.vid.CO2))./diff(y3(:,par.vid.hup)));
title('mDroop model CUE');

par=VISModelPar;par.dnpp=dnpp;
[t4,y4]=euler_driver([y04,0,0,0],tspan,ns,@VISModel,par);
figure;
for jj=1:4
    subplot(5,1,jj);
    plot(t4',y4(:,jj));title(par.poolnames{jj});
end
subplot(5,1,5);
plot(diff(y4(:,par.vid.hup))./y4(2:end,par.vid.BV),1-diff(y4(:,par.vid.CO2))./diff(y4(:,par.vid.hup)));
title('VIS model CUE');

par=sDEBModelPar;par.dnpp=dnpp;

[t5,y5]=euler_driver([y05,0,0,0],tspan,ns,@sDEBModel,par);
figure;
for jj=1:4
    subplot(5,1,jj);
    plot(t5',y5(:,jj));title(par.poolnames{jj});
end
subplot(5,1,5);
plot(diff(y5(:,par.vid.hup))./y5(2:end,par.vid.BV),1-diff(y5(:,par.vid.CO2))./diff(y5(:,par.vid.hup)));
title('sDEB model CUE');

par=mDEBModelPar;par.dnpp=dnpp;
[t6,y6]=euler_driver([y06,0,0,0],tspan,ns,@mDEBModel,par);
figure;
for jj=1:4
    subplot(5,1,jj);
    plot(t6',y6(:,jj));title(par.poolnames{jj});
end
subplot(5,1,5);
plot(diff(y6(:,par.vid.hup))./y6(2:end,par.vid.BV),1-diff(y6(:,par.vid.CO2))./diff(y6(:,par.vid.hup)));
title('mDEB model CUE');
close all;
%%
fig=figure;
ax=multipanel(fig,4,1,[.1,.06],[0.8,0.185],[0.05,0.055],'portrait');

set_curAX(fig,ax(1));

plot(dnpp(1:nyr)+300,'LineWidth',1.5);
ylabel('Carbon input (gC m^-^2 yr^-^1)');

set_curAX(fig,ax(2));
plot(t1,y1(:,1),'LineWidth',2);
hold on;
plot(t2,y2(:,1),'LineWidth',2);
plot(t3,y3(:,1),'LineWidth',2);
plot(t4,y4(:,1),'LineWidth',2);
plot(t5,y5(:,1),'LineWidth',2);
plot(t6,y6(:,1),'LineWidth',2);
ylabel('Fast pool C (gC m^-^2)');

set_curAX(fig,ax(3));
plot(t1,y1(:,2),'LineWidth',2);
hold on;
plot(t2,y2(:,2),'LineWidth',2);
plot(t3,y3(:,2),'LineWidth',2);
plot(t4,y4(:,2),'LineWidth',2);
plot(t5,y5(:,2),'LineWidth',2);
plot(t6,y6(:,2),'LineWidth',2);
ylabel('Slow pool C (gC m^-^2)');
legend('Pirt Model','Comp Model','mDroop Model','VIS Model','sDEB Model','mDEB model','Orientation','Horizontal');
%ylim([1100,1500]);


set_curAX(fig,ax(4));
plot(t1,y1(:,3),'LineWidth',2);
hold on;
plot(t2,y2(:,3),'LineWidth',2);
plot(t3,y3(:,3),'LineWidth',2);
plot(t4,y4(:,3)+y4(:,4),'LineWidth',2);
plot(t4,y5(:,3)+y5(:,4),'LineWidth',2);
plot(t4,y6(:,3)+y6(:,4),'LineWidth',2);
ylabel('Microbial biomass C (gC m^-^2)');
xlabel('Ordinal year');
set(ax,'FontSize',18);

put_tag(fig,ax(1),[0.03,0.93],'(a)',18);
put_tag(fig,ax(2),[0.03,0.93],'(b)',18);
put_tag(fig,ax(3),[0.03,0.93],'(c)',18);
put_tag(fig,ax(4),[0.03,0.93],'(d)',18);


%%
fig=figure;
ax=multipanel(fig,3,1,[.1,.08],[0.8,0.25],[0.05,0.075],'portrait');
set_curAX(fig,ax(1));
par=pirtModelPar;
hdl(1)=plot(diff(y1(:,par.vid.hup))./y1(2:end,par.vid.Cb)./(t1(2)-t1(1)),1-diff(y1(:,par.vid.CO2))./diff(y1(:,par.vid.hup)),'-','LineWidth',1.5);
hold on;
hdl(2)=plot(diff(y2(:,par.vid.hup))./(y2(2:end,par.vid.Cb))./(t2(2)-t2(1)),1-diff(y2(:,par.vid.CO2))./diff(y2(:,par.vid.hup)),'-.','LineWidth',1.5);
ylabel('Total biomass CUE');
xlabel('Specific C uptake rate  [gC substrate (gC biomass yr)^-^1]');
legend('Pirt Model','Comp Model','location','southeast');
ylim([0.42,0.45])
%xlim([2.4,3.0]);

par=mDroopModelPar;
set_curAX(fig,ax(2));
hdl(1)=plot(diff(y3(:,par.vid.hup))./y3(2:end,par.vid.BV)./(t3(2)-t3(1)),1-diff(y3(:,par.vid.CO2))./diff(y3(:,par.vid.hup)),'LineWidth',1.5);
ylabel('Total biomass CUE');
xlabel('Specific C uptake rate  [gC substrate (gC biomass yr)^-^1]');
ylim([0.42,0.45])
legend('mDroop Model','location','southeast');
%set(ax(2),'Ylim',[0.41,0.45]);

par=mDEBModelPar;
set_curAX(fig,ax(3));

hdl(1)=plot(diff(y4(:,par.vid.hup))./y4(2:end,par.vid.BV)./(t4(2)-t4(1)),1-diff(y4(:,par.vid.CO2))./diff(y4(:,par.vid.hup)),'LineWidth',1.5);
hold on;
hdl(2)=plot(diff(y5(:,par.vid.hup))./(y5(2:end,par.vid.BV))./(t5(2)-t5(1)),1-diff(y5(:,par.vid.CO2))./diff(y5(:,par.vid.hup)),'LineWidth',1.5);
hdl(3)=plot(diff(y6(:,par.vid.hup))./(y6(2:end,par.vid.BV))./(t6(2)-t6(1)),1-diff(y6(:,par.vid.CO2))./diff(y6(:,par.vid.hup)),'LineWidth',1.5);
ylabel('Total biomass CUE');
xlabel('Specific C uptake rate [gC substrate (gC biomass yr)^-^1]');
ylim([0.42,0.45])
legend('VIS Model','sDEB Model','mDEB Model','location','southeast');
set(ax,'FontSize',18);
%set(ax(2:3),'Xlim',[2.6,3.2]);
put_tag(fig,ax(1),[0.025,0.9],'(a)',18);
put_tag(fig,ax(2),[0.025,0.9],'(b)',18);
put_tag(fig,ax(3),[0.025,0.9],'(c)',18);

%%
fig=figure;
ax=multipanel(fig,2,1,[.1,.1],[0.8,0.38],[0.05,0.075],'portrait');
set(ax,'Xlim',[1.8,3.2]);
set(ax(1),'Ylim',[0.44,0.45]);
set(ax(2),'Ylim',[0.435,0.441]);
%set(ax(1),'Xlim',[2.3,3.2],'Ylim',[0.436,0.444]);
par=mDroopModelPar;
hdl(1)=arrowPlot(fig,ax(1),diff(y3(:,par.vid.hup))./y3(2:end,par.vid.BV)./(t3(2)-t3(1)),1-diff(y3(:,par.vid.CO2))./diff(y3(:,par.vid.hup)),300);
hold on;
hdl(2)=arrowPlot(fig,ax(1),diff(y3(:,par.vid.hup))./(y3(2:end,par.vid.Bc))./(t3(2)-t3(1)),1-diff(y3(:,par.vid.CO2))./diff(y3(:,par.vid.hup)),300);
box on;
ylabel('Total biomass CUE');
xlabel('Specific C uptake rate [gC substrate (gC biomass yr)^-^1]');
legend('Uptake normalized by structural biomass','Uptake normalized by total biomass','location','southeast');

par=mDEBModelPar;
%set(ax(2),'Xlim',[2.3,3.2],'Ylim',[0.416,0.424]);
arrowPlot(fig,ax(2),diff(y6(:,par.vid.hup))./y6(2:end,par.vid.BV)./(t6(2)-t6(1)),1-diff(y6(:,par.vid.CO2))./diff(y6(:,par.vid.hup)),300);
hold on;
arrowPlot(fig,ax(2),diff(y6(:,par.vid.hup))./(y6(2:end,par.vid.BV)+y6(2:end,par.vid.Bc))./(t6(2)-t6(1)),1-diff(y6(:,par.vid.CO2))./diff(y6(:,par.vid.hup)),300);
box on;
ylabel('Total biomass CUE');
xlabel('Specific C uptake rate [gC substrate (gC biomass yr)^-^1]');

legend('Uptake normalized by structural biomass','Uptake normalized by total biomass','location','southeast');

set(ax,'FontSize',18);
put_tag(fig,ax(1),[0.025,0.9],'(a) mDroop Model',18);
put_tag(fig,ax(2),[0.025,0.9],'(b) mDEB Model',18);
%%
fig=figure;
ax=multipanel(fig,2,2,[.1,.1],[0.4,0.4],[0.075,0.075],'portrait');
set(ax,'FontSize',18,'Xlim',[2.,3.2],'Ylim',[0.37,0.41]);

set_curAX(fig,ax(1));
%set(ax(1),'YLim',[.37,.382]);
par=mDroopModelPar;
dt=(t3(2)-t3(1));
hdl=arrowPlot(fig,ax(1),diff(y3(:,par.vid.hup))./y3(2:end,par.vid.BV)./dt,diff(y3(:,par.vid.cue))./dt,200);
ylabel('Structural biomass CUE');
box on;

set_curAX(fig,ax(2));
%set(ax(2),'YLim',[.37,.382]);
par=mDEBModelPar;
dt=(t4(2)-t4(1));
hdl=arrowPlot(fig,ax(2),diff(y4(:,par.vid.hup))./y4(2:end,par.vid.BV)./dt,diff(y4(:,par.vid.cue))./dt,200);
box on;

set_curAX(fig,ax(3));
%set(ax(3),'YLim',[.37,.382]);
dt=(t5(2)-t5(1));
hdl=arrowPlot(fig,ax(3),diff(y5(:,par.vid.hup))./y5(2:end,par.vid.BV)./dt,diff(y5(:,par.vid.cue))./dt,200);
xlabel('Specific C uptake rate [gC substrate (gC biomass yr)^-^1]');
ylabel('Structural biomass CUE');
box on;

set_curAX(fig,ax(4));
%set(ax(4),'YLim',[.37,.382]);
dt=(t6(2)-t6(1));
hdl=arrowPlot(fig,ax(4),diff(y6(:,par.vid.hup))./y6(2:end,par.vid.BV)./dt,diff(y6(:,par.vid.cue))./dt,200);

box on;

xlabel('Specific C uptake rate [gC substrate (gC biomass yr)^-^1]');
put_tag(fig,ax(1),[0.025,0.9],'(a) mDroop Model',18);
put_tag(fig,ax(2),[0.025,0.9],'(b) VIS Model',18);
put_tag(fig,ax(3),[0.025,0.9],'(c) sDEB Model',18);
put_tag(fig,ax(4),[0.025,0.9],'(d) mDEB Model',18);

%%
function [t,y]=euler_driver(y0,tspan,ns,model,par)
%
% Euler integrator of model
par1=par;

dt=(tspan(2)-tspan(1))/ns;
t=(tspan(1):dt:tspan(2));
y1=y0;

nel=numel(t);
n=0;
y=zeros(nel,numel(y0));
nl=numel(y0);
while(n<nel)
    y(n+1,:)=y1;
    lyr=fix(t(n+1)-dt)+1;               %current year   
    par1.Fnpp=par.Fnpp+par1.dnpp(lyr);  %current C input rate
    dydt2=model(y1,par.T0,par1);
    y2=y1+dydt2.*dt;
    pp=1;
    for jj = 1 : nl
        if(y2(jj)<0)
            pp1=abs(y1(jj)/(dydt2(jj)*dt))*0.9999;
            pp=min(pp,pp1);
        end
    end
    if(pp<1)
        y1=y1+dydt2.*dt.*pp;
    else
        y1=y2;
    end
    n=n+1;
end
end


