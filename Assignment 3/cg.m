function [x, iter, res_vec]= cg(A, b, tol, maxit, x0)
    x = x0;
    r = b - (A*x);
    s = r;
    rsold = r' * r;
    res_vec = residual(A, x, b);
    for iter = 1 : maxit
      As = A*s;
      alpha = rsold/ ( s' * As);
      x = x + alpha*s;
      r = r - alpha *As;
      rsnew = r' * r;
      res_vec = [res_vec; residual(A, x, b);];
      if res_vec(iter + 1) < tol
        break
      endif
      s = r + (rsnew / rsold) * s;
      rsold = rsnew;
    endfor
  endfunction