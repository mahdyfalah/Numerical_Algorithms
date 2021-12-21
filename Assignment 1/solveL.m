function x = solveL(B,b,n)

  for j =1:n
    if(B(j,j)==0)
      continue;
    endif

    x(j)=b(j)/B(j,j);

    for i=j+1:n
      b(i) = b(i)-B(i,j)*x(j);
    endfor

  endfor
endfunction
