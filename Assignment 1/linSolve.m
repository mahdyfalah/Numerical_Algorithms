function x = linSolve(A, b, n)
  % [LU,P] = plu(A, n);
  [L, U] = split(A, n);
  % LUx = b
  % Ly = b
  % Ux = y
  x = solveU(U, solveL(L, b, n), n);
endfunction
