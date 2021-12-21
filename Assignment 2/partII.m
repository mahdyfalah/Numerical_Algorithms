function partII()
  left_hand_side = [];
  right_hand_side = [];
  problem_size = [];

  for n = [2:50 60:10:100 150:50:500 1000]
    problem_size = [problem_size; n;];

    [E, delta_b] = rhs_perturbation(n);

    list_of_lb = [];
    list_of_rb = [];

    for i = 1 : 50
      A = rand(n);
      b = rand(n, 1);
      [lb, rb] = bounds(A, E, b, delta_b);

      list_of_lb = [list_of_lb; lb;];
      list_of_rb = [list_of_rb; rb;];
    endfor

    left_hand_side = [left_hand_side; mean(list_of_lb);];
    right_hand_side = [right_hand_side; mean(list_of_rb);];

  endfor

  semilogy(problem_size, left_hand_side,
            problem_size, right_hand_side)
  legend('left hand side', 'right hand side') ;
  title('bounds of perturbed system')
  xlabel('problem size n')
  ylabel('average')
endfunction
