%{
        Ball bouncing program
%}

% I am buillding a simple ball bouncing simulation with gravity


% After you a script in matlap we have to make sure that the memory is in
% clean state 

clear;
close all;
clc;

% Now i am building the physics in the system

g = 9.8; % in meters persecond
e = 0.8; % this is the value of restituion
deta_time = 0.001; %this is the time step

% now setting up the sim size

xlim([0 1]) % one meter horizontal span 
ylim([0 2]) % one meter vertical span
axis equal
grid on

% ball properties

ball.r = 0.05; %radius in meters
ball.m = 0.2; % mass in kg
ball.pos = [0, 1.5]; %from the xy axis
ball.e = 0.8; 

% --- Figure / world setup ---
Lx = 2;              % world width (m)
Ly = 2;              % world height (m)

figure('Color','b');
ax = axes; hold(ax,'on'); grid(ax,'on');
xlim(ax,[0 Lx]); ylim(ax,[0 Ly]);
axis(ax,'equal');

title(ax,'Bouncing Ball');
xlabel(ax,'x (m)'); ylabel(ax,'y (m)');

% ground line
plot(ax,[0 Lx],[0 0],'k','LineWidth',2);

% (optional) smoother animation
set(gcf,'DoubleBuffer','on');

% Main simulation loop
t = 0;
t_end = 10;

fig = gcf; % this means that get current system
ax = gca; % this mean that get current axes

% --- SIM/STATE INITIALIZATION (required) ---
dt = deta_time;      % use your time step variable consistently
r  = ball.r;
e  = ball.e;

width  = Lx;
height = Ly;

x = ball.pos(1);
y = ball.pos(2);

% initial velocities (you can change these)
vx = 0.5;     % m/s
vy = 0.0;     % m/s

ballHandle = rectangle(ax, ...
    'Position', [x-r, y-r, 2*r, 2*r], ...
    'Curvature', [1 1], ...
    'FaceColor', 'w', ...
    'EdgeColor', 'k');

% Loop until user closes the window or specified time
while ishandle(fig) && t < t_end

    % --- PHYSICS UPDATE ---
    % Update velocity with gravity (only affects y-component)
    vy = vy - g*dt;

    % Update position based on velocity
    x = x + vx*dt;
    y = y + vy*dt;

    % --- COLLISION DETECTION ---
    % Check floor collision (y <= radius)
    if y <= r
        y  = r;
        vy = -e*vy;
    end

    % Check ceiling collision (y >= height - radius)
    if y >= height - r
        y  = height - r;
        vy = -e*vy;
    end

    % Check left wall collision (x <= radius)
    if x <= r
        x  = r;
        vx = -e*vx;
    end

    % Check right wall collision (x >= width - radius)
    if x >= width - r
        x  = width - r;
        vx = -e*vx;
    end

    % --- VISUALIZATION ---
    % Clear previous frame (not needed if we update the handle)
    % cla(ax)

    % Draw/update the ball using rectangle function
    % rectangle('Position', [x-r, y-r, 2*r, 2*r], 'Curvature', [1,1], 'FaceColor', color)
    set(ballHandle, 'Position', [x-r, y-r, 2*r, 2*r]);

    % Update the display
    drawnow limitrate

    % Control animation speed
    pause(dt);

    t = t + dt;
end

% End simultion
disp("End simulation");
