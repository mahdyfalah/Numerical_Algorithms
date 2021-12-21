function c = est_cond(A)
  % input : n*n matrix A
  % output : scalar c which is the estimated 1-norm condition number of A

  % compute ||A||
  norm_A = norm(A,1);

  % factor A = LU
  [L, U, P] = lu(A);

  % solve transpose(U) * w = e, choosing ek as described
  w = solveU(U);

  % solve transpose(L) * y = w
  y = linsolve(L.', w);

  % solve L*v = y
  v = linsolve(L, y);

  % solve U*z = v
  z = linsolve(U, v);

  RCOND =  norm(y, 1)/ (norm_A * norm(z, 1));
  c = 1/RCOND;
endfunction
