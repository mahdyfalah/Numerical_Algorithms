function [x, delta_x] = lhs_perturbation(A, E, b, delta_b)

  %  n × 1 vector x which is the solution to the linear system Ax = b
  x = linsolve(A, b);

  % n × 1 vector delta x which is the difference xˆ − x between x
  % and the solution xˆ to the perturbed linear system
  delta_x = linsolve(A, b + delta_b) - x;
endfunction
