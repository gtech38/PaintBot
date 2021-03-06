%**************************************************************************
% Name			: Nicholas Warner
% Date			: 28 February 2016
% Subject		: CSCE 452
% Assignment	: Project 1
% Updated		: 1 March 2016
% Description	: A 3 Link Planar Robotic Arm that Paints - Paintbot
%**************************************************************************

%Modified on Sublime

function varargout = paintbot(varargin)
% PAINTBOT MATLAB code for paintbot.fig
%      PAINTBOT, by itself, creates a new PAINTBOT or raises the existing
%      singleton*.
%
%      H = PAINTBOT returns the handle to a new PAINTBOT or the handle to
%      the existing singleton*.
%
%      PAINTBOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PAINTBOT.M with the given input arguments.
%
%      PAINTBOT('Property','Value',...) creates a new PAINTBOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before paintbot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to paintbot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help paintbot

% Last Modified by GUIDE v2.5 22-Mar-2016 16:46:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @paintbot_OpeningFcn, ...
                   'gui_OutputFcn',  @paintbot_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

function [R] = rotateRz(theta,m)
theta = (theta*pi)/180;
Rz = [cos(theta),-sin(theta),0,0;...
        sin(theta),cos(theta),0,0;...
        0,0,1,0;...
        0,0,0,1];
R = Rz * m;

function [R] = rotateRx(theta,m)
theta = (theta*pi)/180;
Rx = [1,0,0,0;...
        0,cos(theta),-sin(theta),0;...
        0,sin(theta),cos(theta),0;...
        0,0,0,1];
R = Rx * m;

function [R] = rotateRy(theta,m)
theta = (theta*pi)/180;
Ry = [cos(theta),0,sin(theta),0;...
        0,1,0,0;...
        -sin(theta),0,cos(theta),0;...
        0,0,0,1];
R = Ry * m;

function [R] = translateX(a,m)
Tx = [1,0,0,a;...
        0,1,0,0;...
        0,0,1,0;...
        0,0,0,1];
R = Tx * m;

function [R] = translateZ(d,m)
Tx = [1,0,0,0;...
        0,1,0,0;...
        0,0,1,d;...
        0,0,0,1];
R = Tz * m;

% function [R] = move01(theta,a,m)
% theta = (theta*pi)/180;
% A = [cos(theta),-sin(theta),0,a*cos(theta);...
%         sin(theta),cos(theta),0,a*sin(theta);...
%         0,0,1,0;...
%         0,0,0,1];
% R = A * m;
% disp(R);

% function [R] = move02(theta1,theta2,a1,a2,m)
% delta = (delta*pi)/180;
% theta2 = (theta2*pi)/180;
% A1 = [cos(theta1),-sin(theta1),0,a1*cos(theta1);...
%         sin(theta1),cos(theta1),0,a1*sin(theta1);...
%         0,0,1,0;...
%         0,0,0,1];
% A2 = [cos(theta2),-sin(theta2),0,a2*cos(theta2);...
%         sin(theta2),cos(theta2),0,a2*sin(theta2);...
%         0,0,1,0;...
%         0,0,0,1];
% R = (A1 * A2) * m;

% function [R] = move03(delta,theta2,theta3,a1,a2,a3,m)
% delta = (delta*pi)/180;
% theta2 = (theta2*pi)/180;
% theta3 = (theta3*pi)/180;
% A1 = [cos(theta1),-sin(theta1),0,a1*cos(theta1);...
%         sin(theta1),cos(theta1),0,a1*sin(theta1);...
%         0,0,1,0;...
%         0,0,0,1];
% A2 = [cos(theta2),-sin(theta2),0,a2*cos(theta2);...
%         sin(theta2),cos(theta2),0,a2*sin(theta2);...
%         0,0,1,0;...
%         0,0,0,1];
% A3 = [cos(theta3),-sin(theta3),0,a3*cos(theta3);...
%         sin(theta3),cos(theta3),0,a3*sin(theta3);...
%         0,0,1,0;...
%         0,0,0,1];
% R = ((A1 * A2) * A3) * m;

function [R] = move01(delta,a,m)
global a1;
a1(3) = delta;
A = [1, 0, 0, a;...
    0, 0, 1, 0;...
    0, -1, 0, delta;...
    0, 0, 0, 1];
