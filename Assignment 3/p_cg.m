function [x, iter, res_vec]= p_cg(A, b, tol, maxit, x0, M1, M2)
    if (isempty(M2))
      M = M1;
    else
      M = M1 * M2;
    end  

    Minv = inv(M);
    x = x0;
    r = b - (A*x);
    s = Minv * r;
    rsold = r' * Minv * r;
    res_vec =residual(A, x, b);

    for iter = 1 : maxit
      As = A*s;
      alpha = rsold/ ( s' * As);
      x = x + alpha*s;
      r = r - alpha *As;
      rsnew = r' * Minv * r;
      res_vec = [res_vec; residual(A, x, b);];

      if res_vec(iter + 1) < tol
        break
      endif

      s = Minv * r + (rsnew / rsold) * s;
      rsold = rsnew;
      
    endfor
  endfunction
  