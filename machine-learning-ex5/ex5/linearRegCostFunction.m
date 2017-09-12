function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost and gradient of regularized linear 
%               regression for a particular choice of theta.
%
%               You should set J to the cost and grad to the gradient.
% % X < mxn; a1 < mxn+1;theta <(n+1)x1  ;h <m*1 ; 

pred = X*theta;
delta = pred-y;
tempTheta = theta;
tempTheta(1) = 0;
regularTerm = lambda*sum(((tempTheta(:)).^2));
J = 1/(2*m) .* sum((delta(:)).^2) + 1/(2*m) * regularTerm;

% grad < s1*(n+1)  = theta 
grad = 1/m .* (X'*delta) + lambda/m .* tempTheta; 













% =========================================================================

grad = grad(:);

end
