function StrainsXY = LaminateStrainsXY(Epsilon0,Kappa0,z)
% LaminateStrainsXY computes, for a given mid-surface strain vector
% and mid-surface curvatures vector, the strains at a specified location
% (or through-thickness coordinate) z.
%
%   Syntax:
%     StrainsXY = LaminateStrainsXY(Epsilon0,Kappa0,z)
%
%   Inputs: 
%     Epsilon0 - A 3x1 vector of mid-surface strains
%     Kappa0   - A 3x1 vector of mid-surface curvatures
%     z        - z-coordinate of the location for calculating the x-y strains
%
%   Output: 
%     StrainsXY - A 3x1 array of strains in the x-y (global) coordinate system
%
%   Author: Senthil S. Vel, University of Maine
%
%   See also LaminateABD, LaminateStressesXY, LaminateEngineeringProperties.

% Compute the strains based on the Kirchhoff assumptions
StrainsXY = Epsilon0+z*Kappa0;

end
