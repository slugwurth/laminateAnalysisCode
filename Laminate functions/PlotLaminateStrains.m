function PlotLaminateStrains(ComponentStr,ThetaArray,ZArray,Epsilon0,Kappa0,H)
% PlotLaminateStrains plots the through-the-thickness variation 
% (i.e. as a function of z) of a specifiec strain component in the laminate 
% 
%   Syntax:
%     PlotLaminateStrains(ComponentStr,ThetaArray,ZArray,Epsilon0,Kappa0,H)
%
%   Inputs: 
%     ComponentStr - Strain component to be plotted, takes one of the following 
%                    character array values: 
%                    in the golbal/structural coordinate system: 'ex', 'ey', 'gammaxy' 
%                    in the principal/material coordiante system: 'e1', 'e2', 'gamma12'
%     ThetaArray   - Nx1 vector of layer by layer fiber orientations, where N 
%                    is the number of layers in the laminate.
%     ZArray       - Array of interface z-coordinates of a laminate
%     Epsilon0     - Mid-surface strains of the laminate
%     Kappa0       - Mid-surface curvatures of the laminate
%     H            - Total height, i.e. thickness, of the laminate
%
%   Output: 
%     No outputs for this function (except the plot outputs as figures)
%
%   Author: Senthil S. Vel, University of Maine
%
%   See also LaminateStrainsXY, PlotLaminateStresses, PlotLaminateTsaiWuSfa .

% Read global plot parameters
global LineThickness 

% Determine the number of layers from the ThetaArray
N = length(ThetaArray);

% Specify the number of sampling points per layer for the plots
PointsPerLayer  = 2;

switch ComponentStr
    case 'ex'
        CoordinateSystem ='XY';
        Component = 1;
        xstr = 'Normal strain $\varepsilon_{\textit{x}}$ ($\mu \varepsilon$)';
        FigName = 'Normal strain e_x';
    case 'ey'
        CoordinateSystem ='XY';
        Component = 2;
        xstr = 'Normal strain $\varepsilon_{\textit{y}}$ ($\mu \varepsilon$)';
        FigName = 'Normal strain e_y';
    case 'gammaxy'
        CoordinateSystem ='XY';
        Component = 3;
        xstr = 'Shear strain $\gamma_{\textit{xy}}$ ($\mu$rad)';
        FigName = 'Shear strain gamma_xy';
    case 'e1'
        CoordinateSystem ='12';
        Component = 1;
        xstr = 'Normal strain $\varepsilon_{1}$ ($\mu \varepsilon$)';
        FigName = 'Normal strain e_1';
    case 'e2'
        CoordinateSystem ='12';
        Component = 2;
        xstr = 'Normal strain $\varepsilon_{2}$ ($\mu \varepsilon$)';
        FigName = 'Normal strain e_2';
    case 'gamma12'
        CoordinateSystem ='12';
        Component = 3;
        xstr = 'Shear strain $\gamma_{12}$ ($\mu$rad)';
        FigName = 'Shear strain gamma_12';
end

% Prepare the figure
figure('Name',FigName);
clf;
hold on;

for k = 1:N
    zloc = linspace(ZArray(k),ZArray(k+1),PointsPerLayer);
    
    % Evaluate the strains at the sampling points
    for n = 1: PointsPerLayer
        switch CoordinateSystem
            case 'XY'
                % Evaluate strains in the XY coordinate system
                StrainColumnArray = LaminateStrainsXY(Epsilon0,Kappa0,zloc(n));
            case '12'
                % Evaluate strains in the XY coordinate system
                StrainsXY = LaminateStrainsXY(Epsilon0,Kappa0,zloc(n));
                % Transform strains to the 1-2 coordinate system
                Te=StrainTransformationMatrix(ThetaArray(k));
                StrainColumnArray = Te*StrainsXY; 
        end
        % Extract the strain component of interest
        Strain(n) = StrainColumnArray(Component);
    end
    
    % plot the strain variation in layer k
    plot(Strain/1e-6,zloc/H,'k-','LineWidth',LineThickness,'LineJoin','round');

end

% Insert axes labels
xlabel(xstr,'Interpreter','latex');
ylabel('$z/H$','Interpreter','latex');

% Format the laminate plot
FormatLaminatePlot(ZArray)

end
