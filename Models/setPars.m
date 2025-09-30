function setPars()
%
%Author: Jinyun Tang (jinyuntang@lbl.gov)
%History: Created in May, 2025.
%
%Set model parameters
%
global pirtModelPar;
global ComproModelPar;
global mDroopModelPar;
global VISModelPar;
global sDEBModelPar;
global mDEBModelPar;

Vl  =170.*1.;       %maximum specific uptake rate of fast pool, [1/yr]
Vs  =35.*1.;        %maximum specific uptake rate of slow pool, [1/yr]
Kl  =67275*0.75;    %half saturation parameter of fast pool, [gC m^-2], multiply 0.1 will show more bloated CUE dynamics for VIS model, sDEB model and mDEB model 
Ks  =363870*0.75;   %half saturation parameter of slow pool, [gC m^-2], multiply 0.1 will show more bloated CUE dynamics for VIS model, sDEB model and mDEB model 
Fnpp=350;           %input soil C flux, [gC/m2/yr]
alpha_B0=10.;       %density dependence parameter of mortality, [gC m^-2]
a=0.01;             %Fraction of NPP allocation to slow pool, [gC/gC]
H_Vl =47.d3;        %activation energy/enthalpy for Vl, [J/mol/K]
H_Kl =30.d3;        %activation energy/enthalpy for Kl, [J/mol/K]
H_Vs =47.d3;        %activation energy/enthalpy for Vs, [J/mol/K], for simplicity, it is set to H_Vl
H_Ks =30.d3;        %activation energy/enthalpy for Ks, [J/mol/K], for simplicity, it is set to H_Kl
H_m  =47.d3;        %activation energy/enthalpy for maintenance respiration, Ks, [J/mol/K]
NCH  =5.617;        %Average number of non-polar hydrogen atoms per amino acid residue
n    =260;          %Number of amino acid residues for the control enzyme
Hstar=5340.;        %Enthalpy change at TH* [J/mol]
T0   =15+273.15;    %reference temperature [K]
gamma=1.;           %specific mortality, [1/yr]
pirtModelPar.NCH=NCH;
pirtModelPar.n=n;
pirtModelPar.Hstar=Hstar;
pirtModelPar.T0=T0;
pirtModelPar.vid.Cl=1;      %id of fast pool C
pirtModelPar.vid.Cs=2;      %id of slow pool C
pirtModelPar.vid.Cb=3;      %id of total biomass C
pirtModelPar.vid.CO2=4;     %id of respired CO2
pirtModelPar.vid.hup=5;     %id of C uptake flux
pirtModelPar.vid.cue=6;     %id of instantaneous structural biomass cue
pirtModelPar.vid.mu=7;      %id of growth rate, excluding mortality
pirtModelPar.H_Vl=H_Vl;     %activation energy/enthalpy for Vl, [J/mol/K]
pirtModelPar.H_Kl=H_Kl;     %activation energy/enthalpy for Kl, [J/mol/K]
pirtModelPar.H_Vs=H_Vs;     %activation energy/enthalpy for Vs, [J/mol/K]
pirtModelPar.H_Ks=H_Ks;     %activation energy/enthalpy for Ks, [J/mol/K]
pirtModelPar.H_m=H_m;       %activation energy/enthalpy for maintenance respiration, Ks, [J/mol/K]
pirtModelPar.Vl=Vl;         %maximum specific uptake rate of fast pool, 1/yr
pirtModelPar.Vs=Vs;         %maximum specific uptake rate of slow pool, 1/yr
pirtModelPar.Kl=Kl;         %half saturation parameter of fast pool, gC m^-2
pirtModelPar.Ks=Ks;         %half saturation parameter of slow pool, gC m^-2
pirtModelPar.Fnpp=Fnpp;     %input soil C flux, [gC/m2/yr]
pirtModelPar.a=a;           %fraction of input soil C flux allocated to Cs
pirtModelPar.Yb=0.52;       %biomass yield, gC/gC
pirtModelPar.gamma=gamma;   %specific mortalty, 1/yr
pirtModelPar.mV=.1*2;       %specific maintenance, 1/yr;
pirtModelPar.alpha_B0=alpha_B0;
pirtModelPar.poolnames={'Fast pool C','Slow pool C','Microbial C'};


