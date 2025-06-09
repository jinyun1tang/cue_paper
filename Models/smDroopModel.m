
function y=smDroopModel(par)
%
%steady-state mDroop model
%
vid=par.vid;
y=zeros(1,4);
Q=par.Qmin/(1-par.gamma/par.umax);
R=par.c1*Q*par.gamma+par.c2*(Q-par.Qmin);
h=(R+par.gamma*Q)/par.Yb;
q=(par.Qmax-Q)/(par.Qmax-par.Qmin);
y(vid.BV)=par.Fnpp/(h-par.gamma*Q);
hl=(1-par.a)*par.Fnpp/y(vid.BV);
hs=h-hl;
alpha=hl/hs;
alphas=alpha*(par.Vs*par.Kl)/(par.Vl*par.Ks);
y(vid.Cl)=hl/(par.Vl*q/par.Kl-hl*(1/par.Kl+1/(alphas*par.Ks)));
y(vid.Cs)=y(vid.Cl)/alphas;
y(vid.Bc)=Q*y(vid.BV);
end
