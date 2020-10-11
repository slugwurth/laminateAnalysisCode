function StressesXY = LaminateStressesXY(QBarArray,ZArray,Epsilon0,Kappa0,z)
% LaminateStressesXY computes, for a given mid-surface strain vector
% and mid-surface curvatures vector, the stresses at a specified location
% (or through-thickness coordinate) z.
%
%   Syntax:
%     StressesXY = LaminateStressesXY(QBarArray,ZArray,Epsilon0,Kappa0,z)
%
%   Inputs: 
%     QBarArray - An array where QBarArray{k} is a 3x3 matrix of off-axis 
%                 stiffnesses of the kth layer of the laminate
%     ZCoord    - Array of interface locations, i.e., the beginning of each 
%                 layer of the laminate
%     Epsilon0  - A 3x1 vector of mid-surface strains
%     Kappa0    - A 3x1 vector of mid-surface curvatures
%     z         - z-coordinate of the location for calculating the x-y stresses
%
%   Output: 
%     StressesXY - A 3x1 array of stresses in the x-y (global) coordinate system
%
%   Author: Senthil S. Vel, University of Maine
%
%   See also LaminateABD, LaminateStrainsXY, LaminateEngineeringProperties, WhichLayer.

% Determine the number of layers from the length of the QBar array
N = length(QBarArray);

% Determine which layer the z coordinate belongs to
k = WhichLayer(N,ZArray,z); % layer number
 
% Determine the strains at the specified z location
StrainsXY = LaminateStrainsXY(Epsilon0,Kappa0,z);

% Stresses in the x-y coordinate system
StressesXY = QBarArray{k}*StrainsXY;

end

