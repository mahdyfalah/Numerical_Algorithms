function r = residual(A, x_hat, b)
    r = norm((A * x_hat) - b) / (normest(A) * normest(x_hat));
  endfunction
  