ComproModelPar.NCH=NCH;
ComproModelPar.n=n;
ComproModelPar.Hstar=Hstar;
ComproModelPar.T0=T0;
ComproModelPar.vid.Cl=1;    %id of fast pool C
ComproModelPar.vid.Cs=2;    %id of slow pool C
ComproModelPar.vid.Cb=3;    %id of total biomass C
ComproModelPar.vid.CO2=4;   %id of respired CO2
ComproModelPar.vid.hup=5;   %id of C uptake flux
ComproModelPar.vid.cue=6;   %id of instantaneous structural biomass cue
ComproModelPar.vid.mu=7;    %id of growth rate, excluding mortality
ComproModelPar.Vl=Vl-0.1;   %maximum specific uptake rate of fast pool, 1/yr
ComproModelPar.Vs=Vs-0.1;   %maximum specific uptake rate of slow pool, 1/yr
ComproModelPar.Kl=Kl;       %half saturation parameter of fast pool, gC m^-2
ComproModelPar.Ks=Ks;       %half saturation parameter of slow pool, gC m^-2
ComproModelPar.Fnpp=Fnpp;   %input soil C flux, [gC/m2/yr]
ComproModelPar.a=a;         %fraction of input soil C flux allocated to Cs
ComproModelPar.Yb=0.52;     %biomass yield, gC/gC
ComproModelPar.gamma=gamma; %specific mortalty, 1/yr
ComproModelPar.mV=.1*2;     %specific maintenance, 1/yr;
ComproModelPar.H_Vl=H_Vl;   %activation energy/enthalpy for Vl, [J/mol/K]
ComproModelPar.H_Kl=H_Kl;   %activation energy/enthalpy for Kl, [J/mol/K]
ComproModelPar.H_Vs=H_Vs;   %activation energy/enthalpy for Vs, [J/mol/K]
ComproModelPar.H_Ks=H_Ks;   %activation energy/enthalpy for Ks, [J/mol/K]
ComproModelPar.H_m=H_m;     %activation energy/enthalpy for maintenance respiration, Ks, [J/mol/K]
ComproModelPar.alpha_B0=alpha_B0;
ComproModelPar.poolnames={'Fast pool C','Slow pool C','Microbial C'};


mDroopModelPar.NCH=NCH;
mDroopModelPar.n=n;
mDroopModelPar.Hstar=Hstar;
mDroopModelPar.T0=T0;
mDroopModelPar.vid.Cl=1;    %id of fast pool C, [gC m^-2]
mDroopModelPar.vid.Cs=2;    %id of slow pool C, [gC m^-2]
mDroopModelPar.vid.Bc=3;    %id of total biomass C, [gC m^-2]
mDroopModelPar.vid.BV=4;    %id of strutural biomass C, [gC m^-2]
mDroopModelPar.vid.CO2=5;   %id of CO2, [gC m^-2]
mDroopModelPar.vid.hup=6;   %id of total C uptake, [gC m^-2/yr]
mDroopModelPar.vid.cue=7;   %id of instantaneous structural biomass cue
mDroopModelPar.vid.mu=8;      %id of growth rate, excluding mortality
mDroopModelPar.Vl=Vl;       %maximum specific uptake rate of fast pool, [1/yr]
mDroopModelPar.Vs=Vs;       %maximum specific uptake rate of slow pool, [1/yr]
mDroopModelPar.Kl=Kl;       %half saturation parameter of fast pool, [gC m^-2]
mDroopModelPar.Ks=Ks;       %half saturation parameter of slow pool, [gC m^-2]
mDroopModelPar.H_Vl=H_Vl;   %activation energy/enthalpy for Vl, [J/mol/K]
mDroopModelPar.H_Kl=H_Kl;   %activation energy/enthalpy for Kl, [J/mol/K]
mDroopModelPar.H_Vs=H_Vs;   %activation energy/enthalpy for Vs, [J/mol/K]
mDroopModelPar.H_Ks=H_Ks;   %activation energy/enthalpy for Ks, [J/mol/K]
mDroopModelPar.Fnpp=Fnpp;   %input soil C flux, [gC/m2/yr]
mDroopModelPar.a=a;         %fraction of input soil C flux allocated to Cs
mDroopModelPar.gamma=gamma; %mortality rate, 1/yr
mDroopModelPar.c1=1;        %scalar of growth respiration, equivalent to (1-cue)/cue
mDroopModelPar.c2=.1*2;     %scalar for maintenance respiration, [1/yr];
mDroopModelPar.Qmin=1.06;   %minimum reserve quota, [gC/gC]
mDroopModelPar.Qmax=10.;    %maximum reserve quota, [gC/gC]
mDroopModelPar.umax=11.0;   %maximum specific growth rate, [1/yr]
mDroopModelPar.Yb=0.9;      %biomass yield, gC/gC
mDroopModelPar.alpha_B0=alpha_B0;
mDroopModelPar.poolnames={'Fast pool C','Slow pool C','Microbial storage C','Microbial structural C'};


