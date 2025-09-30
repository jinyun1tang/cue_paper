
function dydt=PirtModel(y,TempK,par)
%
%Pirt model
%
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
hl=Vl*Cl/Kl/denorm;
hs=Vs*Cs/Ks/denorm;
Fnpp2Cl=(1-par.a)*par.Fnpp;
gamma=gamma*Cb./(par.alpha_B0+Cb);
mort=gamma*Cb;
h=hl+hs;
mu=par.Yb*h;
hl1=hl*(1+mV*mu/(mu*mu+eps));
hs1=hs*(1+mV*mu/(mu*mu+eps));
dydt(vid.Cl)=Fnpp2Cl-Cb*hl1;
dydt(vid.Cs)=par.Fnpp-Fnpp2Cl+mort-Cb*hs1;
dydt(vid.Cb)=mu*Cb-mort;
dydt(vid.CO2)=(hl1+hs1-mu)*Cb;
dydt(vid.hup)=(hl1+hs1)*Cb;
dydt(vid.cue)=mu/(hl1+hs1);
dydt(vid.mu) =mu;
end
