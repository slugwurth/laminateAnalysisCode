function [E1,nu12,E2,G12,F1t,F1c,F2t,F2c,F6,h,rho] = UnidirectionalCarbonEpoxyProperties
% Assigns material properties in the principal material directions
%
%   Syntax:
%     E1,nu12,E2,G12,F1t,F1c,F2t,F2c,F6,h,rho] = UnidirectionalCarbonEpoxyProperties 
%
%   Inputs: None
%
%   Output: 
%     E1 - Young's modulus in the 1-direction
%     nu12 - major Poisson's ratio
%     E2 - Young's modulus in the 2-direction
%     G12 - inplane shear modulus
%     F1t - The tensile strength in the 1-material direction
%     F1c - The compressive strength in the 1-material direction
%     F2t - The tensile strength in the 2-material direction
%     F2c - The compressive strength in the 2-material direction
%     F6  - The shear strength in the 1-2 material plane
%     Note 1 and 2 are the principal material directions.
%     Typically E1,E2,G12,F1t,F2t,F2t, F2c and F6 are specified in SI units of Pa.
%
%   Author: Senthil S. Vel, University of Maine
%
%   See also ReducedStiffness, ReducedCompliance, OffAxisStiffness, OffAxisCompliance.

% Representative elastic properties of an IM7/8552 unidireciontal 
% fiber-reinforced carbon fiber composite

% The Young's moduli and shear moduli are in Pa
E1 = 167.4e9;
nu12 = 0.30;
E2 = 10.3e9;
G12 = 6.4e9;

% Representative strengths of a lamina in Pa
F1t = 2723e6;
F1c = 1689e6;
F2t = 64.1e6;
F2c = 199.8e6;
F6 = 92.3e6;

% Density in kg/m^3
rho = 1588;

% Ply thickness in meters
h = 0.2e-3;

% Print lamina properties
fprintf('Elastic moduli of the composite material: \n')
fprintf('  E1 = %g GPa \n',E1/1e9)
fprintf('  nu12 = %g \n',nu12)
fprintf('  E2 = %g GPa \n',E2/1e9)
fprintf('  G12 = %g GPa \n',G12/1e9)

fprintf('Strengths of the composite material: \n')
fprintf('  S1t = %g MPa \n',F1t/1e6)
fprintf('  S1c = %g MPa \n',F1c/1e6)
fprintf('  S2t = %g MPa \n',F2t/1e6)
fprintf('  S2c= %g MPa \n',F2c/1e6)
fprintf('  S6 = %g MPa \n',F6/1e6)

fprintf('Density: \n')
fprintf('  rho = %g kg/m^3 \n',rho)

fprintf('Ply thickness: \n')
fprintf('  h = %g mm \n\n',h/1e-3)