m(3) = delta;
R = A * m;

function [R] = move02(delta,theta2,a1,a2,m)
theta2 = (theta2*pi)/180;
A1 = [1, 0, 0, a1;...
    0, 0, 1, 0;...
    0, -1, 0, delta;...
    0, 0, 0, 1];
A2 = [cos(theta2),-sin(theta2),0,a2*cos(theta2);...
        sin(theta2),cos(theta2),0,a2*sin(theta2);...
        0,0,1,0;...
        0,0,0,1];
R = (A1 * A2) * m;

function [R] = move03(delta,theta2,theta3,a1,a2,a3,m)
theta2 = (theta2*pi)/180;
theta3 = (theta3*pi)/180;
A1 = [1, 0, 0, a1;...
    0, 0, 1, 0;...
    0, -1, 0, delta;...
    0, 0, 0, 1];
A2 = [cos(theta2),-sin(theta2),0,a2*cos(theta2);...
        sin(theta2),cos(theta2),0,a2*sin(theta2);...
        0,0,1,0;...
        0,0,0,1];
A3 = [cos(theta3),-sin(theta3),0,a3*cos(theta3);...
        sin(theta3),cos(theta3),0,a3*sin(theta3);...
        0,0,1,0;...
        0,0,0,1];
R = ((A1 * A2) * A3) * m;

% --- Executes just before paintbot is made visible.
function paintbot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to paintbot (see VARARGIN)
global delta;
global theta2;
global theta3;
global line1;
global line2;
global line3;
global a1;
global a2;
global a3;
global a4;

delta = 0;
theta2 = 360-45;
theta3 = 45;
a1 = [0;0;0+delta;1];
temp = move01(delta,3,a1);

a2(1) = temp(1);
a2(2) = temp(2);
a2(3) = temp(3);
a2(4) = 1;
temp = move02(delta,theta2,3,2,a1);

a3(1) = temp(1);
a3(2) = temp(2);
a3(3) = temp(3);
a3(4) = 1;
temp = move03(delta,theta2,theta3,3,2,1.5,a1);

a4(1) = temp(1);
a4(2) = temp(2);
a4(3) = temp(3);
a4(4) = 1;

line1 = line([a1(3) a2(3)],[a1(1) a2(1)],'LineWidth',15,'Color',[1 0 0]);   %red
line2 = line([a2(3) a3(3)],[a2(1) a3(1)],'LineWidth',15,'Color',[0 1 0]);   %green
line3 = line([a3(3) a4(3)],[a3(1) a4(1)],'LineWidth',15,'Color',[0 0 1]);   %blue

% Choose default command line output for paintbot
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes paintbot wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = paintbot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in oneright.
function oneright_Callback(hObject, eventdata, handles)
% hObject    handle to oneright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global toggle;
global brush;
global delta;
global theta2;
global theta3;
global line1;
global line2;
global line3;
global a1;
global a2;
global a3;
global a4;

delta = delta + (1/36);

temp = move01(delta,3,a1);

a2(1) = temp(1);
a2(2) = temp(2);
a2(3) = temp(3);
a2(4) = 1;
temp = move02(delta,theta2,3,2,a1);

a3(1) = temp(1);
a3(2) = temp(2);
a3(3) = temp(3);
a3(4) = 1;
temp = move03(delta,theta2,theta3,3,2,1.5,a1);

a4(1) = temp(1);
a4(2) = temp(2);
a4(3) = temp(3);

delete(line1);
delete(line2);
delete(line3);
line1 = line([a1(3) a2(3)],[a1(1) a2(1)],'LineWidth',15,'Color',[1 0 0]);   %red
line2 = line([a2(3) a3(3)],[a2(1) a3(1)],'LineWidth',15,'Color',[0 1 0]);   %green
line3 = line([a3(3) a4(3)],[a3(1) a4(1)],'LineWidth',15,'Color',[0 0 1]);   %blue

if toggle == 1
    h = rectangle('Position',[a4(3) a4(1) brush brush],'Curvature',[1 1],'FaceColor',[0 0 0]);
end

