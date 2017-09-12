clc;
clear all; close all;
load ('ex7faces.mat');

%to calc the std/mean of the difference of sum of square between dct of each sample to
%dct of average dct sample value

[stdFD,meanFD,Diffdx]=trainDiffDCTX(X);

% plot the histogram and gaussian function of the diffdx
gFDD = 0.2:0.01:1.4;
gFD = gaussmf(gFDD,[stdFD meanFD]);
[H,HX] =hist(Diffdx,length(gFDD));
H =H./max(H);
plot(gFDD,gFD); hold on;
plot(HX,H,'k');
axis([0.2 1.4 0 1.2]);

%%
test = rgb2gray(imread('bird_small.png'));
tic
test = imresize(test,[32 32]);
[ty,tx] = size(test); 
testT = reshape(test,[1 tx*ty]);
%%

dt = dct(double(testT));
ndt = bsxfun(@minus,dt,mean(dt,2));
st= std(ndt,[],2);
ndt = bsxfun(@rdivide,ndt,st);ndt(abs(ndt)<=0.5)=0;
diff = sum(bsxfun(@minus,ndt,mfx),2)./ax;
t=toc
gx = gaussmf(diff,[stdFD meanFD]);
figure;
[H,HX] =hist(Diffdx,length(gFDD),'k');
H =H./max(H);
plot(HX,H,'-k');
hold on;
plot(gFDD,gFD,'b-',diff,gx,'ro');
hold off;


%y = gaussmf(x,[sig c]) 
%%


%% direct mean
load ('ex7faces.mat');
[ay,ax] = size(X);
nX = bsxfun(@minus,X,mean(X,2));
sX = std(nX,[],2);
nX = bsxfun(@rdivide,nX,sX);
mX = mean(nX);
DiffnX = sum(bsxfun(@minus,nX,mX),2)./ax;
logD = log10(abs(DiffnX));
hist(logD,100);
mDD = mean(logD);
stDD = std(logD);
gdX = -16.5:0.1:-12.5;
gX = gaussmf(gdX,[stDD mDD]);
figure;
plot(gdX,gX);
%%
test = rgb2gray(imread('bird_small.png'));
test = double(test);
tR =test;
tO =dct(test(:));
tic
test = imresize(test,[32 32]);
tf = dct(test(:));
[ty,tx] = size(test); 
testT = reshape(test,[1 tx*ty]);
dt = double(testT);
ndt = bsxfun(@minus,dt,mean(dt,2));
st= std(ndt,[],2);
ndt = bsxfun(@rdivide,ndt,st);
diff = sum(bsxfun(@minus,ndt,mX),2)./ax;
%logDif = log10(abs(diff));
t=toc
