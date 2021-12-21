function x=solveU(B,b,n)
  x=ones(n,1);

  for j = n:-1:1
    if(B(j,j)==0)
      continue;
    endif

    x(j)=b(j)/B(j,j);

    for i=1:j-1
      b(i)=b(i)-B(i,j)*x(j);
    endfor

  endfor
endfunction
