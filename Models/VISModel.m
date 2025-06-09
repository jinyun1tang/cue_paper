%%
function dydt=VISModel(y,TempK,par)
%
%Variable-internal-store model
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
hl=Vl*Cl/Kl/denorm;
hs=Vs*Cs/Ks/denorm;
Fnpp2Cs=par.a*par.Fnpp;
h=hl+hs;
mortC=gamma*Bc;
mortV=gamma*BV;
mort=mortC+mortV;
vC=ve*Bc;
dydt(vid.Cl)=par.Fnpp-Fnpp2Cs-BV*hl;
dydt(vid.Cs)=Fnpp2Cs-BV*hs+mort;
dydt(vid.Bc)=(par.Yb*h-mV)*BV-vC-mortC;
dydt(vid.BV)=par.YV*vC-mortV;
dydt(vid.CO2)=((1-par.Yb)*h+mV)*BV+(1-par.YV)*vC;
dydt(vid.hup)=h*BV;
dydt(vid.cue)=par.YV*vC/(h*BV);
end