VISModelPar.NCH=NCH;
VISModelPar.n=n;
VISModelPar.Hstar=Hstar;
VISModelPar.T0=T0;
VISModelPar.vid.Cl=1;     %id of fast pool C, [gC m^-2]
VISModelPar.vid.Cs=2;     %id of slow pool C, [gC m^-2]
VISModelPar.vid.Bc=3;     %id of total biomass C, [gC m^-2]
VISModelPar.vid.BV=4;     %id of strutural biomass C, [gC m^-2]
VISModelPar.vid.CO2=5;    %id of CO2, [gC m^-2]
VISModelPar.vid.hup=6;    %id of total C uptake, [gC m^-2/yr]
VISModelPar.vid.cue=7;    %id of instantaneous structural biomass cue
VISModelPar.vid.mu=8;      %id of growth rate, excluding mortality
VISModelPar.Vl=Vl;        %maximum specific uptake rate of fast pool, [1/yr]
VISModelPar.Vs=Vs;        %maximum specific uptake rate of slow pool, [1/yr]
VISModelPar.Kl=Kl;        %half saturation parameter of fast pool, [gC m^-2]
VISModelPar.Ks=Ks;        %half saturation parameter of slow pool, [gC m^-2]
VISModelPar.H_Vl=H_Vl;    %activation energy/enthalpy for Vl, [J/mol/K]
VISModelPar.H_Kl=H_Kl;    %activation energy/enthalpy for Kl, [J/mol/K]
VISModelPar.H_Vs=H_Vs;    %activation energy/enthalpy for Vs, [J/mol/K]
VISModelPar.H_Ks=H_Ks;    %activation energy/enthalpy for Ks, [J/mol/K]
VISModelPar.H_m=H_m;      %activation energy/enthalpy for maintenance respiration, Ks, [J/mol/K]
VISModelPar.H_ve=H_Vl;    %activation energy/enthalpy for ve, Vl, [J/mol/K]
VISModelPar.Fnpp=Fnpp;    %input soil C flux, [gC/m2/yr]
VISModelPar.a=a;          %fraction of input soil C flux allocated to Cs
VISModelPar.gamma=gamma;  %specific mortality [1/yr]
VISModelPar.mV=0.02*2;    %specific maintenance rate, [gC/m2/yr]
VISModelPar.Yb=0.5;       %reserve biomass yield from substrate, [gC/gC]
VISModelPar.ve=10.;       %specific reserve turnover rate, [1/yr]
VISModelPar.YV=0.9;       %structural biomass yield from reserve, [gC/gC]
VISModelPar.alpha_B0=alpha_B0;
VISModelPar.poolnames={'Fast pool C','Slow pool C','Microbial storage C','Microbial structural C'};


