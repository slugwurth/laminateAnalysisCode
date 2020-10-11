function [Sfa, Sfr]=TsaiWu(F1t,F1c,F2t,F2c,F6,Stresses12)
% TsaiWu computes the factor of safety for a state of stress (Sfa)
% and for the reversed-in-sign state of stress (Sfr) based on the
% Tsai-Wu failure theory
%
%   Syntax:
%     [Sfa, Sfr] = TsaiWu(F1t,F1c,F2t,F2c,F6,Stresses12)
%
%   Inputs: 
%     F1t - The tensile strength in the 1-material direction
%     F1c - The compressive strength in the 1-material direction
%     F2t - The tensile strength in the 2-material direction
%     F2c - The compressive strength in the 2-material direction
%     F6  - The shear strength in the 1-2 material plane
%     Stresses12 - State of stress, vector input. 
%		   Stresses12 = [sigma_1 sigma_2 tau_12]'.
%
%     NOTE: Consistency with the units of the strength values and the stress state
%           is required for meaningful results.
%
%   Output: 
%     Sfa - factor of safety for the state of stress Stresses12
%     Sfr - factor of safety for the reversed-in-sign equivalent state of stress Stresses12
%
%   Author: Senthil S. Vel, University of Maine
%
%   See also StressTransformationMatrix, LaminaEngProperties

% Stress components
sigma1 = Stresses12(1);
sigma2 = Stresses12(2);
tau12 = Stresses12(3);

% Calculate the Tsai-Wu coefficients
f1 = 1/F1t-1/F1c;
f11 = 1/(F1t*F1c);
f2 = 1/F2t-1/F2c;
f22 = 1/(F2t*F2c);
f66 = 1/(F6^2);

% Determine the coefficients a and b
a = f11*sigma1^2+f22*sigma2^2+f66*tau12^2-sqrt(f11*f22)*sigma1*sigma2;
b = f1*sigma1+f2*sigma2;

% Determine the factor of safety for actual state of stress
Sfa=(-b+sqrt(b^2+4*a))/(2*a);

% Determine the factor of safety for reversed-in-sign state of stress
Sfr= (-b-sqrt(b^2+4*a))/(2*a);

end
