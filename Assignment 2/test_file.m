% #! /snap/bin/octave -qf

rand("state",0) % set seed

Aint = randi([-5,5], 5);
A = tril(rand(5));
B = rand(500,500);

cond(Aint,1)
cond(A,1)
cond(B,1)
disp("\n")

condest(Aint)
condest(A)
condest(B)
disp("\n")

est_cond(Aint)
est_cond(A)
est_cond(B)
