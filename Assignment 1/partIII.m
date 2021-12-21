function partIII()

  linSolve_forward_error_S = [];
  linSolve_forward_error_H = [];
  linSolve_residual_S = [];
  linSolve_residual_H = [];

  octave_forward_error_S = [];
  octave_forward_error_H = [];
  octave_residual_S = [];
  octave_residual_H = [];

  np_forward_error_S = [];
  np_forward_error_H = [];
  np_residual_S = [];
  np_residual_H = [];

  problem_size = [];

  for n = [2:10 15:5:50 60:10:100 200:100:500]

    problem_size = [problem_size; n;];

    % Matrix S
    S = randi([-1, 1], [n,n]);
    while det(S) == 0
      S = randi([-1, 1], [n,n]);
    end

    [LUs, Ps] = plu(S,n);
    [Ls, Us] = split(LUs, n);
    % LUx = b
    bs = Ls * Us * ones(n,1);

    linSolve_forward_error_S = [linSolve_forward_error_S; accuracy(linSolve(LUs, bs, n), ones(n,1));];
    linSolve_residual_S = [linSolve_residual_S; residual(S, linSolve(LUs, bs, n), bs)];

    octave_forward_error_S  = [octave_forward_error_S; accuracy(bs\S, ones(n,1));];
    octave_residual_S  = [octave_residual_S; residual(S, (bs\S)', bs)];

    % No Pivot S
    [LUs] = plu_nopivot(S,n);
    [Ls, Us] = split(LUs, n);
    % LUx = b
    bs = Ls * Us * ones(n,1);

    np_forward_error_S = [np_forward_error_S; accuracy(linSolve(LUs, bs, n), ones(n,1));];
    np_residual_S = [np_residual_S; residual(S, linSolve(LUs, bs, n), bs)];

    % Matrix H
    H = zeros(n);
    for i = 1:n
      for j = 1:n
        H(i,j) = 1/(i+j-1);
      endfor
    endfor

    [LUh, Ph] = plu(H,n);
    [Lh, Uh] = split(LUh, n);
    bh = Lh * Uh * ones(n,1);

    % linSolve
    linSolve_forward_error_H = [linSolve_forward_error_H; accuracy(linSolve(LUh, bh, n), ones(n,1));];
    linSolve_residual_H = [linSolve_residual_H ; residual(H, linSolve(LUh, bh, n), bh)];


    % octave
    octave_forward_error_H  = [octave_forward_error_H ; accuracy(bh\H, ones(n,1));];
    octave_residual_H = [octave_residual_H; residual(H, (bh\H)', bh)];


    % No Pivot H
    [LUh] = plu_nopivot(H,n);
    [Lh, Uh] = split(LUh, n);
    % LUx = b
    bh = Lh * Uh * ones(n,1);

    np_forward_error_H = [np_forward_error_H; accuracy(linSolve(LUh, bh, n), ones(n,1));];
    np_residual_H = [np_residual_H; residual(H, linSolve(LUh, bh, n), bh)];

  endfor

  semilogy(problem_size, linSolve_forward_error_S,
            problem_size, octave_forward_error_S,
            problem_size, np_forward_error_S);
  hold on;
  legend('linSolve', 'octave', 'no pivot');
  title('forward error of matrix S');
  xlabel('problem size n');
  ylabel('error');
  hold off;

  figure()
  semilogy(problem_size, linSolve_forward_error_H,
            problem_size, octave_forward_error_H,
            problem_size, np_forward_error_H);
  hold on;
  legend('linSolve', 'octave', 'no pivot');
  title('forward error of matrix H');
  xlabel('problem size n');
  ylabel('error');
  hold off;

  figure()
  semilogy(problem_size, linSolve_residual_S,
            problem_size, octave_residual_S,
            problem_size, np_residual_S);
  hold on;
  legend('linSolve', 'octave', 'no pivot');
  title('relative residual of matrix S');
  xlabel('problem size n');
  ylabel('error');
  hold off;

  figure()
  semilogy(problem_size, linSolve_residual_H,
            problem_size, octave_residual_H,
            problem_size, np_residual_H);
  hold on;
  legend('linSolve', 'octave', 'no pivot');
  title('relative residual of matrix H');
  xlabel('problem size n');
  ylabel('error');
  hold off;

endfunction
