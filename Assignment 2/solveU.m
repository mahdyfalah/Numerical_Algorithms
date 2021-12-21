function w = solveU(U)
  [U_row, U_column] = size(U);
  w = zeros(U_row, 1);
  E = zeros(U_row, 1);

  for k = 1:U_row
    for j = k : U_row
      t(j) = U(1:(j-1), j).'*w(1:(j-1));
    endfor

    ep = sign(-t(k));
    en = -ep;

    if(t(k) == 0)
      ep = 1;
      en = -1;
    endif

    wp = (ep - t(k)) / U(k,k);
    wn = (en - t(k)) / U(k,k);

    partial_sum = t((k+1):U_row) + U(k, (k+1) : U_row);

    sum_tj_plus = abs(ep - t(k) + sum(partial_sum)*wp);
    sum_tj_minus = abs(en - t(k) + sum(partial_sum)*wn);

    if(k == 1 || sum_tj_plus > sum_tj_minus)
      w(k) = wp;
      E(k) = ep;
    else
      w(k) = wn;
      E(k) = en;
    endif
  endfor
endfunction
