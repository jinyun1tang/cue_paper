function scal=fT_EnzActs(T,par)
%temperature scalar for active fraction of total enzyme
%Author: Jinyun Tang
Rgas=8.3145; %J/mol/K
dCp=-46.0+30.*(1-1.54.*par.n^(-0.268))*par.NCH;
dG=par.n*(par.Hstar-18.1.*T+dCp.*((T-373.6)-T.*log(T./385.2)));
scal=1./(1+exp(-dG./(Rgas.*T)));
end