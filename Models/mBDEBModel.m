function dydt=mBDEBModel(y,TempK,par)
%
%mDEB model compute uptake based on total biomass
%
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
gamma=gamma*BV./(par.alpha_B0+BV);

denorm=1+Cl/Kl+Cs/Ks;
hl=(BV+Bc)*Vl*Cl/Kl/denorm;
hs=(BV+Bc)*Vs*Cs/Ks/denorm;
Fnpp2Cl=(1-par.a)*par.Fnpp;
h=hl+hs;
mortC=gamma*Bc;
mortV=gamma*BV;
mort=mortC+mortV;
vC=ve*Bc;

mu=par.YV*vC/BV-mV; %specific growth rate
dydt(vid.Cl)=Fnpp2Cl-hl;
dydt(vid.Cs)=par.Fnpp-Fnpp2Cl-hs+mort;
dydt(vid.Bc)=par.Yb*h-vC-mortC;
dydt(vid.BV)=mu*BV-mortV;
dydt(vid.CO2)=(1-par.Yb)*h*BV+(1-par.YV)*vC+mV*BV;
dydt(vid.hup)=h*BV;
dydt(vid.cue)=(par.YV*vC-mV*BV)/(h*BV);
dydt(vid.mu)=mu;
end
