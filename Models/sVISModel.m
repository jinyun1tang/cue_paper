
function y=sVISModel(par)
%
%steady-state VISModel
%
vid=par.vid;
y=zeros(1,4);
x=par.gamma/(par.YV*par.ve);
h=(x*(par.ve+par.gamma)+par.mV)/par.Yb;
y(vid.BV)=par.Fnpp/(h-par.gamma*(1+x));
hl=(1-par.a)*par.Fnpp/y(vid.BV);
hs=h-hl;
alpha=hl/hs;
alphas=alpha*(par.Vs*par.Kl)/(par.Vl*par.Ks);
y(vid.Cl)=hl/((par.Vl-hl)/par.Kl-hl/(alphas*par.Ks));
y(vid.Cs)=y(vid.Cl)/alphas;
y(vid.Bc)=x*y(vid.BV);
end