function varargout = demo_sharath(varargin)
% DEMO_SHARATH MATLAB code for demo_sharath.fig
%      DEMO_SHARATH, by itself, creates a new DEMO_SHARATH or raises the existing
%      singleton*.
%
%      H = DEMO_SHARATH returns the handle to a new DEMO_SHARATH or the handle to
%      the existing singleton*.
%
%      DEMO_SHARATH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMO_SHARATH.M with the given input arguments.
%
%      DEMO_SHARATH('Property','Value',...) creates a new DEMO_SHARATH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before demo_sharath_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to demo_sharath_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help demo_sharath

% Last Modified by GUIDE v2.5 11-Nov-2014 11:34:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @demo_sharath_OpeningFcn, ...
                   'gui_OutputFcn',  @demo_sharath_OutputFcn, ...
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


% --- Executes just before demo_sharath is made visible.
function demo_sharath_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to demo_sharath (see VARARGIN)

% Choose default command line output for demo_sharath
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes demo_sharath wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = demo_sharath_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Radius = str2num(get(handles.edit1,'String'));     % Initial radius of snake ocntour
GVF_ITER = str2num(get(handles.edit2,'String'));   % Iterations for computing gvf field
Snake_ITER = str2num(get(handles.edit3,'String')); % Iterations for snake evolution
Alpha = str2num(get(handles.edit4,'String'));      % Elasticity factor
Beta = str2num(get(handles.edit5,'String'));       % Bending factor
Gamma = str2num(get(handles.edit6,'String'));      % Internal Energy term
Kappa = str2num(get(handles.edit7,'String'));      % External energy term

[I,map] = imread('packman.pgm');     % Input image
I=I(:,:,1);
I=double(I); 
I = 1 - I/255; 
axes(handles.axes1);                        % Output the image to GUI
image(((1-I)+1)*40); 
axis('square', 'off');colormap(gray(64));
[u,v] = compute_gvf(I, 0.2, GVF_ITER);      % Compute the gvf iteratively solving
                                            % the differential equations given in paper
v1 = u./(sqrt(u.*u+v.*v)); v2 = v./(sqrt(u.*u+v.*v)); 
t = 0:0.5:6.28;
x = 32 + Radius*cos(t);                     % Initialize the snake as a circle
y = 32 + Radius*sin(t);                     % Radius is given as input from GUI
[x,y] = Interp(x,y,3,1); 
     hold on
     x1 = x(:); y1 = y(:);
     plot([x1;x(1,1)],[y1;y(1,1)],'r');     % Plot the intial snake
     hold off 
     pause(0.5); 

for i=1:30,
      
      [x,y] = evolve(x,y,Alpha,Beta,Gamma,Kappa,v1,v2,Snake_ITER); % Evolve the snake iteratively solving
                                                                   % differential equations given in paper
      [x,y] = Interp(x,y,3,1); 
      hold on
      x1 = x(:); y1 = y(:);
      plot([x1;x(1,1)],[y1;y(1,1)],'r');    % Plot the snake after fixed number of iterations
      hold off 
      pause(0.5);
end
figure(1);
colormap(gray(64)); image(((1-I)+1)*40); axis('square', 'off');
     hold on
     x1 = x(:); y1 = y(:);
     plot([x1;x(1,1)],[y1;y(1,1)],'-.r*');  % Output the final result 
     hold off 
     pause(0.5);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Radius = str2num(get(handles.edit1,'String'));     % Initial radius of snake ocntour
GVF_ITER = str2num(get(handles.edit2,'String'));   % Iterations for computing gvf field
Snake_ITER = str2num(get(handles.edit3,'String')); % Iterations for snake evolution
Alpha = str2num(get(handles.edit4,'String'));      % Elasticity factor
Beta = str2num(get(handles.edit5,'String'));       % Bending factor
Gamma = str2num(get(handles.edit6,'String'));      % Internal Energy term
Kappa = str2num(get(handles.edit7,'String'));      % External energy term

[I,map] = imread('sarojini.png');     % Input image
I=I(:,:,1);
I=double(I); 
I = 1 - I/255; 
axes(handles.axes1);                        % Output the image to GUI
image(((1-I)+1)*40); 
axis('square', 'off');colormap(gray(64));
[u,v] = compute_gvf(I, 0.2, GVF_ITER);      % Compute the gvf iteratively solving
                                            % the differential equations given in paper
v1 = u./(sqrt(u.*u+v.*v)); v2 = v./(sqrt(u.*u+v.*v)); 
t = 0:0.5:6.28;
x = 32 + Radius*cos(t);                     % Initialize the snake as a circle
y = 32 + Radius*sin(t);                     % Radius is given as input from GUI
[x,y] = Interp(x,y,3,1); 
     hold on
     x1 = x(:); y1 = y(:);
     plot([x1;x(1,1)],[y1;y(1,1)],'r');     % Plot the intial snake
     hold off 
     pause(0.5); 

for i=1:30,
      
      [x,y] = evolve(x,y,Alpha,Beta,Gamma,Kappa,v1,v2,Snake_ITER); % Evolve the snake iteratively solving
                                                                   % differential equations given in paper
      [x,y] = Interp(x,y,3,1); 
      hold on
      x1 = x(:); y1 = y(:);
      plot([x1;x(1,1)],[y1;y(1,1)],'r');    % Plot the snake after fixed number of iterations
      hold off 
      pause(0.5);
