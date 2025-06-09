function dydt=sDEBModel(y,TempK,par)
%
%sDEB model
%
%apply temperature scaling of the parameters
fT_Vl=fT_Eyring(TempK,par.H_Vl,par);
fT_Vs=fT_Eyring(TempK,par.H_Vs,par);
fT_Kl=fT_Arrhenius(TempK,par.H_Kl,par);
fT_Ks=fT_Arrhenius(TempK,par.H_Ks,par);
fT_mV=fT_Arrhenius(TempK,par.H_m,par);
fT_ve=fT_Eyring(TempK,par.H_ve,par);

fact0=fT_EnzActs(par.T0,par);
factT=fT_EnzActs(TempK,par)./fact0;
Vl=par.Vl*factT*fT_Vl;
Vs=par.Vs*factT*fT_Vs;
Kl=par.Kl*fT_Kl;
Ks=par.Ks*fT_Ks;
mV=par.mV*fT_mV;
ve=par.ve*fT_ve*factT;
gamma=par.gamma*fT_mV;

vid=par.vid;
dydt=zeros(size(y));
Cl=y(vid.Cl);
Cs=y(vid.Cs);
Bc=y(vid.Bc);
BV=y(vid.BV);
denorm=1+Cl/Kl+Cs/Ks;
hl=Vl*Cl/Kl/denorm;
hs=Vs*Cs/Ks/denorm;
Fnpp2Cl=(1-par.a)*par.Fnpp;
h=hl+hs;
gamma=gamma*BV./(par.alpha_B0+BV);
mortC=gamma*Bc;
mortV=gamma*BV;
mort=mortC+mortV;
x=Bc/BV;
vC=ve*x;
mu=(par.YV*vC-mV)/(1.+par.YV*x);
dydt(vid.Cl)=Fnpp2Cl-BV*hl;
dydt(vid.Cs)=par.Fnpp-Fnpp2Cl-BV*hs+mort;
dydt(vid.Bc)=par.Yb*h*BV-(ve-mu)*Bc-mortC;
dydt(vid.BV)=mu*BV-mortV;
dydt(vid.CO2)=((ve-mu)*x-mu+(1-par.Yb)*h)*BV;
dydt(vid.hup)=h*BV;
dydt(vid.cue)=mu/h;
end