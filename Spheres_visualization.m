% Comprehensive Gauss Law: 3D Spheres and 2D Field Graphs
clear; clc; close all;

% Create a taller figure window to fit the 2x2 grid comfortably
figure('Name', 'Gauss Law: 3D vs 2D', 'Position', [50, 50, 1000, 800]);

% --- Shared Geometry Variables ---
[X, Y, Z] = sphere(40);
R_main = 2; % Outer radius for both spheres
[phi, th] = meshgrid(linspace(pi/6, 5*pi/6, 5), linspace(0, 2*pi, 8));
xin = 1 * sin(phi).*cos(th); yin = 1 * sin(phi).*sin(th); zin = 1 * cos(phi);
xout = 3 * sin(phi).*cos(th); yout = 3 * sin(phi).*sin(th); zout = 3 * cos(phi);

% Radius vector for the 2D line plots (0 to 5)
r_line = linspace(0, 5, 300);

%% TOP LEFT: Solid Sphere 3D
subplot(2, 2, 1);
hold on; grid on; axis equal; title('3D: Solid Non-Conductor');
surf(R_main*X, R_main*Y, R_main*Z, 'FaceColor', 'r', 'EdgeColor', 'none', 'FaceAlpha', 0.2);
quiver3(xin, yin, zin, xin*0.5, yin*0.5, zin*0.5, 0, 'b', 'LineWidth', 1.5, 'MaxHeadSize', 0.5);
quiver3(xout, yout, zout, (xout/3)*0.8, (yout/3)*0.8, (zout/3)*0.8, 0, 'b', 'LineWidth', 1.5, 'MaxHeadSize', 0.5);
view(30, 20); camlight right; lighting gouraud;
xlim([-4 4]); ylim([-4 4]); zlim([-4 4]);

%% TOP RIGHT: Hollow Conductor 3D
subplot(2, 2, 2);
hold on; grid on; axis equal; title('3D: Hollow Conductor');
surf(1.5*X, 1.5*Y, 1.5*Z, 'FaceColor', [0.7 0.7 0.7], 'EdgeColor', 'none', 'FaceAlpha', 0.5);
surf(R_main*X, R_main*Y, R_main*Z, 'FaceColor', [0.4 0.4 0.4], 'EdgeColor', 'none', 'FaceAlpha', 0.3);
quiver3(xout, yout, zout, (xout/3)*0.8, (yout/3)*0.8, (zout/3)*0.8, 0, 'b', 'LineWidth', 1.5, 'MaxHeadSize', 0.5);
view(30, 20); camlight right; lighting gouraud;
xlim([-4 4]); ylim([-4 4]); zlim([-4 4]);

%% BOTTOM LEFT: Solid Sphere 2D Graph (E vs r)
subplot(2, 2, 3);
E_solid = zeros(size(r_line));
in = r_line <= R_main;
out = r_line > R_main;
E_solid(in) = 0.5 * r_line(in);          % Inside: E grows linearly
E_solid(out) = 4 ./ (r_line(out).^2);    % Outside: E decays as 1/r^2 

plot(r_line, E_solid, 'b', 'LineWidth', 2.5);
hold on; grid on;
xline(R_main, 'r--', 'Surface (r = 2)', 'LabelVerticalAlignment', 'bottom');
title('2D: Solid Sphere (E vs r)');
xlabel('Distance from center (r)'); ylabel('Electric Field (E)');
ylim([0, 1.5]);

%% BOTTOM RIGHT: Hollow Conductor 2D Graph (E vs r)
subplot(2, 2, 4);
E_hollow = zeros(size(r_line));
% Field is 0 inside cavity (r<1.5) and inside metal wall (1.5 <= r <= 2)
outside_metal = r_line > R_main;
E_hollow(outside_metal) = 4 ./ (r_line(outside_metal).^2);

plot(r_line, E_hollow, 'b', 'LineWidth', 2.5);
hold on; grid on;
xline(1.5, 'k--', 'Inner Wall', 'LabelVerticalAlignment', 'bottom');
xline(R_main, 'r--', 'Outer Wall', 'LabelVerticalAlignment', 'bottom');
title('2D: Hollow Conductor (E vs r)');
xlabel('Distance from center (r)'); ylabel('Electric Field (E)');
ylim([0, 1.5]);