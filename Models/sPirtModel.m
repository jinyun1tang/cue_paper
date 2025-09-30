
function y=sPirtModel(par)
%
%steady-state solution of Pirt model
%
y=zeros(1,3);
vid=par.vid;
h=par.gamma/par.Yb;
y(vid.Cb)=par.Yb*par.Fnpp/(par.mV+(1-par.Yb)*par.gamma);
hl=(1-par.a)*par.Fnpp/(y(vid.Cb)*(1+par.mV/par.gamma));
hs=h-hl;
alpha=hl/hs;
alphas=alpha*(par.Vs*par.Kl/(par.Vl*par.Ks));
y(vid.Cl)=hl/(par.Vl/par.Kl-hl*(1./par.Kl+1/(alphas*par.Ks)));
y(vid.Cs)=y(vid.Cl)/alphas;

end