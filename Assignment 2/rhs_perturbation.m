function [E, delta_b] = rhs_perturbation(n)

  % random n*n E with 1norm = 10^-8
  E = rand(n)* 10^-8;

  % random n*1 delta_b with 1norm = 10^-8
  delta_b = rand(n, 1)* 10^-8;

endfunction
