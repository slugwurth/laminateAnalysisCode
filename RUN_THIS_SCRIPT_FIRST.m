%---------------------------------------------------------------
%    Add the subfolders to the PATH and set defaults
%---------------------------------------------------------------
%% Clear memory and close all figures
clear all 
close all 

%% Add all subfolders to path to enable Matlab to find the necessary functions
addpath(genpath(pwd))

%% Define global variables
global LineThickness FontSize
global InterfaceLineColor MidsurfaceLineColor VerticalAxisLineColor

%%  Set defaults for the plots
% Set the default font for the figures
set(0,'defaultAxesFontName', 'Times New Roman')
set(0,'defaultTextFontName', 'Times New Roman')

% Set default figure size 
set(0,'defaultfigureposition',[120 120 1150 700])

% Set default line width for the plots
LineThickness = 3.0;

% Set the default font size for the plots
FontSize = 22;

% Define colors
InterfaceLineColor = [0.75 0.75 0.75];
MidsurfaceLineColor = [0.75 0.75 0.75];
VerticalAxisLineColor = [0.4  0.4  0.4];

