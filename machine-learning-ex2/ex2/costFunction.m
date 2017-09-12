function [J, grad] = costFunction(theta, X, y)
%COSTFUNCTION Compute cost and gradient for logistic regression
%   J = COSTFUNCTION(theta, X, y) computes the cost of using theta as the
%   parameter for logistic regression and the gradient of the cost
%   w.r.t. to the parameters.

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));
n = size(theta,1);
% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta
%
% Note: grad should have the same dimensions as theta
%
prediction = sigmoid(X*theta);     %mx1

% Compute cost function
J = 1/m .* (-y'*log(prediction) -(1-y)'*log(1-prediction));

%templog(:,1) = log(prediction); %mx1
%templog(:,2) = log(1-(prediction)); %mx1
%tempy(:,1) = y; %mx1
%tempy(:,2) = 1-y; %mx1
%temp = templog.*tempy;
%J = (1/m)*(-sum(temp(:,1))-sum(temp(:,2))) ;


grad(1) = 1/m .* (prediction-y)'*X(:,1);
for i=2:n
    grad(i)= 1/m .* (prediction-y)'*X(:,i); % lamda/m .* theta(i);
end










% =============================================================

end
