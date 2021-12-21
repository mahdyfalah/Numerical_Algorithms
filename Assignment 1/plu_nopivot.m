function A = plu_nopivot(A, n)

  for k = 1:n-1
    if (A(k,k) == 0)
      continue;
    endif

    for i = k+1:n
      A(i,k) = A(i,k)/A(k,k);
    endfor

    for j = k+1:n
      for i = k+1:n
        A(i,j)=A(i,j)-A(i,k)*A(k,j);
      endfor
    endfor

  endfor
endfunction
