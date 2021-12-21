function M = block_jacobi(M, block_size)
  for_end_condition = fix(rows(M)/block_size);
  for_end_condition = for_end_condition * block_size;
  list_of_matrices = [];

  for i= 1 : block_size : for_end_condition
    % block_start_index = 
    list_of_matrices{end+1} = M(i : i + block_size - 1, i : i + block_size - 1);
  endfor

  list_of_matrices{end+1} = M(for_end_condition+1 : rows(M), for_end_condition+1 : rows(M));
  M = blkdiag(list_of_matrices{:});
endfunction
