% �n���K���[�@�ɂ�銄�������i�T�C�Y�̈قȂ�ꍇ�j

function [T] = max_tr_h3(X)
    rows = size(X,2);
    cols = size(X,1);
    T = Hungarian3(X',zeros(rows,cols),cols,rows);
    T = sparse((reshape(T,rows,cols))');
end
