function dydt=ComproModel(y,TempK,par)
%
%Compromise model

%apply temperature scaling of the parameters
fT_Vl=fT_Eyring(TempK,par.H_Vl,par);
fT_Vs=fT_Eyring(TempK,par.H_Vs,par);
fT_Kl=fT_Arrhenius(TempK,par.H_Kl,par);
fT_Ks=fT_Arrhenius(TempK,par.H_Ks,par);
fT_mV=fT_Arrhenius(TempK,par.H_m,par);
fact0=fT_EnzActs(par.T0,par);
factT=fT_EnzActs(TempK,par)./fact0;
Vl=par.Vl*factT*fT_Vl;
Vs=par.Vs*factT*fT_Vs;
Kl=par.Kl*fT_Kl;
Ks=par.Ks*fT_Ks;
mV=par.mV*fT_mV;
gamma=par.gamma*fT_mV;

vid=par.vid;
dydt=zeros(size(y));
Cl=y(vid.Cl);
Cs=y(vid.Cs);
Cb=y(vid.Cb);
denorm=1+Cl/Kl+Cs/Ks;
hl=(Vl+mV)*Cl/Kl/denorm;
hs=(Vs+mV)*Cs/Ks/denorm;
Fnpp2Cl=(1-par.a)*par.Fnpp;
gamma=gamma*Cb./(par.alpha_B0+Cb);
mort=gamma*Cb;
h=hl+hs;
mu=par.Yb*h-mV;
dydt(vid.Cl)=Fnpp2Cl-Cb*hl;
dydt(vid.Cs)=par.Fnpp-Fnpp2Cl+mort-Cb*hs;
dydt(vid.Cb)=mu*Cb-mort;
dydt(vid.CO2)=((1-par.Yb)*h+mV)*Cb;
dydt(vid.hup)=h*Cb;
dydt(vid.cue)=mu/h;
dydt(vid.mu)=mu;
end