sDEBModelPar.NCH=NCH;
sDEBModelPar.n=n;
sDEBModelPar.Hstar=Hstar;
sDEBModelPar.T0=T0;    
sDEBModelPar.vid.Cl=1;     %id of fast pool C, [gC m^-2]
sDEBModelPar.vid.Cs=2;     %id of slow pool C, [gC m^-2]
sDEBModelPar.vid.Bc=3;     %id of reserve biomass C, [gC m^-2]
sDEBModelPar.vid.BV=4;     %id of structural biomass C, [gC m^-2]
sDEBModelPar.vid.CO2=5;    %id of CO2, [gC m^-2]
sDEBModelPar.vid.hup=6;    %id of total C uptake, [gC m^-2/yr]
sDEBModelPar.vid.cue=7;    %id of instantaneous structural biomass cue
sDEBModelPar.vid.mu=8;      %id of growth rate, excluding mortality
sDEBModelPar.Vl=Vl;        %maximum specific uptake rate of fast pool, [1/yr]
sDEBModelPar.Vs=Vs;        %maximum specific uptake rate of slow pool, [1/yr]
sDEBModelPar.Kl=Kl;        %half saturation parameter of fast pool, [gC m^-2]
sDEBModelPar.Ks=Ks;        %half saturation parameter of slow pool, [gC m^-2]
sDEBModelPar.H_Vl=H_Vl;    %activation energy/enthalpy for Vl, [J/mol/K]
sDEBModelPar.H_Kl=H_Kl;    %activation energy/enthalpy for Kl, [J/mol/K]
sDEBModelPar.H_Vs=H_Vs;    %activation energy/enthalpy for Vs, [J/mol/K]
sDEBModelPar.H_Ks=H_Ks;    %activation energy/enthalpy for Ks, [J/mol/K]
sDEBModelPar.H_m=H_m;      %activation energy/enthalpy for maintenance respiration, Ks, [J/mol/K]
sDEBModelPar.H_ve=H_Vl;    %activation energy/enthalpy for ve, Vl, [J/mol/K]
sDEBModelPar.Fnpp=Fnpp;    %input soil C flux, [gC/m2/yr]
sDEBModelPar.a=a;          %fraction of input soil C flux allocated to Cs
sDEBModelPar.gamma=gamma;  %specific mortality, [1/yr]
sDEBModelPar.mV=0.02*2;    %specific maintenance rate, [gC/m2/yr]
sDEBModelPar.Yb=0.5;       %reserve biomass yield from substrate, [gC/gC]
sDEBModelPar.ve=12.;       %specific reserve turnover rate, [1/yr]
sDEBModelPar.YV=0.9;       %structural biomass yield from reserve, [gC/gC]
sDEBModelPar.alpha_B0=alpha_B0;
sDEBModelPar.poolnames={'Fast pool C','Slow pool C','Microbial storage C','Microbial structural C'};

mDEBModelPar.NCH=NCH;
mDEBModelPar.n=n;
mDEBModelPar.Hstar=Hstar;
mDEBModelPar.T0=T0;   
mDEBModelPar.vid.Cl=1;     %id of fast pool C, [gC m^-2]
mDEBModelPar.vid.Cs=2;     %id of slow pool C, [gC m^-2]
mDEBModelPar.vid.Bc=3;     %id of reserve biomass C, [gC m^-2]
mDEBModelPar.vid.BV=4;     %id of structural biomass C, [gC m^-2]
mDEBModelPar.vid.CO2=5;    %id of CO2, [gC m^-2]
mDEBModelPar.vid.hup=6;    %id of total C uptake, [gC m^-2/yr]
mDEBModelPar.vid.cue=7;    %id of instantaneous structural biomass cue
mDEBModelPar.vid.mu=8;      %id of growth rate, excluding mortality
mDEBModelPar.Vl=Vl;        %maximum specific uptake rate of fast pool, [1/yr]
mDEBModelPar.Vs=Vs;        %maximum specific uptake rate of slow pool, [1/yr]
mDEBModelPar.Kl=Kl;        %half saturation parameter of fast pool, [gC m^-2]
mDEBModelPar.Ks=Ks;        %half saturation parameter of slow pool, [gC m^-2]
mDEBModelPar.H_Vl=H_Vl;    %activation energy/enthalpy for Vl, [J/mol/K]
mDEBModelPar.H_Kl=H_Kl;    %activation energy/enthalpy for Kl, [J/mol/K]
mDEBModelPar.H_Vs=H_Vs;    %activation energy/enthalpy for Vs,[J/mol/K]
mDEBModelPar.H_Ks=H_Ks;    %activation energy/enthalpy for Ks, [J/mol/K]
mDEBModelPar.H_m=H_m;      %activation energy/enthalpy for maintenance respiration, Ks, [J/mol/K]
mDEBModelPar.H_ve=H_Vl;    %activation energy/enthalpy for ve, Vl, [J/mol/K]
mDEBModelPar.a=a;          %fraction of input soil C flux allocated to Cs
mDEBModelPar.Fnpp=Fnpp;    %input soil C flux, [gC/m2/yr]
mDEBModelPar.gamma=gamma;  %specific mortality, [1/yr]
mDEBModelPar.Yb=0.5;       %reserve biomass yield from substrate, [gC/gC]
mDEBModelPar.ve=10.5;      %specific reserve turnover rate, [1/yr]
mDEBModelPar.YV=0.9;       %structural biomass yield from reserve, [gC/gC]
mDEBModelPar.mV=0.02*2;    %specific maintenance rate, [gC/m2/yr]
mDEBModelPar.alpha_B0=alpha_B0;
mDEBModelPar.poolnames={'Fast pool C','Slow pool C','Microbial storage C','Microbial structural C'};

end
