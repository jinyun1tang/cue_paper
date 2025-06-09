%%
function y=sComproModel(par)
%
%steady-state Compromise model
%
y=zeros(1,3);
vid=par.vid;
h=(par.mV+par.gamma)/par.Yb;
y(vid.Cb)=par.Fnpp/(h-par.gamma);
hl=(1-par.a)*par.Fnpp/y(vid.Cb);
hs=h-hl;
alpha=hl/hs;
alphas=alpha*(par.Vs+par.mV)*par.Kl/((par.Vl+par.mV)*par.Ks);
y(vid.Cl)=hl/((par.Vl+par.mV)/par.Kl-hl*(1./par.Kl+1/(alphas*par.Ks)));
y(vid.Cs)=y(vid.Cl)/alphas;
end