% --- Executes on button press in oneleft.
function oneleft_Callback(hObject, eventdata, handles)
% hObject    handle to oneleft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global toggle;
global brush;
global delta;
global theta2;
global theta3;
global line1;
global line2;
global line3;
global a1;
global a2;
global a3;
global a4;

delta = delta - (1/36);

temp = move01(delta,3,a1);

a2(1) = temp(1);
a2(2) = temp(2);
a2(3) = temp(3);
a2(4) = 1;
temp = move02(delta,theta2,3,2,a1);

a3(1) = temp(1);
a3(2) = temp(2);
a3(3) = temp(3);
a3(4) = 1;
temp = move03(delta,theta2,theta3,3,2,1.5,a1);

a4(1) = temp(1);
a4(2) = temp(2);
a4(3) = temp(3);

delete(line1);
delete(line2);
delete(line3);
line1 = line([a1(3) a2(3)],[a1(1) a2(1)],'LineWidth',15,'Color',[1 0 0]);   %red
line2 = line([a2(3) a3(3)],[a2(1) a3(1)],'LineWidth',15,'Color',[0 1 0]);   %green
line3 = line([a3(3) a4(3)],[a3(1) a4(1)],'LineWidth',15,'Color',[0 0 1]);   %blue

if toggle == 1
    h = rectangle('Position',[a4(3) a4(1) brush brush],'Curvature',[1 1],'FaceColor',[0 0 0]);
end

% --- Executes on button press in twoCounterclock.
function twoCounterclock_Callback(hObject, eventdata, handles)
% hObject    handle to twoCounterclock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global toggle;
global brush;
global delta;
global theta2;
global theta3;
global line1;
global line2;
global line3;
global a1;
global a2;
global a3;
global a4;

if theta2 == 360
    theta2 = 0;
else
    theta2 = theta2 + 1;
end

temp = move02(delta,theta2,3,2,a1);

a3(1) = temp(1);
a3(2) = temp(2);
a3(3) = temp(3);
a3(4) = 1;
temp = move03(delta,theta2,theta3,3,2,1.5,a1);

a4(1) = temp(1);
a4(2) = temp(2);
a4(3) = temp(3);

delete(line2);
delete(line3);
line2 = line([a2(3) a3(3)],[a2(1) a3(1)],'LineWidth',15,'Color',[0 1 0]);   %green
line3 = line([a3(3) a4(3)],[a3(1) a4(1)],'LineWidth',15,'Color',[0 0 1]);   %blue

if toggle == 1
    h = rectangle('Position',[a4(3) a4(1) brush brush],'Curvature',[1 1],'FaceColor',[0 0 0]);
end

% --- Executes on button press in twoCounterclock.
function twoClockwise_Callback(hObject, eventdata, handles)
% hObject    handle to twoCounterclock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global toggle;
global brush;
global delta;
global theta2;
global theta3;
global line1;
global line2;
global line3;
global a1;
global a2;
global a3;
global a4;

if theta2 == 0
    theta2 = 360;
else
    theta2 = theta2 - 1;
end

temp = move02(delta,theta2,3,2,a1);

a3(1) = temp(1);
a3(2) = temp(2);
a3(3) = temp(3);
a3(4) = 1;
temp = move03(delta,theta2,theta3,3,2,1.5,a1);

a4(1) = temp(1);
a4(2) = temp(2);
a4(3) = temp(3);

delete(line2);
delete(line3);
line2 = line([a2(3) a3(3)],[a2(1) a3(1)],'LineWidth',15,'Color',[0 1 0]);   %green
line3 = line([a3(3) a4(3)],[a3(1) a4(1)],'LineWidth',15,'Color',[0 0 1]);   %blue

if toggle == 1
    h = rectangle('Position',[a4(3) a4(1) brush brush],'Curvature',[1 1],'FaceColor',[0 0 0]);
end

% --- Executes on button press in threeCounter.
function threeCounter_Callback(hObject, eventdata, handles)
% hObject    handle to threeCounter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global toggle;
global brush;
global delta;
global theta2;
global theta3;
global line1;
global line2;
global line3;
global a1;
global a2;
global a3;
global a4;

if theta3 == 360
    theta3 = 0;
else
    theta3 = theta3 + 1;
