% lim_err = kron([1e-1, 1e-2, 1e-3, 1e-4],[9:-0.5:1]);
lim_err = 2 .^(-[0:12]);

infom = [];
line_number = [];
for address_width = 1:10
    line.address_width = address_width;
    for i = 1:length(lim_err)
        line.bit = i-1;
        line.lim = lim_err(i);
        [line.points, line.a, line.b,line.max_err ] = sin2line(lim_err(i), 2^address_width);
        line.number = length(line.a);
        infom=[infom, line];
    end
end

% figure();
% % semilogx(lim_err, line_number,'r+-');
% plot([0:16], line_number,'r+-');
% grid on;