function partI()

  plu_accuracy = [];
  problem_size = [];

  for n = [2:10 15:5:50 60:10:100 200:100:500]

    problem_size = [problem_size; n;];

    A = randi([1, 10], [n,n]);
    % to prevent singular matix
    while det(A) == 0
      A = randi([1, 10], [n,n]);
    end

    [LU, P] = plu(A,n);
    [L, U] = split(LU, n);
    plu_accuracy = [plu_accuracy; accuracy(P.'*L*U, A);];

  endfor

  # Plot

  semilogy(problem_size, plu_accuracy)
  hold on;
  legend('plu with partial pivot') ;
  title('acuuracy of my implemented plu')
  xlabel('problem size n')
  ylabel('acuuracy')
  hold off;

endfunction
