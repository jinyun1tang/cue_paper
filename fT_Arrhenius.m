function scal=fT_Arrhenius(T,Eact,par)
%temperature scalar of Arrhenius-type function
%Author: Jinyun Tang

Rgas=8.3145; %J/mol/K
scal=exp(-Eact/Rgas*(1./T-1./par.T0));
end