% =========================================================================
% 
%                           Curvature Filter 
% 
% *************************************************************************  
% 
%         @phdthesis{gong:phd, 
%          title={Spectrally regularized surfaces}, 
%          author={Gong, Yuanhao}, 
%          year={2015}, 
%          school={ETH Zurich, Nr. 22616},
%          note={http://dx.doi.org/10.3929/ethz-a-010438292}}
% 
% =========================================================================

% this demo shows four edge-preserving filters and how to use them solve variational models 

%% ************************* Gaussian curvature *********************************************
im = imread('lena.png');

FilterType = 2;
Iteration = 60;

disp('** running time includes the time for computing energy. **')

tic
[result,energy]=CF(im,FilterType, Iteration);
mytime = toc;

%% show the running time and the result
mystr = strcat('GC filter performance: ', num2str(mytime/Iteration),' seconds per iteration (', num2str(size(im,1)),'X', num2str(size(im,2)), ' image)');
disp(mystr)

figure, imagesc([double(im),result,double(im)-result]), daspect([1,1,1]), colorbar
title('original(left), GCFilter(mid), difference(right)')
figure,plot(energy,'linewidth',4),xlabel('Iteration'), ylabel('Gaussian Curvature Energy'),title('Energy profile')

%% ************************* mean curvature *********************************************
im = imread('lena.png');

FilterType = 1;
Iteration = 60;

tic
[result,energy]=CF(im,FilterType,Iteration);
mytime = toc;

%% show the running time and the result
mystr = strcat('MC filter performance: ', num2str(mytime/Iteration),' seconds per iteration (', num2str(size(im,1)),'X', num2str(size(im,2)), ' image)');
disp(mystr)

figure, imagesc([double(im),result,double(im)-result]), daspect([1,1,1]), colorbar
title('original(left), MCFilter(mid), difference(right)')
figure,plot(energy,'linewidth',4),xlabel('Iteration'), ylabel('Mean Curvature Energy'),title('Energy profile')

%% ************************* Bernstein Filter also minimizes mean curvature *********************************************
im = imread('lena.png');

FilterType = 4;
Iteration = 60;

tic
[result,energy]=CF(im, FilterType, Iteration);
mytime = toc;

%% show the running time and the result
mystr = strcat('BF filter performance: ', num2str(mytime/Iteration),' seconds per iteration (', num2str(size(im,1)),'X', num2str(size(im,2)), ' image)');
disp(mystr)

figure, imagesc([double(im),result,double(im)-result]), daspect([1,1,1]), colorbar
title('original(left), BFilter(mid), difference(right)')
figure,plot(energy,'linewidth',4),xlabel('Iteration'), ylabel('Mean Curvature Energy'),title('Energy profile')

%% ************************* TV Filter minimizes Total Variation *********************************************
im = imread('lena.png');

FilterType = 0;
Iteration = 60;

tic
[result,energy]=CF(im, FilterType, Iteration);
mytime = toc;

%% show the running time and the result
mystr = strcat('TV filter performance: ', num2str(mytime/Iteration),' seconds per iteration (', num2str(size(im,1)),'X', num2str(size(im,2)), ' image)');
disp(mystr)

figure, imagesc([double(im),result,double(im)-result]), daspect([1,1,1]), colorbar
title('original(left), TVFilter(mid), difference(right)')
figure,plot(energy,'linewidth',4),xlabel('Iteration'), ylabel('TV Energy'),title('Energy profile')




%% ************************************************************************
%
%              Local Filter Solver for Variational Models
%
%% ************************************************************************

im = imread('lena.png');

MaxIteration = 60;
DataFitOrder = 1.3; %fractional order
Lambda = 3;
FilterType = 0;

tic
[result,energy]=Solver(im, FilterType, DataFitOrder, Lambda, MaxIteration);
mytime = toc;

%% show the running time and the result
mystr = strcat('solver performance: ', num2str(mytime/MaxIteration),' seconds per iteration (', num2str(size(im,1)),'X', num2str(size(im,2)), ' image)');
disp(mystr)

figure,imagesc([double(im),result,double(im)-result]), daspect([1,1,1]), colorbar
title('original(left), Result(mid), difference(right)')

x=0:size(energy,1)-1; x=x';
figure,plot(x,energy(:,1),'linewidth',4),xlabel('Iteration'), ylabel('Energy'),title('Energy profile'),hold on
plot(x,energy(:,2),'linewidth',4),plot(x,energy(:,3),'linewidth',4), legend('Total Energy','DataFit Energy','Regularization Energy','location','west')
legend('boxoff')