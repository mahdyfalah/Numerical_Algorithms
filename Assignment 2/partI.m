function partI()
  % accuracy
  problem_size = [];
  magnitude_condest = [];
  magnitude_est_cond = [];

  for n = [2:50 60:10:100 150:50:500 1000]
      problem_size = [problem_size; n;];
      A = rand(n);
      magnitude_condest = [magnitude_condest; magnitude(condest(A), cond(A));];
      magnitude_est_cond = [magnitude_est_cond; magnitude(est_cond(A), cond(A));];
  endfor

  semilogy(problem_size, magnitude_condest,
            problem_size, magnitude_est_cond);
  title('magnitude of condest vs est-cond compared to cond')
  xlabel("problem_size");
  ylabel("magnitude");
  legend ("condest", "est_cond");

  % runtime

  run_time_condest = [];
  run_time_est_cond = [];
  run_time_cond = [];

  for n = [2:50 60:10:100 150:50:500 1000]
      A = rand(n);

      tic();
      condest(A);
      run_time = toc();
      run_time_condest = [run_time_condest; run_time;];

      tic();
      est_cond(A);
      run_time = toc();
      run_time_est_cond = [run_time_est_cond; run_time;];

      tic();
      cond(A);
      run_time = toc();
      run_time_cond = [run_time_cond; run_time;];
  endfor

  figure()

  semilogy(problem_size, run_time_condest,
            problem_size, run_time_est_cond,
            problem_size, run_time_cond);
  title('runtime of condest vs est-cond vs cond')
  xlabel("problem_size");
  ylabel("runtime");
  legend ("condest", "est-cond", 'cond');
endfunction
