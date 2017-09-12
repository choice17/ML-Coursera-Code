function [s] = softmax_func(x)
 
e=exp(x);
s= e./sum(e);

end