% Tangent Space Relaxation (TSR) method

T = eye(n_data);
% R = R0;
R = eye(dim); % initial orthogonal matrix
F = zeros(1,10000); % value of object function
alpha = [1/2,1/5,1/10,1/50,0,0.3,1]; 
sub_alpha = 3; % parameter alpha
skew = zeros(n_data,n_data);
temp = T;
counter = 0;

for iteration=1:100
    T = max_tr_h(P' * R * Q);
    skew = max_tr_skew(T * P' * R * Q);
    F(2*iteration-1) = trace(T * P' * R * Q);    
    
    [U S V] = svd(Q * (T + alpha(sub_alpha) * skew * T) * P');
    R = V * U';
    F(2*iteration) = trace(T * P' * R * Q);
    
    if(T == temp)
        counter = counter +1;
    else
        counter = 0;
    end
    if(counter == 10)
        break;
    end
    temp = T;
end

[U S V] = svd(Q * T * P');
R = V * U';

maxF = trace(S);