end
figure(1);
colormap(gray(64)); image(((1-I)+1)*40); axis('square', 'off');
     hold on
     x1 = x(:); y1 = y(:);
     plot([x1;x(1,1)],[y1;y(1,1)],'-.r*');  % Output the final result 
     hold off 
     pause(0.5);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Radius = str2num(get(handles.edit1,'String'));     % Initial radius of snake ocntour
GVF_ITER = str2num(get(handles.edit2,'String'));   % Iterations for computing gvf field
Snake_ITER = str2num(get(handles.edit3,'String')); % Iterations for snake evolution
Alpha = str2num(get(handles.edit4,'String'));      % Elasticity factor
Beta = str2num(get(handles.edit5,'String'));       % Bending factor
Gamma = str2num(get(handles.edit6,'String'));      % Internal Energy term
Kappa = str2num(get(handles.edit7,'String'));      % External energy term

[I,map] = imread('r_shape.pgm');     % Input image
I=I(:,:,1);
I=double(I); 
I = 1 - I/255; 
axes(handles.axes1);                        % Output the image to GUI
image(((1-I)+1)*40); 
axis('square', 'off');colormap(gray(64));
[u,v] = compute_gvf(I, 0.2, GVF_ITER);      % Compute the gvf iteratively solving
                                            % the differential equations given in paper
v1 = u./(sqrt(u.*u+v.*v)); v2 = v./(sqrt(u.*u+v.*v)); 
t = 0:0.5:6.28;
x = 32 + Radius*cos(t);                     % Initialize the snake as a circle
y = 32 + Radius*sin(t);                     % Radius is given as input from GUI
[x,y] = Interp(x,y,3,1); 
     hold on
     x1 = x(:); y1 = y(:);
     plot([x1;x(1,1)],[y1;y(1,1)],'r');     % Plot the intial snake
     hold off 
     pause(0.5); 

for i=1:30,
      
      [x,y] = evolve(x,y,Alpha,Beta,Gamma,Kappa,v1,v2,Snake_ITER); % Evolve the snake iteratively solving
                                                                   % differential equations given in paper
      [x,y] = Interp(x,y,3,1); 
      hold on
      x1 = x(:); y1 = y(:);
      plot([x1;x(1,1)],[y1;y(1,1)],'r');    % Plot the snake after fixed number of iterations
      hold off 
      pause(0.5);
end
figure(1);
colormap(gray(64)); image(((1-I)+1)*40); axis('square', 'off');
     hold on
     x1 = x(:); y1 = y(:);
     plot([x1;x(1,1)],[y1;y(1,1)],'-.r*');  % Output the final result 
     hold off 
     pause(0.5);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Radius = str2num(get(handles.edit1,'String'));     % Initial radius of snake ocntour
GVF_ITER = str2num(get(handles.edit2,'String'));   % Iterations for computing gvf field
Snake_ITER = str2num(get(handles.edit3,'String')); % Iterations for snake evolution
Alpha = str2num(get(handles.edit4,'String'));      % Elasticity factor
Beta = str2num(get(handles.edit5,'String'));       % Bending factor
Gamma = str2num(get(handles.edit6,'String'));      % Internal Energy term
Kappa = str2num(get(handles.edit7,'String'));      % External energy term

[I,map] = imread('star_shape.pgm');  % Input image
I=I(:,:,1);
I=double(I); 
I = 1 - I/255; 
axes(handles.axes1);                        % Output the image to GUI
image(((1-I)+1)*40); 
axis('square', 'off');colormap(gray(64));
[u,v] = compute_gvf(I, 0.2, GVF_ITER);      % Compute the gvf iteratively solving
                                            % the differential equations given in paper
v1 = u./(sqrt(u.*u+v.*v)); v2 = v./(sqrt(u.*u+v.*v)); 
t = 0:0.5:6.28;
x = 32 + Radius*cos(t);                     % Initialize the snake as a circle
y = 32 + Radius*sin(t);                     % Radius is given as input from GUI
[x,y] = Interp(x,y,3,1); 
     hold on
     x1 = x(:); y1 = y(:);
     plot([x1;x(1,1)],[y1;y(1,1)],'r');     % Plot the intial snake
     hold off 
     pause(0.5); 

for i=1:30,
      
      [x,y] = evolve(x,y,Alpha,Beta,Gamma,Kappa,v1,v2,Snake_ITER); % Evolve the snake iteratively solving
                                                                   % differential equations given in paper
      [x,y] = Interp(x,y,3,1); 
      hold on
      x1 = x(:); y1 = y(:);
      plot([x1;x(1,1)],[y1;y(1,1)],'r');    % Plot the snake after fixed number of iterations
      hold off 
      pause(0.5);
end
figure(1);
colormap(gray(64)); image(((1-I)+1)*40); axis('square', 'off');
     hold on
     x1 = x(:); y1 = y(:);
     plot([x1;x(1,1)],[y1;y(1,1)],'-.r*');  % Output the final result 
     hold off 
     pause(0.5);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
