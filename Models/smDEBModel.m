
function y=smDEBModel(par)
%
%steady-state mDEB model
%
vid=par.vid;
y=zeros(1,4);
x=(par.mV+par.gamma)/(par.YV*par.ve);
h=(par.ve+par.gamma)/par.Yb*x;
y(vid.BV)=par.Fnpp/(h-par.gamma*(1+x));
hl=(1-par.a)*par.Fnpp/y(vid.BV);
hs=h-hl;
alpha=hl/hs;
alphas=alpha*(par.Vs*par.Kl)/(par.Vl*par.Ks);
y(vid.Cl)=hl/(par.Vl/par.Kl-hl*(1/par.Kl+1/(alphas*par.Ks)));
y(vid.Cs)=y(vid.Cl)/alphas;
y(vid.Bc)=x*y(vid.BV);

end