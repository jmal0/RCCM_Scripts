clear; close all;

load static2.mat
dx = dx * 9.08 / 143.0;
dy = dy * 9.08 / 143.0;
dx_stat = dx - mean(dx);
dy_stat = dy - mean(dy);

load repeatability1.mat
dx = dx(6:end);
dy = dy(6:end);
dx_repeat = dx - mean(dx);
dy_repeat = dy - mean(dy);

figure;
hold on;
plot(dx_stat, dy_stat, '.k');
plot(dx_repeat, dy_repeat, '.g');
axis equal
xlabel('X offset (microns)', 'FontSize', 14);
ylabel('Y offset (microns)', 'FontSize', 14);
title('Actuator Repeatability Test', 'FontSize', 14);
legend('Without movement', 'With 15 mm move')
set(gca, 'FontSize', 14)