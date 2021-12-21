% choose one of the matrices below by uncommenting

[A,rows,cols,entries,rep,field,symm] = mmread("nos5.mtx");
% [A,rows,cols,entries,rep,field,symm] = mmread("nos6.mtx");
% [A,rows,cols,entries,rep,field,symm] = mmread("s3rmt3m3.mtx");

b = ones(rows, 1);
tol = 1e-10;
maxit = rows;
x0 = rand(rows, 1);

% comparison of and implemented cg and implemented pcg

% standard cg
tic
[x, iter1, res_vec1] = cg(A, b, tol, maxit, x0);
t1 = toc;

% preconditioned cg
% diagonal preconditioned
tic
[x, iter2, res_vec2] = p_cg(A, b, tol, maxit, x0, jacobi(A), []);
t2 = toc;

% block diagonal
% block size = 5
tic
[x, iter3, res_vec3] = p_cg(A, b, tol, maxit, x0, block_jacobi(A, 5), []);
t3 = toc;

% block size = 25
tic
[x, iter4, res_vec4] = p_cg(A, b, tol, maxit, x0, block_jacobi(A, 25), []);
t4 = toc;

% block size = 100
tic
[x, iter5, res_vec5] = p_cg(A, b, tol, maxit, x0, block_jacobi(A, 100), []);
t5 = toc;

% incomplete choleskey factorization
tic
% alpha = max(sum(abs(A),2)./diag(A))-2;
% L = ichol(A, struct('type','ict', 'diagcomp',alpha));
L = ichol(A);
[x, iter6, res_vec6] = p_cg(A, b, tol, maxit, x0, L, L');
t6 = toc;

% theshold dropping
% threshold 1e-1
tic
% alpha = max(sum(abs(A),2)./diag(A))-2;
% L = ichol(A, struct('type','ict','droptol', 1e-1, 'diagcomp',alpha));
L = ichol(A, struct('type','ict','droptol', 1e-1));
[x, iter7, res_vec7] = p_cg(A, b, tol, maxit, x0, L, L');
t7 = toc;

% threshold 1e-3
tic
% alpha = max(sum(abs(A),2)./diag(A))-2;
% L = ichol(A, struct('type','ict','droptol', 1e-1, 'diagcomp',alpha));
L = ichol(A, struct('type','ict','droptol', 1e-3));
[x, iter8, res_vec8] = p_cg(A, b, tol, maxit, x0, L, L');
t8 = toc;


disp('')
disp('implemented cg() vs p_cg():')
disp(['cg() time: ', num2str(t1), ' cg() iter: ', num2str(iter1)])
disp('')

disp('diagonal preconditioned : M = diag(A)')
disp(['p_cg() time: ', num2str(t2), ' p_cg() iter: ', num2str(iter2)])
disp('')

disp('block diagonal preconditioned:')
disp('block size = 5')
disp(['p_cg() time: ', num2str(t3), ' p_cg() iter: ', num2str(iter3)])
disp('')

disp('block size = 25')
disp(['p_cg() time: ', num2str(t4), ' p_cg() iter: ', num2str(iter4)])
disp('')

disp('block size = 100')
disp(['p_cg() time: ', num2str(t5), ' p_cg() iter: ', num2str(iter5)])
disp('')

disp('incomplete choleskey factorization preconditioned:')
disp(['p_cg() time: ', num2str(t6), ' p_cg() iter: ', num2str(iter6)])
disp('')

disp('incomplete choleskey factorization with threshold dropping preconditioned:')
disp('threshold 1e-1')
disp(['p_cg() time: ', num2str(t7), ' p_cg() iter: ', num2str(iter7)])
disp('')

disp('threshold 1e-3')
disp(['p_cg() time: ', num2str(t8), ' p_cg() iter: ', num2str(iter8)])
disp('')

legend1 = ['cg()'];
legend2 = ['p\_cg() M=diag(A)'];
legend3 = ['p\_cg() block size=5'];
legend4 = ['p\_cg() block size=25'];
legend5 = ['p\_cg() block size=100'];
legend6 = ['p\_cg() incomplete cf'];
legend7 = ['p\_cg() threshold 1e-1'];
legend8 = ['p\_cg() threshold 1e-3'];


figure()
hold on
semilogy(res_vec1);
semilogy(res_vec2);
semilogy(res_vec3);
semilogy(res_vec4);
semilogy(res_vec5);
semilogy(res_vec6);
semilogy(res_vec7);
semilogy(res_vec8);
legend (legend1, legend2, legend3, legend4, legend5, legend6, legend7, legend8);
title('implemented standard cg vs preconditioned p\_cg');
xlabel('Iteration');
ylabel('Residual');
hold off