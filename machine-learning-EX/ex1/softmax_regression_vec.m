function [f,g] = softmax_regression(theta, X,y)
  %
  % Arguments:
  %   theta - A vector containing the parameter values to optimize.
  %       In minFunc, theta is reshaped to a long vector.  So we need to
  %       resize it to an n-by-(num_classes-1) matrix.
  %       Recall that we assume theta(:,num_classes) = 0.
  %
  %   X - The examples stored in a matrix.  
  %       X(i,j) is the i'th coordinate of the j'th example.
  %   y - The label for each example.  y(j) is the j'th example's label.
  %
  m=size(X,2);
  n=size(X,1);

  % theta is a vector;  need to reshape to n x num_classes.
  theta=reshape(theta, n, []);
  num_classes=size(theta,2)+1;
%num_classes=size(theta,2);  


  
  % initialize objective value and gradient.
  f = 0;
  g = zeros(size(theta));

  %
  % TODO:  Compute the softmax objective function and gradient using vectorized code.
  %        Store the objective function value in 'f', and the gradient in 'g'.
  %        Before returning g, make sure you form it back into a vector with g=g(:);
  %
%%% YOUR CODE HERE %%%

% where z is the input of softmax function
% sZ is the normalize term of the probability softmax components
% = sum( exp(theta'*X) )
% h is the softmax function
% indicator is to locate the softmax term to the related class
% eg. Class = [1 2 3]; y = [2 1 3]; in = [0 1 0;1 0 0; 0 0 1]' 
% f is the cost function
a = theta'*X;
a = [a ;zeros(1,m)];
eA = exp(a);
sA = sum(exp(a));
h = eA./sA;

indicator = y==[1:num_classes]';
f = -sum(sum(indicator.*log(h)));

% calc the gradient g
g = X*(indicator - h)';
g=g(:,1:end-1); % make gradient a vector for minFunc
g=g(:);
end