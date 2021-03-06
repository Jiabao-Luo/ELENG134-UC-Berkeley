    %% fundamental parameter
    fund_consts;
    
    IQE =1; % internal quantum efficiency
    %% Circuit parameter for the solar cell, in units of Ohm.m2
    Rs = 0; % series resistance
    Rsh = 1e6; % shunt resistance
    
    
    %% environmental parameters
    Tc =300; % temperature of the cell
    
    %% doping density
   
    ND = 0; % donor doping density 
    NA = 0; % acceptor doping density
    
    %% Cell geometrical parameter
    L = 2.5e-6; % thickness of cell
    
    
    %% material recombination parameters
    Material = 'Ideal'; %either Lossy or Ideal
    if strcmp(Material,'Lossy')
        tau_SRH = 10e-6; % SRH lifetime in units of Seconds
        Cn = 1e-30*1e-12; % Electron Auger recombination coefficient 
        Cp = Cn;% Hole Auger recombination coefficient 
        RefBelow = 1;  % reflectivity of the back-mirror of the cell
    else
        RefBelow = 1;  % reflectivity of the back-mirror of the cell
    end
    nr = 3.5; % refractive index, assumed to be same as GaAs
    
    
    %% Absorption Coefficients 
    Absorptivity = 'Step'; % can be either Step or Dispersive
    if strcmp(Absorptivity,'Dispersive')
        
       AbsorpCoeff = ones(1,100); %% provide the material absorption coefficient
       % here, in units of 1/m
       Lambda = zeros(1,100); %% provide the wavelengths (in m) at which the
       % absorption coefficient was measured, the array length should be 
       %the same as the absorption coefficient array
    else
        Eg = 1.31*q; % bandgap
    
    end
    
    Tfront =1;   % Transmissivity of the front surface of the cell, 
       % unitless
    
    %% effective mass calculation
    mc = 0.067*m0; % electron DOS effective mass
    mv = 0.45*m0; % hole DOS effective mass
    
    %% incident spectrum
    SourceType = 'Blackbody'; % can be eithe Blackbody expression or an 
    % tabular spectrum, like AM 1.5 in W/m^2
    if strcmp(SourceType,'Spectrum')
        Pin = ones(1,100); %% provide the material incident spectrum here
       % , in units of W/m2
        LambdaSource = zeros(1,100); %% provide the wavelengths (in m) at
       % which the incident spectrum  was measured, the array length should
       % be the same as the absorption coefficient array
       
       Esource = h*c./LambdaSource;
    else
        Emissivity = 1;
        GeometricViewFactor = 2.18e-5*Emissivity; % View factor of the Sun, 
        % from the solar cell
        Ts = 6000;
        func = @(x) 2*pi*x.^3./(c^2*h^3*(exp(x/(kb*Ts))-1));
        Esource = linspace(1e-3,10,1e3)*q; % photon energy array
        Pin = func(Esource)*GeometricViewFactor.*Esource; %incident power 
        % in watts/m^2
        
    end
  
    
