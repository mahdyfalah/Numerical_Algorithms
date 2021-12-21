function [L, U] = split(LU, n)
  U = triu(LU);
  L = eye(n) + tril(LU,-1);
endfunction
