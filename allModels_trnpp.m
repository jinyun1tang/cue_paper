%run all models using transient temperature
%Jinyun Tang (jinyuntang@lbl.gov)
%Created on May, 2025
close all;
clear all;
addpath('./Models/');
addpath('/Users/jinyuntang/work/github/matlab_tools/');
global pirtModelPar;
global ComproModelPar;
global mDroopModelPar;
global VISModelPar;
global sDEBModelPar;
global mDEBModelPar;
setPars();
y01=sPirtModel(pirtModelPar);dydt1=PirtModel([y01,0,0,0,0],pirtModelPar.T0,pirtModelPar);
y02=sComproModel(ComproModelPar);dydt2=ComproModel([y02,0,0,0,0],ComproModelPar.T0,ComproModelPar);
y03=smDroopModel(mDroopModelPar);dydt3=mDroopModel([y03,0,0,0,0],mDroopModelPar.T0,mDroopModelPar);
y04=sVISModel(VISModelPar);dydt4=VISModel([y04,0,0,0,0],VISModelPar.T0,VISModelPar);
y05=ssDEBModel(sDEBModelPar);dydt5=sDEBModel([y05,0,0,0,0],sDEBModelPar.T0,sDEBModelPar);
y06=smDEBModel(mDEBModelPar);dydt6=mDEBModel([y06,0,0,0,0],mDEBModelPar.T0,mDEBModelPar);
y07=smDEBModel(mDEBModelPar);dydt7=mBDEBModel([y06,0,0,0,0],mDEBModelPar.T0,mDEBModelPar);

nyr=50;
if isfile('dnpp.mat')
    load('dnpp.mat');
else
    dnpp=randn(nyr,1).*50;
end
m0=(1:12)-6.5;
w0=exp(-m0.^2./4);
wnpp0=w0./sum(w0);
wnpp=wnpp0;
ns1=12*nyr;
ns=365*nyr;
tempC=[3.89,0.94,0.53,0.47,1.68,3.21,3.17,2.33,2.03,2.42,3.07,1.81,0.98,...
    1.11,1.01,0.88,0.92,1.35,0.53,0.25,0.20,0.27,0.79,0.32,0.10,0.13,0.07,...
    0.02,-0.05,-0.10,-0.12,-0.14,-0.16,-0.19,-0.21,-0.18,-0.16,-0.15,-0.15,...
    -0.16,-0.18,-0.19,-0.19,-0.19,-0.20,-0.21,-0.23,-0.24,-0.24,-0.24,-0.25,...
    -0.29,-0.33,-0.32,-0.31,-0.28,-0.27,-0.27,-0.30,-0.31,-0.29,-0.28,-0.27,...
    -0.27,-0.28,-0.27,-0.24,0.80,3.50,1.53,0.62,1.46,4.15,4.71,3.78,3.58,4.01,...
    4.32,5.51,6.36,7.17,6.15,3.57,2.24,2.14,3.02,5.00,5.43,5.70,6.01,5.81,6.97,...
    7.13,7.00,8.27,9.87,11.26,11.79,12.21,11.99,11.86,11.19,11.55,12.73,12.40,...
    10.35,9.08,10.72,14.73,16.47,16.64,15.96,15.14,17.93,21.66,25.04,27.33,27.88,...
    27.64,25.73,24.64,19.61,15.48,14.27,16.25,17.38,20.61,23.09,25.15,26.40,26.10,...
    23.60,26.99,30.53,31.93,32.05,30.73,29.16,26.52,22.40,18.06,20.18,19.41,17.82,...
    19.95,23.77,26.18,27.49,26.40,19.42,16.19,20.05,23.44,21.27,17.91,16.79,18.46,...
    23.66,26.81,29.26,28.46,32.38,32.14,29.61,23.12,23.90,27.61,27.27,29.56,20.56,...
    19.58,20.57,23.61,25.63,28.26,29.34,26.21,27.00,27.63,27.97,28.46,25.13,24.27,...
    25.43,25.00,26.49,27.63,28.70,27.63,26.98,25.79,23.70,23.71,24.00,24.38,23.36,...
    25.22,27.55,26.44,26.16,26.31,27.85,28.92,27.93,26.97,24.54,23.60,23.51,...
    25.26,26.14,28.14,29.01,29.21,28.90,28.52,28.32,29.15,29.29,28.39,27.51,...
    26.67,23.65,23.08,23.39,23.46,22.22,19.84,19.41,19.31,21.01,20.87,21.92,...
    24.31,25.78,25.06,22.45,21.34,20.93,21.42,22.30,24.18,22.12,19.83,20.53,22.33,...
    23.54,23.66,23.52,23.81,21.37,18.34,16.84,16.73,18.86,20.22,20.19,18.26,15.79,...
    15.30,16.18,15.66,15.65,16.76,16.17,16.89,15.59,12.20,11.37,12.71,14.94,16.29,...
    15.82,15.72,17.11,18.28,17.66,13.74,11.17,9.64,12.30,15.05,15.99,14.63,12.06,...
    11.39,11.37,10.63,9.24,7.28,8.76,10.86,9.77,10.52,11.84,11.77,11.72,10.66,7.94,...
    6.22,4.89,9.96,10.73,11.17,13.02,13.73,11.76,12.17,12.07,12.85,14.51,15.26,12.83,...
    10.48,11.35,11.24,12.11,13.55,14.48,14.51,14.45,14.03,13.34,10.40,8.90,9.75,...
    10.43,10.08,8.95,7.01,7.70,3.84,1.36,0.66,0.42,1.00,3.60,3.95,5.71,9.40,6.01,4.07,...
    3.42,3.84,4.02,5.06,4.48,2.57,2.58,5.21,5.25,3.17,2.77,2.01,2.34,2.71,2.40,...
    0.33,0.12,0.02,-0.03,-0.03,-0.14,-0.45,-0.53,-0.57];
