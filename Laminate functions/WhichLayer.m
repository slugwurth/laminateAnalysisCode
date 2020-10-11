function LayerNumber = WhichLayer(N,ZArray,z)
% LayerNumber determines to which layer of the laminate a point 
% with a specified z coordinate belongs
%
%   Syntax:
%     LayerNumber = WhichLayer(N,ZArray,z)
%
%   Inputs: 
%     N      - Number of layers in the laminate
%     ZArray - Array of interface z coordinates
%     z      - thickness coordinate of the location for which the layer number 
%              is to be determined
%
%   Output: 
%     LayerNumber - The layer to which point z belongs to
%
%   Author: Senthil S. Vel, University of Maine
%
%   See also LaminateABD, LaminateStrainsXY, LaminateEngineeringProperties, LaminateStressesXY.

% Check layer by layer to see if ZArray(k) <= z <= ZArray(k+1)
for k = 1:N
    if (z >= ZArray(k)) & (z <= ZArray(k+1))
        LayerNumber = k; % assign layer number if ZCoord(k) <= z <= ZCoord(k+1);
    end
end

end
