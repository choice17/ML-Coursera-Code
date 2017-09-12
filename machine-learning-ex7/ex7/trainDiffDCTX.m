function [stdDFX,mDFX,Diffdx] = trainDiffDCTX(X)

%initialize parameter size of X 
% ay = sample number size ; ax = total pixel of input image
% fx is the dct fourier transform of X w.r.t to each sample
% ifx is the inverse dct FT
[ay,ax] = size(X);
fx = zeros(ay,ax);
ifx = fx;
%perform DCT
for i=1:ay; fx(i,:) = dct(X(i,:)); end

%to store fx to FX as bkup
Fx =fx;

%to normalize fx by minus mean(fx) along each sample
%and divide the std along each sample * all value 
nfx = bsxfun(@minus,fx,mean(fx,2));
s = std(nfx,[],2);
nfx = bsxfun(@rdivide,nfx,s);

%to zero the small value of nfx
%nfx(abs(nfx)<=0.5)=0;

%store IDCT to fx and store in ifx along each samples
for i=1:ay; ifx(i,:) = idct(fx(i,:)); end

%average value of the fourier transform in the whole dataset 
mfx = mean(nfx);

%to calc the distance between each sample to the average mean of dct
Diffdx = sum((bsxfun(@minus,nfx,mfx)).^2,2)./ax;
%Diffar = sum(bsxfun(@minus,nfx,ar),2)./ax;
fprintf('min of Diffdx is %d at %d \n', min(abs(Diffdx)), find(Diffdx == min(abs(Diffdx)))); 
%fprintf('min of Diffar is %d at %d \n', min(abs(Diffar)), find(Diffar == min(abs(Diffar))));

%return std and mean of the distance between each sample to the dct 
stdDFX = std(Diffdx);
mDFX = mean(Diffdx);

end