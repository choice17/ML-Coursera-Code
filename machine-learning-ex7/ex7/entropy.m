function ent = entropy(p,n)

t = p+n;
ent = -p/t*log2(p/t) - n/t*log2(n/t);
end