function [A, P] = plu(A, n)

  P = eye(n);

  for k = 1:n-1
    % Find index p such that |apk| ≥ |aik| for k ≤ i ≤ n

    % Finds the max value of each col and its index
    [maxE,I] = max(abs(A));
    p_index = I(k);

    if (p_index != k)
      % interchange rows k and p
      A([k p_index],:) = A([p_index k],:);
      P([k p_index],:) = P([p_index k],:);
    endif


    if(A(k,k)==0)
      continue;
    endif

    for i = k+1 : n
      % mik = aik/akk
      A(i,k) = A(i,k)/A(k,k);
    endfor

    for j = k+1:n
      for i = k+1:n
        % aij = aij −mikakj
        A(i,j) = A(i,j) - A(i,k)*A(k,j);
      endfor
    endfor

  endfor
endfunction
