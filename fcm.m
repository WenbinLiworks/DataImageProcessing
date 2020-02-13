function [C, dist, J] = fcm(X, k, b)
iter = 0;
[N, p] = size(X);
P = randn(N, k);
% sum 对行求和
P = P./(sum(P, 2)*ones(1, k)); % ones初始化一个 1*k 单元矩阵 
J_prev = inf; J = [];
%% 更新规则
while true
    iter = iter + 1;
    t = P.^b;
    % 计算模糊聚类中心
    C = (X'*t)'./(sum(t)'*ones(1, p));
    dist = sum(X.*X, 2)*ones(1, k) + (sum(C.*C, 2)*ones(1, N))'-2*X*C';
    % 归属矩阵的更新规则
    t2 = (1./dist).^(1/(b-1)); % 概率
    P = t2./(sum(t2, 2)*ones(1, k));
    % 计算目标函数
    J_cur = sum(sum((P.^b).*dist))/N;
    J = [J J_cur];
    % 判定是否超范围
    % 使用F范式规约
    if norm(J_cur-J_prev, 'fro') < 1e-3
        break;
    end
   fprintf('#iteration: %03d, objective function: %f\n', iter, J_cur);
   J_prev = J_cur; 
end