end

temp = move03(delta,theta2,theta3,3,2,1.5,a1);

a4(1) = temp(1);
a4(2) = temp(2);
a4(3) = temp(3);

delete(line3);
line3 = line([a3(3) a4(3)],[a3(1) a4(1)],'LineWidth',15,'Color',[0 0 1]);   %blue

if toggle == 1
    h = rectangle('Position',[a4(3) a4(1) brush brush],'Curvature',[1 1],'FaceColor',[0 0 0]);
end

% --- Executes on button press in threeCounter.
function threeClockwise_Callback(hObject, eventdata, handles)
% hObject    handle to threeCounter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global toggle;
global brush;
global delta;
global theta2;
global theta3;
global line1;
global line2;
global line3;
global a1;
global a2;
global a3;
global a4;

if theta3 == 0
    theta3 = 360;
else
    theta3 = theta3 - 1;
end

temp = move03(delta,theta2,theta3,3,2,1.5,a1);

a4(1) = temp(1);
a4(2) = temp(2);
a4(3) = temp(3);

delete(line3);
line3 = line([a3(3) a4(3)],[a3(1) a4(1)],'LineWidth',15,'Color',[0 0 1]);   %blue

if toggle == 1
    h = rectangle('Position',[a4(3) a4(1) brush brush],'Curvature',[1 1],'FaceColor',[0 0 0]);
end

% --- Executes on button press in paint.
function paint_Callback(hObject, eventdata, handles)
% hObject    handle to paint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of paint
global toggle;
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    toggle = true;
elseif button_state == get(hObject,'Min')
    toggle = false;
end

% --- Executes on button press in init.
function init_Callback(hObject, eventdata, handles)
% hObject    handle to init (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



%NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNND
%NNNNNNNNNNNNNNNN                                               NNNNNNNNNNNNNNNND
%NNNNNNNNNNNNNNNN   Nicholas Warner * warnern@email.tamu.edu    NNNNNNNNNNNNNNNND
%NNNNNNNNNNNNNNNN                                               NNNNNNNNNNNNNNNND
%NNNNNNNNNNNNNNNN         NNNNNNNNNN         NNNNNNNNNN         NNNNNNNNNNNNNNNND
%NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN         NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNND
%NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN         NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNND
%NNNNNNNNNNNNNNNN         NNNNNNNNNN         NNN       DNNNNNNN       NNNNNNNNNND
%NNNNNNNNNNNNNNNNDO      NNNNNNNNNNN         NNNM$       NNNN=       NDNNNNNNNNND
%NNNNNNNNNNNNNNNNN        NNNNNNNNNN         NNNNO       ZNNN        NNNNNNNNNNND
%NNNNNNNNNNNNNNNN          NNNNNNNNN         NNNNO        DD         NNNNNNNNNNND
%NNNNNNNNNNNNNNN7    NN    DNNNNNNNN         NNNNO                   NNNNNNNNNNND
%NNNNNNNNNNNNNNN    7NN:    NNNNNNNN         NNNNO    N        N     NNNNNNNNNNND
%NNNNNNNNNNNNND              NNNNNNN         NNNNO    NN      NN     NNNNNNNNNNND
%NNNNNNNNNNNNN:              $NNNNNN         NNNNO    NNN     NN     NNNNNNNNNNND
%NNNNNNNNNNNND    NNNNNNN7    NNNNNN         NNNNO    NNN    NNN     NNNNNNNNNNND
%NNNNNNNNNDDN     NNNNNNNN     DDNNN         NNND$    NDNN  NNND     DNNNNNNNNNND
%NNNNNNNNNN        NNNNNN        NNN         NNN       ZNNNNNNN       NNNNNNNNNND
%NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN         NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNND
%NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNDNNNN         NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNND
%NNNNNNNNNNNNNNNNNNNNNNNNNNNNNN                   NNNNNNNNNNNNNNNNNNNNNNNNNNNNNND
%NNNNNNNNNNNNNNNNNNNNNNNNNNNNNN                   NNNNNNNNNNNNNNNNNNNNNNNNNNNNNND
%NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNND


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over paint.
function paint_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to paint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global brush;

brush = get(hObject,'Value')
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