temps=repmat(tempC,[1,nyr])+273.15;

tspan=[0,nyr];
par=pirtModelPar;par.wnpp=wnpp;par.temps=temps;par.dnpp=dnpp;

[t1,y1]=euler_driver([y01,0,0,0,0],tspan,ns,@PirtModel,par);
figure;
for jj=1:3
    subplot(4,1,jj);
    plot(t1',y1(:,jj));title(par.poolnames{jj});
end
subplot(4,1,4);
plot(diff(y1(:,par.vid.hup))./y1(2:end,par.vid.Cb),1-diff(y1(:,par.vid.CO2))./diff(y1(:,par.vid.hup)));
title('Pirt model CUE');

par=ComproModelPar;par.wnpp=wnpp;par.temps=temps;par.dnpp=dnpp;
[t2,y2]=euler_driver([y02,0,0,0,0],tspan,ns,@ComproModel,par);
figure;
for jj=1:3
    subplot(4,1,jj);
    plot(t2',y2(:,jj));title(par.poolnames{jj});
end

subplot(4,1,4);
plot(diff(y2(:,par.vid.hup))./y2(2:end,par.vid.Cb),1-diff(y2(:,par.vid.CO2))./diff(y2(:,par.vid.hup)));
title('Compromise model CUE');

par=mDroopModelPar;par.wnpp=wnpp;par.temps=temps;par.dnpp=dnpp;
[t3,y3]=euler_driver([y03,0,0,0,0],tspan,ns,@mDroopModel,par);
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

par=VISModelPar;par.wnpp=wnpp;par.temps=temps;par.dnpp=dnpp;
[t4,y4]=euler_driver([y04,0,0,0,0],tspan,ns,@VISModel,par);
figure;
for jj=1:4
    subplot(5,1,jj);
    plot(t4',y4(:,jj));title(par.poolnames{jj});
end
subplot(5,1,5);
plot(diff(y4(:,par.vid.hup))./y4(2:end,par.vid.BV),1-diff(y4(:,par.vid.CO2))./diff(y4(:,par.vid.hup)));
title('VIS model CUE');

par=sDEBModelPar;par.wnpp=wnpp;par.temps=temps;par.dnpp=dnpp;

[t5,y5]=euler_driver([y05,0,0,0,0],tspan,ns,@sDEBModel,par);
figure;
for jj=1:4
    subplot(5,1,jj);
    plot(t5',y5(:,jj));title(par.poolnames{jj});
end
subplot(5,1,5);
plot(diff(y5(:,par.vid.hup))./y5(2:end,par.vid.BV),1-diff(y5(:,par.vid.CO2))./diff(y5(:,par.vid.hup)));
title('sDEB model CUE');

par=mDEBModelPar;par.wnpp=wnpp;par.temps=temps;par.dnpp=dnpp;
[t6,y6]=euler_driver([y06,0,0,0,0],tspan,ns,@mDEBModel,par);
figure;
for jj=1:4
    subplot(5,1,jj);
    plot(t6',y6(:,jj));title(par.poolnames{jj});
end
subplot(5,1,5);
plot(diff(y6(:,par.vid.hup))./y6(2:end,par.vid.BV),1-diff(y6(:,par.vid.CO2))./diff(y6(:,par.vid.hup)));
title('mDEB model CUE');

par=mDEBModelPar;par.wnpp=wnpp;par.temps=temps;par.dnpp=dnpp;
[t7,y7]=euler_driver([y07,0,0,0,0],tspan,ns,@mBDEBModel,par);

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
legend('Pirt Model','Compromise Model','mDroop Model','VIS Model','sDEB Model','mDEB model','Orientation','Horizontal');


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

put_tag(fig,ax(1),[0.03,0.9],'(a)',18);
put_tag(fig,ax(2),[0.03,0.9],'(b)',18);
put_tag(fig,ax(3),[0.03,0.9],'(c)',18);
put_tag(fig,ax(4),[0.03,0.9],'(d)',18);

%%
fig=figure;
ax=multipanel(fig,3,1,[.1,.08],[0.8,0.25],[0.05,0.075],'portrait');
set_curAX(fig,ax(1));
id0=365*10;
par=pirtModelPar;
hdl(1)=plot(diff(y1(id0:end,par.vid.mu))./(t1(2)-t1(1)),1-diff(y1(id0:end,par.vid.CO2))./diff(y1(id0:end,par.vid.hup)),'-','LineWidth',0.5);
hold on;
hdl(2)=plot(diff(y2(id0:end,par.vid.mu))./(t2(2)-t2(1)),1-diff(y2(id0:end,par.vid.CO2))./diff(y2(id0:end,par.vid.hup)),'-','LineWidth',0.5);
ylabel('Total biomass CUE');
xlabel('Specific growth rate (yr^-^1)');
legend('Pirt Model','Compromise Model','location','southeast');
%ylim([0.48,0.52]);
xlim([-0.3,3]);

par=mDroopModelPar;
set_curAX(fig,ax(2));
hdl(1)=plot(diff(y3(id0:end,par.vid.mu))./(t3(2)-t3(1)),1-diff(y3(id0:end,par.vid.CO2))./diff(y3(id0:end,par.vid.hup)),'LineWidth',0.5);
ylabel('Total biomass CUE');
xlabel('Specific growth rate (yr^-^1)');
legend('mDroop Model','location','southeast');
xlim([-0.3,3]);
par=mDEBModelPar;
set_curAX(fig,ax(3));

hdl(1)=plot(diff(y4(id0:end,par.vid.mu))./(t4(2)-t4(1)),1-diff(y4(id0:end,par.vid.CO2))./diff(y4(id0:end,par.vid.hup)),'LineWidth',0.5);
hold on;
hdl(2)=plot(diff(y5(id0:end,par.vid.mu))./(t5(2)-t5(1)),1-diff(y5(id0:end,par.vid.CO2))./diff(y5(id0:end,par.vid.hup)),'LineWidth',0.5);
hdl(3)=plot(diff(y6(id0:end,par.vid.mu))./(t6(2)-t6(1)),1-diff(y6(id0:end,par.vid.CO2))./diff(y6(id0:end,par.vid.hup)),'LineWidth',0.5);
xlim([-0.3,3.0]);ylim([0.25,0.5]);
ylabel('Total biomass CUE');
xlabel('Specific growth rate (yr^-^1)');
legend('VIS Model','sDEB Model','mDEB Model','location','southeast');

%set(ax(3),'Ylim',[0.42,0.45]);
set(ax,'FontSize',18);

%set(ax(2:3),'Xlim',[2.6,3.2]);
put_tag(fig,ax(1),[0.025,0.9],'(a)',18);
put_tag(fig,ax(2),[0.025,0.9],'(b)',18);
put_tag(fig,ax(3),[0.025,0.9],'(c)',18);
%%
fig=figure;
ax=multipanel(fig,3,1,[.1,.08],[0.8,0.25],[0.05,0.075],'portrait');
set_curAX(fig,ax(1));
temps=temps-273.15;
par=pirtModelPar;
hdl(1)=plot(temps(id0:end),1-diff(y1(id0:end,par.vid.CO2))./diff(y1(id0:end,par.vid.hup)),'-','LineWidth',0.5);
hold on;
hdl(2)=plot(temps(id0:end),1-diff(y2(id0:end,par.vid.CO2))./diff(y2(id0:end,par.vid.hup)),'-.','LineWidth',0.5);
ylabel('Total biomass CUE');
xlabel('Temperature (^oC)');
legend('Pirt Model','Compromise Model','location','northeast');
%ylim([0.48,0.52]);
%xlim([2.4,3.0]);

par=mDroopModelPar;
set_curAX(fig,ax(2));
hdl(1)=plot(temps(id0:end),1-diff(y3(id0:end,par.vid.CO2))./diff(y3(id0:end,par.vid.hup)),'LineWidth',0.5);ylim([-0.8,1]);
ylabel('Total biomass CUE');
xlabel('Temperature (^oC)');
legend('mDroop Model','location','northeast');
%set(ax(2),'Ylim',[0.41,0.45]);

par=mDEBModelPar;
set_curAX(fig,ax(3));

hdl(1)=plot(temps(id0:end),1-diff(y4(id0:end,par.vid.CO2))./diff(y4(id0:end,par.vid.hup)),'LineWidth',0.5);
hold on;
hdl(2)=plot(temps(id0:end),1-diff(y5(id0:end,par.vid.CO2))./diff(y5(id0:end,par.vid.hup)),'LineWidth',0.5);
hdl(3)=plot(temps(id0:end),1-diff(y6(id0:end,par.vid.CO2))./diff(y6(id0:end,par.vid.hup)),'LineWidth',0.5);
ylabel('Total biomass CUE');
xlabel('Temperature (^oC)');
legend('VIS Model','sDEB Model','mDEB Model','location','northeast');
ylim([0.25,0.5]);
%set(ax([1,3]),'Ylim',[0.,0.5]);
set(ax,'FontSize',18);
%set(ax(2:3),'Xlim',[2.6,3.2]);
%set(ax,'Ylim',[-0.3,0.91]);
put_tag(fig,ax(1),[0.025,0.9],'(a)',18);
put_tag(fig,ax(2),[0.025,0.9],'(b)',18);
put_tag(fig,ax(3),[0.025,0.9],'(c)',18);

fig=figure;
ax=multipanel(fig,2,1,[.1,.08],[0.8,0.41],[0.05,0.075],'portrait');
set_curAX(fig,ax(1));

bar(wnpp0);
xlabel('Month');
ylabel('Fraction of NPP allocated');
set(ax(1),'FontSize',18);

put_tag(fig,ax(1),[0.025,0.9],'(a)',18);

set_curAX(fig,ax(2));
plot(tempC,'LineWidth',2);
xlabel('Ordinal day');
ylabel('Temperature (^oC)');
set(ax(2),'FontSize',18);
put_tag(fig,ax(2),[0.025,0.9],'(b)',18);


fig=figure;
ax=multipanel(fig,3,1,[.1,.07],[0.8,0.271],[0.05,0.05],'portrait');
set_curAX(fig,ax(1));

plot(t6,y6(:,1),'LineWidth',2);
hold on;
plot(t7,y7(:,1),'LineWidth',2);
legend('mDEB: C uptake scaled by structural biomass','mDEB: C uptake scaled by total biomass');

ylabel('Fast pool C (gC m^-^2)');

set_curAX(fig,ax(2));
plot(t6,y6(:,2),'LineWidth',2);
hold on;
plot(t6,y7(:,2),'LineWidth',2);
ylabel('Slow pool C (gC m^-^2)');

set_curAX(fig,ax(3));

plot(t4,y6(:,3)+y6(:,4),'LineWidth',2);hold on;
plot(t4,y7(:,3)+y7(:,4),'LineWidth',2);
ylabel('Total microbial biomass (gC m^-^2)');
xlabel('Year','FontSize',18);
set(ax,'FontSize',18);
put_tag(fig,ax(1),[0.025,0.9],'(a)',18);
put_tag(fig,ax(2),[0.025,0.9],'(b)',18);
put_tag(fig,ax(3),[0.025,0.9],'(c)',18);

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
    lyr=fix(t(n+1)-dt)+1;         %current year   
    doy=mod(t(n+1)*365,365);
    if(doy<1.e-6)
        doy=365;
    else
        doy=fix(doy+0.2);
    end
    mon=doy2mon(doy);             %current month
%    tdaz(doy)=tdaz(doy)+1;
    ws=par1.wnpp(mon)*365/getmondaz(mon);%.*(1+par1.scal(ll));
    par1.Fnpp=(par.Fnpp+par1.dnpp(lyr))*ws;
    dydt2=model(y1,par.temps(doy),par1);
    y2=y1+dydt2.*dt;
%    tc=tc+par1.Fnpp*dt;
%    tc1=tc1+ws;
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


