function [C, label, J] = kmeans(I, k)
[m, n, p] = size(I);
%����άѹ����һά��ת������
X = reshape(double(I), m*n, p);
rng('default');
%��ʼ����������
C = X(randperm(m*n, k), :);
%��ʼ�����̶�tol
J_prev = inf; iter = 0; J = []; tol = 1e-2;
%% 
%�������
while true
    iter = iter + 1;
    dist = sum(X.^2, 2)*ones(1, k) + (sum(C.^2, 2)*ones(1, m*n))' - 2*X*C';
    [~, label] = min(dist, [], 2) ;
    for i = 1:k
       C(i, :) = mean(X(label == i , :));
    end
    %����Ŀ�꺯��
    J_cur = sum(sum((X - C(label, :)).^2, 2));
    J = [J, J_cur];
    fprintf('#iteration: %03d, objective function: %f\n', iter, J_cur);
    %�ж�Ŀ�꺯���仯�Ƿ��㹻С
    %F����Ϊ�ȹ�
    if norm(J_cur-J_prev, 'fro') < tol
        break;
    end
    J_prev = J_cur;
end
