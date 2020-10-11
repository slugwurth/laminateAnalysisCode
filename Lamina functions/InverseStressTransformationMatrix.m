function [Tsinv]=InverseStressTransformationMatrix(Theta)
% InverseStressTransformationMatrix computes the inverse of the 
% 2D stress coordinate transformation matrix based on the
% Voigt notation (T_sigma)
%
%   Syntax:
%     Tsinv = InverseStressTransformationMatrix(Theta)
%
%   Inputs: 
%     Theta - Rotation angle in degrees 
%
%   Output: 
%     Tsinv - 3x3 inverse of the 2D stress coordinate transformation matrix
%	      (for the Voigt notation case)
%
%   Author: Senthil S. Vel, University of Maine
%
%   See also StrainTransformationMatrix, StressTransformationMatrix, InverseStrainTransformationMatrix

% Cosine and Sine of the angle 
  m = cosd(Theta);
  n = sind(Theta);

% Inverse of the stress transformation matrix
  Tsinv =[m^2    n^2    -2*m*n;
          n^2    m^2     2*m*n;
          m*n   -m*n    m^2-n^2];

end
