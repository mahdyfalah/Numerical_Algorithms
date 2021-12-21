function r = residual(A,x_hat,b)
  r = norm((A*x_hat)-b,1)/(norm(A,1)* norm(x_hat,1));
endfunction
