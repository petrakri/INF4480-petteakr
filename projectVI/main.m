%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% MAIN %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author:  Petter André Kristiansen  %
% Version: 1.1                       %
% Topic:   Adaptive filtering        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% DOCSTRING:
% 
% 
%
%
%

close all; clear; clc;
addpath(genpath('/lib/'));
addpath(genpath('/lib/adaptivefilters/'));

%%
x = [1 2 3 4];
X = convm(x, 3);