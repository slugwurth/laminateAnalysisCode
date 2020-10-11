function [SfaMin,kmin,zmin] = PlotLaminateTsaiWuSfa(F1t,F1c,F2t,F2c,F6,ThetaArray,QBarArray,ZArray,Epsilon0,Kappa0,H)
% PlotLaminateTsaiWuSfa plots the through-the-thickness variation (i.e. as a function of z)
% of the Tsai-Wu factor of safety for given mid-surface strains and curvatures in a laminate.
% It also outputs the minimum factor of safety, its z-location and the layer of 
% the laminate it occurs in.
%
%   Syntax:
%     PlotLaminateTsaiWuSfa(S1t,S1c,S2t,S2c,S6,ThetaArray,QBarArray,ZArray,Epsilon0,Kappa0,H)
%
%   Inputs: 
%     F1t        - Tensile strength in the 1-direction (principal coordinate system)
%     F1c        - Compressive strength in the 1-direction (principal coordinate system) 
%     F2t        - Tensile strength in the 2-direction (principal coordinate system) 
%     F2c        - Compressive strength in the 2-direction (principal coordinate system) 
%     F6         - Shear strength in the 1-2 plane (principal coordinate system)
%     ThetaArray - Nx1 vector of layer fiber orientations, where N is the number 
%                  of layers in the laminate.
%     QBarArray  - An array where QBarArray{k} is a 3x3 matrix of off-axis 
%                  stiffnesses of the kth layer of the laminate
%     ZArray     - Array of interface z-coordinates of a laminate
%     Epsilon0   - Mid-surface strains of the laminate
%     Kappa0     - Mid-surface curvatures of the laminate
%     H          - Total height, i.e. thickness, of the laminate
%
%   Output: 
%     SfaMin - Minimum Tsai-Wu factor of safety
%     kmin   - Minimum Tsai-Wu factor of safety layer of occurence
%     zmin   - Minimum Tsai-Wu factor of safety location (height) of occurence
%     Also the plots are an output
%
%   Author: Senthil S. Vel, University of Maine
%
%   See also PlotLaminateStresses, PlotLaminateStrains, PlotLaminateTsaiWuSfr .

% Read global plot parameters
global LineThickness 

% Determine the number of layers from the QBarArray
N = length(QBarArray);

% Specify the number of sampling points per layer for the plots
PointsPerLayer  = 500;

% Prepare the figure
figure('Name','Safety factor Sfa');
clf;
hold on;

% Initialize the minimum safety factor value
SfaMin = inf;

for k = 1:N
    % Sample points from Z(k)-eps to Z(k+1)+eps. The eps is used to
    % avoid ambiguity of which layer the interface belongs to. Use a very
    % small value for the parameter eps to ensure points close to the
    % interfaces are included in the plots
    eps = 1e-12;
    zloc = linspace(ZArray(k)+eps,ZArray(k+1)-eps,PointsPerLayer);
    
    % Evaluate the safety factor at the sampling points
    for n = 1: PointsPerLayer
        % Evaluate stresses in the XY coordinate system
        StressesXY = LaminateStressesXY(QBarArray,ZArray,Epsilon0,Kappa0,zloc(n));
        
        % Transform stresses to the 1-2 coordinate system
        Ts=StressTransformationMatrix(ThetaArray(k));
        Stresses12 = Ts*StressesXY;
        
        % Calculate the safety factor
        [Sfa(n), Sfr(n)]=TsaiWu(F1t,F1c,F2t,F2c,F6,Stresses12);
        
        % Update the min safety factor values
        if Sfa(n) < SfaMin
            SfaMin = Sfa(n);
            zmin = zloc(n);
            kmin = k;
        end
        
        %SfaMin = min(SfaMin, min(Sfa));
    end
    
    % plot the safety factor variation in layer k
    hp = plot(Sfa,zloc/H,'k-','LineWidth',LineThickness);
end

% Insert axes labels
xlabel('Safety factor $S_{fa}$','Interpreter','latex');
ylabel('$z/H$','Interpreter','latex');

% Format the laminate plot
FormatLaminatePlot(ZArray);

end

