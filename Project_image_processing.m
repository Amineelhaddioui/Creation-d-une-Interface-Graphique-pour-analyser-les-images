function varargout = Project_image_processing(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Project_image_processing_OpeningFcn, ...
                   'gui_OutputFcn',  @Project_image_processing_OutputFcn, ...
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


% --- Executes just before Project_image_processing is made visible.
function Project_image_processing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Project_image_processing (see VARARGIN)

% Choose default command line output for Project_image_processing
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Project_image_processing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Project_image_processing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in upimage.
function upimage_Callback(hObject, eventdata, handles)

[filename,pathname]=uigetfile('*.jpg;*.fig;*.tif;*.jpeg','Select Image Data');

fullname=strcat(pathname,filename);
set(handles.edit1,'String',fullname);
imageread=imread(fullname);
axes(handles.axes1);
setappdata(0,'imageread',imageread);

imshow(imageread);





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


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
msgbox('Thank you for exit by');
pause(1);
close();
close();


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
data=getappdata(0,'imageread');
imshow(data);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in hist.
function hist_Callback(hObject, eventdata, handles)
data=getappdata(0,'imageread');
imgray=rgb2gray(data);
axes(handles.axes2);
imhist(imgray);


% --- Executes on button press in convulation.
function convulation_Callback(hObject, eventdata, handles)
im_rgb=getappdata(0,'imageread');

im_1=im2double(im_rgb);
p=11; n=2*p+1; % 3x3
H=ones(n,n)/n^2;
im_in=im_1;
[M, N]=size(im_in);
im_out_1=0*im_in;
for i=p+1:M-p
    for j=p+1:N-p
        im0=im_in(i-p:i+p, j-p:j+p); % nxn
        im1=im0.*H;
        im_out_1(i,j)=sum(sum(im1));
    end;
end;

imshow(im_out_1);

% --- Executes on button press in binary.
function binary_Callback(hObject, eventdata, handles)
imdata=getappdata(0,'imageread');
imBinary=im2bw(imdata);
axes(handles.axes2);
imshow(imBinary)
% --- Executes on button press in imageGray.
function imageGray_Callback(hObject, eventdata, handles)
imdata=getappdata(0,'imageread');
% im=im2double(imdata);
imgry = rgb2gray(imdata);
axes(handles.axes2);
imshow(imgry)

% --- Executes on button press in equalization.
function equalization_Callback(hObject, eventdata, handles)
imrd=getappdata(0,'imageread');
im=im2double(imrd);
imgry = rgb2gray(imrd);
imeq=histeq(imgry);
axes(handles.axes2);
imshow(imeq)
% --- Executes on button press in transformer_fourier.
function transformer_fourier_Callback(hObject, eventdata, handles)
rgb=getappdata(0,'imageread');
i1=rgb2gray(rgb);
f=fft2(i1);
fmag=log(1+abs(f));
sf=fftshift(f);
sfmag=log(1+abs(sf));
axes(handles.axes2);
imshow(fmag)
%centrer the low frequency and show the result
f=fft2(i1);
sf=fftshift(f);
sfmag=log(1+abs(sf));
imshow(sfmag,[])


% --- Executes on button press in addNoiseToImage.
function addNoiseToImage_Callback(hObject, eventdata, handles)
rgb=getappdata(0,'imageread');
imrgb=rgb2gray(rgb);
bruit=imnoise(imrgb,'salt & pepper');
axes(handles.axes2);
imshow(bruit)


% --- Executes on button press in lowPassFilter.
function lowPassFilter_Callback(hObject, eventdata, handles)
rgb=getappdata(0,'imageread');
imrgb=rgb2gray(rgb);
bruit=imnoise(imrgb,'salt & pepper');
fsp=fspecial('average',[7,7]);
fltr=filter2(fsp,bruit);
axes(handles.axes2);
imshow(fltr/255)

% --- Executes on selection change in type_filtrage.
function type_filtrage_Callback(hObject, eventdata, handles)
Input_image =getappdata(0,'imageread');
imrgb=rgb2gray(Input_image);
a=get(handles.type_filtrage,'value')
if(a==1)  
   imshow(Input_image)
elseif (a==2)
Noisy_image = imnoise(imrgb,'salt & pepper',0.03);
Smoothed_image = medfilt2(Noisy_image);
imshowpair(Noisy_image,Smoothed_image,'montage')   
else
Noisy_image = imnoise(imrgb,'salt & pepper',0.03);
h = fspecial('average', [3 3]);
Smoothed_image = filter2(h, imrgb);
axes(handles.axes2);
imshowpair(Noisy_image,Smoothed_image,'montage')
end


% --- Executes during object creation, after setting all properties.
function type_filtrage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to type_filtrage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in groupbuttonOA.
function groupbuttonOA_SelectionChangeFcn(hObject, eventdata, handles)
set(handles.groupbuttonOA,'enable','off');


% --- Executes on button press in gaussian_noise.
function gaussian_noise_Callback(hObject, eventdata, handles)
rgb=getappdata(0,'imageread');
imrgb=rgb2gray(rgb);
bruit=imnoise(imrgb,'gaussian');
axes(handles.axes2);
imshow(bruit)


% --------------------------------------------------------------------
function groupbuttonOA_ButtonDownFcn(hObject, eventdata, handles)


% --- Executes when selected object is changed in buttongroupOP.
function buttongroupOP_SelectionChangeFcn(hObject, eventdata, handles)


% --- Executes on button press in Sampling_image.
function Sampling_image_Callback(hObject, eventdata, handles)
 i_rgb=getappdata(0,'imageread');
 imrgb=rgb2gray(i_rgb);
 
 im_smp0=imresize(imrgb,0.75);
 im_smp1=imresize(imrgb,0.5);
 im_smp2=imresize(imrgb,0.25);
 im_smp3=imresize(imrgb,0.12);
 axes(handles.axes2);
%   display 
imshowpair(im_smp1,im_smp2,'montage')  
% --- Executes on button press in Quantization_image.
function Quantization_image_Callback(hObject, eventdata, handles)
i_rgb=getappdata(0,'imageread');

imrgb=rgb2gray(i_rgb);
 im_smp0=gray2ind(imrgb,2^7);
 im_smp1=gray2ind(imrgb,2^5);
  im_smp2=gray2ind(imrgb,2^3);
   im_smp3=gray2ind(imrgb,2^1);
%   display 
 axes(handles.axes2);
imshowpair(im_smp1,im_smp3,'montage')  
  
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


% --- Executes when groupbuttonOA is resized.
function groupbuttonOA_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to groupbuttonOA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in MethodSegmentation.
function MethodSegmentation_Callback(hObject, eventdata, handles)
 i_rgb=getappdata(0,'imageread');
 a=get(handles.MethodSegmentation,'value')
 imgry=rgb2gray(i_rgb);
 axes(handles.axes2);
 if(a==1)
      imshow(i_rgb)   
 elseif(a==2)
 im_thr=graythresh(imgry);
 im_bw=im2bw(imgry,im_thr);
 imshow(im_bw)
 else
  imedge=edge(imgry,'canny');
  imshow(imedge)
 end
% --- Executes during object creation, after setting all properties.
function MethodSegmentation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MethodSegmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
