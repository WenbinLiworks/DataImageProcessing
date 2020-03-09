function [C, label, J] = kmeans(I, k)
[m, n, p] = size(I);
%将二维压缩成一维，转换精度
X = reshape(double(I), m*n, p);
rng('default');
%初始化聚类中心
C = X(randperm(m*n, k), :);
%初始化容忍度tol
J_prev = inf; iter = 0; J = []; tol = 1e-2;
%% 
%更新语句
while true
    iter = iter + 1;
    dist = sum(X.^2, 2)*ones(1, k) + (sum(C.^2, 2)*ones(1, m*n))' - 2*X*C';
    [~, label] = min(dist, [], 2) ;
    for i = 1:k
       C(i, :) = mean(X(label == i , :));
    end
    %计算目标函数
    J_cur = sum(sum((X - C(label, :)).^2, 2));
    J = [J, J_cur];
    fprintf('#iteration: %03d, objective function: %f\n', iter, J_cur);
    %判断目标函数变化是否足够小
    %F范数为度归
    if norm(J_cur-J_prev, 'fro') < tol
        break;
    end
    J_prev = J_cur;
end

