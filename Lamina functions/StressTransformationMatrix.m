function Ts=StressTransformationMatrix(Theta)
% StressTransformationMatrix computes the 2D stress coordinate 
% transformation matrix based on the Voigt notation (T_sigma)
%
%   Syntax:
%     Ts = StressTransformationMatrix(Theta)
%
%   Inputs: 
%     Theta - Rotation angle in degrees 
%
%   Output: 
%     Ts - 3x3 2D stress coordinate transformation matrix
%	       (based on the Voigt notation)
%
%   Author: Senthil S. Vel, University of Maine
%
%   See also InverseStressTransformationMatrix, StrainTransformationMatrix, InverseStrainTransformationMatrix

% Cosine and Sine of the angle 
  m = cosd(Theta);
  n = sind(Theta);

% Stress transformation matrix T_sigma
 Ts =[ m^2  n^2   2*m*n;
        n^2  m^2  -2*m*n;
       -m*n  m*n  m^2-n^2];
   
end
