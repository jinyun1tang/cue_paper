function scal=fT_Eyring(T,Hv,par)
%temperature scalar of Eyring-type function
%Author: Jinyun Tang

Rgas=8.3145; %J/mol/K
scal=(T./par.T0).*exp(-Hv/Rgas.*(1./T-1./par.T0));
end