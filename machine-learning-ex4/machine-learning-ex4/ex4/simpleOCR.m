function varargout = simpleOCR(varargin)
% SIMPLEOCR MATLAB code for simpleOCR.fig
%      SIMPLEOCR, by itself, creates a new SIMPLEOCR or raises the existing
%      singleton*.
%
%      H = SIMPLEOCR returns the handle to a new SIMPLEOCR or the handle to
%      the existing singleton*.
%
%      SIMPLEOCR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMPLEOCR.M with the given input arguments.
%
%      SIMPLEOCR('Property','Value',...) creates a new SIMPLEOCR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before simpleOCR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to simpleOCR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help simpleOCR

% Last Modified by GUIDE v2.5 25-Jan-2017 12:40:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @simpleOCR_OpeningFcn, ...
                   'gui_OutputFcn',  @simpleOCR_OutputFcn, ...
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

        
% --- Executes just before simpleOCR is made visible.
function simpleOCR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to simpleOCR (see VARARGIN)

% Choose default command line output for simpleOCR
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes simpleOCR wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = simpleOCR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
global vid;
global Theta1;
global Theta2;
load('paraNNOCR.mat');
handles.vid = videoinput('winvideo', 1, 'YUY2_640x480');
guidata(hObject, handles);
axes(handles.axes1);
%triggerconfig(handles.vid, 'manual');
%handles.vid.FramesPerTrigger = 1;
% output would image in RGB color space
vid.ReturnedColorspace = 'rgb';
% tell matlab to start the webcam on user request, not automatically
%triggerconfig(handles.vid, 'manual');
% we need this to know the image height and width
vidRes = get(handles.vid, 'VideoResolution');
% image width
imWidth = vidRes(1);
% image height
imHeight = vidRes(2);
% number of bands of our image (should be 3 because it's RGB)
nBands = get(handles.vid, 'NumberOfBands');
% create an empty image container and show it on axPreview
hImage = image(zeros(imHeight, imWidth, nBands), 'parent', handles.axes1);
hold on;
%[x,y] = ginput(2);
global cx;
global cy;
cx = imWidth/2;
cx1=cx;
cy = imHeight/2;
cy1=cy;
line([cx1-100;cx1-100;cx1-100+50],[cy1-100+50;cy1-100;cy1-100],'Color','g','Linewidth',3);
line([cx1+100;cx1+100;cx1+100-50],[cy1-100+50;cy1-100;cy1-100],'Color','g','Linewidth',3);
line([cx1+100;cx1+100;cx1+100-50],[cy1+100-50;cy1+100;cy1+100],'Color','g','Linewidth',3);
line([cx1-100;cx1-100;cx1-100+50],[cy1+100-50;cy1+100;cy1+100],'Color','g','Linewidth',3);
% begin the webcam preview

preview(handles.vid,hImage);


% Get default command line output from handles structure



% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global start;
global cx;
global cy;
start = true;
global Theta1;
global Theta2;

while (start==true)
    
handles.vid.ReturnedColorspace = 'rgb';
snapshot = getsnapshot(handles.vid);
s = (snapshot);
s_cut = s(cy-100:cy+100-1,cx-100:cx+100-1,:);
sre =imresize(s_cut,0.1);
sre = rgb2gray(sre);
[ir,ic]=size(sre);
xin = reshape(sre,[1,ir*ic]);

pred = predict(Theta1,Theta2,xin);

%figure(1);
%subplot(1,2,1);
%imshow(s_cut);
%subplot(1,2,2);
%imshow();

value=pred;
set(handles.number, 'String', num2str(value));
end

% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global start;
start = stop;
