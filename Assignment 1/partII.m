function partII()

  problem_size = [];
  forward_error_solveL = [];
  forward_error_solveU = [];
  residual_solveL = [];
  residual_solveU = [];

  for n = [2:10 15:5:50 60:10:100 200:100:500]

    problem_size = [problem_size; n;];

    A = randi([1, 10], [n,n]);
    % to prevent singular matix
    while det(A) == 0
      A = randi([1, 10], [n,n]);
    end

    [LU, P] = plu(A,n);
    [L, U] = split(LU, n);
    b = L * U * ones(n,1);

    % Ly = b
    y = solveL(L,b,n);
    true_y = b\L;
    forward_error_solveL = [forward_error_solveL; accuracy(y,true_y);];
    residual_solveL = [residual_solveL; residual(L, y', b)];


    % Ux = y
    x = solveU(U,y,n);
    forward_error_solveU = [forward_error_solveU; accuracy(x,ones(n,1));];
    residual_solveU = [residual_solveU; residual(U, x, y)];
  endfor
  % Plot


  semilogy(problem_size, forward_error_solveL);
  hold on;
  legend('relative forward error solveL');
  title('forward error of my implemented forward substitution');
  xlabel('problem size n');
  ylabel('error');
  hold off;

  figure()
  semilogy(problem_size, forward_error_solveU);
  hold on;
  legend('relative forward error solveU');
  title('forward error of my implemented backward substitution');
  xlabel('problem size n');
  ylabel('error');
  hold off;

  figure()
  semilogy(problem_size, residual_solveL);
  hold on;
  legend('relative residual solveL');
  title('relative residual of my implemented forward substitution');
  xlabel('problem size n');
  ylabel('error');
  hold off;

  figure()
  semilogy(problem_size, residual_solveU);
  hold on;
  legend('relative residual solveU');
  title('relative residual of my implemented backward substitution');
  xlabel('problem size n');
  ylabel('error');
  hold off;

endfunction
