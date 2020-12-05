function varargout = Main(varargin)
% MAIN MATLAB code for Main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main

% Last Modified by GUIDE v2.5 12-May-2009 23:58:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Main_OpeningFcn, ...
    'gui_OutputFcn',  @Main_OutputFcn, ...
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


% --- Executes just before Main is made visible.
function Main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main (see VARARGIN)

% Choose default command line output for Main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Main_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
%----------------------��ͣ����-----------------------------
[filename,filepath]=uigetfile('.jpg','�ɼ���⳵��');% ֱ���Զ�����%
file=strcat(filepath,filename); %strcat�����������ַ�������filepath���ַ�����filename�����ӣ���·��/�ļ���
I=imread(file);
axes(handles.axes1)
imshow(I)
title('ԭͼ')
I1=rgb2gray(I);
I2=edge(I1,'roberts',0.15,'both');
se=[1;1;1];
I3=imerode(I2,se);
se=strel('rectangle',[25,25]);
I4=imclose(I3,se);
I5=bwareaopen(I4,2000);
[y,x,z]=size(I5);
myI=double(I5);
tic
white_y=zeros(y,1);
for i=1:y
    for j=1:x
        if(myI(i,j,1)==1)
            white_y(i,1)= white_y(i,1)+1;
        end
    end
end
[temp MaxY]=max(white_y);
PY1=MaxY;
while ((white_y(PY1,1)>=5)&&(PY1>1))
    PY1=PY1-1;
end
PY2=MaxY;
while ((white_y(PY2,1)>=5)&&(PY2<y))
    PY2=PY2+1;
end
IY=I(PY1:PY2,:,:);
white_x=zeros(1,x);
for j=1:x
    for i=PY1:PY2
        if(myI(i,j,1)==1)
            white_x(1,j)= white_x(1,j)+1;
        end
    end
end

PX1=1;
while ((white_x(1,PX1)<3)&&(PX1<x))
    PX1=PX1+1;
end
PX2=x;
while ((white_x(1,PX2)<3)&&(PX2>PX1))
    PX2=PX2-1;
end
PX1=PX1-2;
PX2=PX2+3;
dw=I(PY1:PY2-8,PX1:PX2,:);
axes(handles.axes2)
imshow(dw)
title('���ƶ�λ')
t=toc;  %ʶ��ʱ��
a=dw;  %��λ�ĳ���
b=rgb2gray(a);
g_max=double(max(max(b)));
g_min=double(min(min(b)));
T=round(g_max-(g_max-g_min)/3); % T Ϊ��ֵ������ֵ
[m,n]=size(b);
d=(double(b)>=T);  % d:��ֵͼ��

% �˲�
h=fspecial('average',3);
d=im2bw(round(filter2(h,d)));
axes(handles.axes3)
imshow(d)
title('���������ֵ��')


% ĳЩͼ����в���
% ���ͻ�ʴ
% ʹ��һ��3X3�������ν��Ԫ�ض���Դ�����ͼ���������
se=eye(2);
[m,n]=size(d);
if bwarea(d)/m/n>=0.365
    d=imerode(d,se);
elseif bwarea(d)/m/n<=0.235
    d=imdilate(d,se);
end

% Ѱ�����������ֵĿ飬�����ȴ���ĳ��ֵ������Ϊ�ÿ��������ַ���ɣ���Ҫ�ָ�
d=qiege(d);
[m,n]=size(d);
k1=1;k2=1;s=sum(d);j=1;
while j~=n
    while s(j)==0
        j=j+1;
    end
    k1=j;
    while s(j)~=0 && j<=n-1
        j=j+1;
    end
    k2=j-1;
    if k2-k1>=round(n/6.5)
        [val,num]=min(sum(d(:,[k1+5:k2-5])));
        d(:,k1+num+5)=0;  % �ָ�
    end
end
% ���и�
d=qiege(d);
% �и�� 7 ���ַ�
y1=10;y2=0.25;flag=0;word1=[];
while flag==0
    [m,n]=size(d);
    left=1;wide=0;
    while sum(d(:,wide+1))~=0
        wide=wide+1;
    end
    if wide<y1   % ��Ϊ��������
        d(:,[1:wide])=0;
        d=qiege(d);
    else
        temp=qiege(imcrop(d,[1 1 wide m]));
        [m,n]=size(temp);
        all=sum(sum(temp));
        two_thirds=sum(sum(temp([round(m/3):2*round(m/3)],:)));
        if two_thirds/all>y2
            flag=1;word1=temp;   % WORD 1
        end
        d(:,[1:wide])=0;d=qiege(d);
    end
end
% �ָ���ڶ����ַ�
[word2,d]=getword(d);
% �ָ���������ַ�
[word3,d]=getword(d);
% �ָ�����ĸ��ַ�
[word4,d]=getword(d);
% �ָ��������ַ�
[word5,d]=getword(d);
% �ָ���������ַ�
[word6,d]=getword(d);
% �ָ�����߸��ַ�
[word7,d]=getword(d);
[m,n]=size(word1);
%��һ����СΪ40*20
word1=imresize(word1,[40 20]);
word2=imresize(word2,[40 20]);
word3=imresize(word3,[40 20]);
word4=imresize(word4,[40 20]);
word5=imresize(word5,[40 20]);
word6=imresize(word6,[40 20]);
word7=imresize(word7,[40 20]);
imwrite(word1,'1.jpg');
imwrite(word2,'2.jpg');
imwrite(word3,'3.jpg');
imwrite(word4,'4.jpg');
imwrite(word5,'5.jpg');
imwrite(word6,'6.jpg');
imwrite(word7,'7.jpg');
axes(handles.axes4);imshow(word1)
axes(handles.axes5);imshow(word2)
axes(handles.axes6);imshow(word3)
axes(handles.axes7);imshow(word4)
axes(handles.axes8);imshow(word5)
axes(handles.axes9);imshow(word6)
axes(handles.axes10);imshow(word7)
liccode=char(['0':'9' 'A':'Z' '������³����ԥ����']);%�����弽ԥ���ɺ�����³������Ӷ���ʽ����¼���������ش�����
SubBw2=zeros(40,20);
l=1;
for I=1:7;
    ii=int2str(I);
    t=imread([ii,'.jpg']);
    SegBw2=imresize(t,[40 20],'nearest');
    SegBw2=double(SegBw2)>20;
    if l==1 %��һλ����ʶ��
        kmin=37;
        kmax=43;
    elseif l==2 %�ڶ�λ��ĸʶ��
        kmin=11;
        kmax=36;
    else l>=3   %����λ����ĸ������ʶ��
        kmin=1;
        kmax=36;
        
    end
    for k2=kmin:kmax
        fname=strcat('�ַ�ģ��\',liccode(k2),'.jpg');
        SamBw2=imread(fname);
        SamBw2=double(SamBw2)>1;
        for i=1:40
            for j=1:20
                SubBw2(i,j)=SegBw2(i,j)-SamBw2(i,j);
            end
        end
        %�൱������ͼ����õ�����ͼ
        Dmax=0;
        for k1=1:40;
            for l1=1:20
                if(SubBw2(k1,l1)>0 || SubBw2(k1,l1)<0)
                    Dmax=Dmax+1;
                end
            end
        end
        Error(k2)=Dmax;
    end
    Error1=Error(kmin:kmax);
    MinError=min(Error1);
    findc=find(Error1==MinError);
    Code(l*2-1)=liccode(findc+kmin-1);
    Code(l*2)=' ';
    l=l+1;
end
t=toc;
fid=fopen('Data_in.txt','a+');
fprintf(fid,'%s\r\n',Code,datestr(now));
Code
fclose(fid);

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
msgbox('ʶ��ķ������������ģ��һ���������ж�ʶ��ĳ����Ƿ��ǿ��ڳ��ƣ��Լ���¼ʱ��ͳ��ͣ�����ã�QQ1321814823')

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)

[filename,filepath]=uigetfile('.jpg','����һ����Ҫʶ��ĳ���ͼ��');% ֱ���Զ�����%
file=strcat(filepath,filename); %strcat�����������ַ�������filepath���ַ�����filename�����ӣ���·��/�ļ���

I=imread(file);
axes(handles.axes1)
imshow(I)
title('ԭͼ')
I1=rgb2gray(I);
I2=edge(I1,'roberts',0.15,'both');
se=[1;1;1];
I3=imerode(I2,se);
se=strel('rectangle',[25,25]);
I4=imclose(I3,se);
I5=bwareaopen(I4,2000);
[y,x,z]=size(I5);
myI=double(I5);
tic
white_y=zeros(y,1);
for i=1:y
    for j=1:x
        if(myI(i,j,1)==1)
            white_y(i,1)= white_y(i,1)+1;
        end
    end
end
[temp MaxY]=max(white_y);
PY1=MaxY;
while ((white_y(PY1,1)>=5)&&(PY1>1))
    PY1=PY1-1;
end
PY2=MaxY;
while ((white_y(PY2,1)>=5)&&(PY2<y))
    PY2=PY2+1;
end
IY=I(PY1:PY2,:,:);
white_x=zeros(1,x);
for j=1:x
    for i=PY1:PY2
        if(myI(i,j,1)==1)
            white_x(1,j)= white_x(1,j)+1;
        end
    end
end

PX1=1;
while ((white_x(1,PX1)<3)&&(PX1<x))
    PX1=PX1+1;
end
PX2=x;
while ((white_x(1,PX2)<3)&&(PX2>PX1))
    PX2=PX2-1;
end
PX1=PX1-2;
PX2=PX2+3;
dw=I(PY1:PY2-8,PX1:PX2,:);
axes(handles.axes2)
imshow(dw)
title('��λ�ĳ���')
t=toc;  %ʶ��ʱ��
a=dw;  %��λ�ĳ���
b=rgb2gray(a);
g_max=double(max(max(b)));
g_min=double(min(min(b)));
T=round(g_max-(g_max-g_min)/3); % T Ϊ��ֵ������ֵ
[m,n]=size(b);
d=(double(b)>=T);  % d:��ֵͼ��

% �˲�
h=fspecial('average',3);
d=im2bw(round(filter2(h,d)));
axes(handles.axes3)
imshow(d)
title('��λ���ƶ�ֵ������')

msgbox('����˼·������qiege��getword�Ӻ������и�ƺͷָ��ַ���������ģ��ƥ������ַ�ʶ�𣬵ó������QQ:1321814823����˼����')
return

% ĳЩͼ����в���
% ���ͻ�ʴ
% ʹ��һ��3X3�������ν��Ԫ�ض���Դ�����ͼ���������
se=eye(2);
[m,n]=size(d);
if bwarea(d)/m/n>=0.365
    d=imerode(d,se);
elseif bwarea(d)/m/n<=0.235
    d=imdilate(d,se);
end

% Ѱ�����������ֵĿ飬�����ȴ���ĳ��ֵ������Ϊ�ÿ��������ַ���ɣ���Ҫ�ָ�
d=qiege(d);
[m,n]=size(d);
k1=1;k2=1;s=sum(d);j=1;
while j~=n
    while s(j)==0
        j=j+1;
    end
    k1=j;
    while s(j)~=0 && j<=n-1
        j=j+1;
    end
    k2=j-1;
    if k2-k1>=round(n/6.5)
        [val,num]=min(sum(d(:,[k1+5:k2-5])));
        d(:,k1+num+5)=0;  % �ָ�
    end
end
% ���и�
d=qiege(d);
% �и�� 7 ���ַ�
y1=10;y2=0.25;flag=0;word1=[];
while flag==0
    [m,n]=size(d);
    left=1;wide=0;
    while sum(d(:,wide+1))~=0
        wide=wide+1;
    end
    if wide<y1   % ��Ϊ��������
        d(:,[1:wide])=0;
        d=qiege(d);
    else
        temp=qiege(imcrop(d,[1 1 wide m]));
        [m,n]=size(temp);
        all=sum(sum(temp));
        two_thirds=sum(sum(temp([round(m/3):2*round(m/3)],:)));
        if two_thirds/all>y2
            flag=1;word1=temp;   % WORD 1
        end
        d(:,[1:wide])=0;d=qiege(d);
    end
end
% �ָ���ڶ����ַ�
[word2,d]=getword(d);
% �ָ���������ַ�
[word3,d]=getword(d);
% �ָ�����ĸ��ַ�
[word4,d]=getword(d);
% �ָ��������ַ�
[word5,d]=getword(d);
% �ָ���������ַ�
[word6,d]=getword(d);
% �ָ�����߸��ַ�
[word7,d]=getword(d);
[m,n]=size(word1);
%��һ����СΪ40*20
word1=imresize(word1,[40 20]);
word2=imresize(word2,[40 20]);
word3=imresize(word3,[40 20]);
word4=imresize(word4,[40 20]);
word5=imresize(word5,[40 20]);
word6=imresize(word6,[40 20]);
word7=imresize(word7,[40 20]);
imwrite(word1,'1.jpg');
imwrite(word2,'2.jpg');
imwrite(word3,'3.jpg');
imwrite(word4,'4.jpg');
imwrite(word5,'5.jpg');
imwrite(word6,'6.jpg');
imwrite(word7,'7.jpg');
axes(handles.axes4);imshow(word1)
axes(handles.axes5);imshow(word2)
axes(handles.axes6);imshow(word3)
axes(handles.axes7);imshow(word4)
axes(handles.axes8);imshow(word5)
axes(handles.axes9);imshow(word6)
axes(handles.axes10);imshow(word7)

liccode=char(['0':'9' 'A':'Z' '�����弽ԥ���ɺ�����³������Ӷ���ʽ����¼���������ش�����']);%ȫ�����
SubBw2=zeros(40,20);
l=1;
for I=1:7;
    ii=int2str(I);
    t=imread([ii,'.jpg']);
    SegBw2=imresize(t,[40 20],'nearest');
    SegBw2=double(SegBw2)>20;
    if l==1 %��һλ����ʶ��
        kmin=37;
        kmax=43;
    elseif l==2 %�ڶ�λ��ĸʶ��
        kmin=11;
        kmax=36;
    else l>=3   %����λ����ĸ������ʶ��
        kmin=1;
        kmax=36;
        
    end
    for k2=kmin:kmax
        fname=strcat('�ַ�ģ��\',liccode(k2),'.jpg');
        SamBw2=imread(fname);
        SamBw2=double(SamBw2)>1;
        for i=1:40
            for j=1:20
                SubBw2(i,j)=SegBw2(i,j)-SamBw2(i,j);
            end
        end
        %�൱������ͼ����õ�����ͼ
        Dmax=0;
        for k1=1:40;
            for l1=1:20
                if(SubBw2(k1,l1)>0 || SubBw2(k1,l1)<0)
                    Dmax=Dmax+1;
                end
            end
        end
        Error(k2)=Dmax;
    end
    Error1=Error(kmin:kmax);
    MinError=min(Error1);
    findc=find(Error1==MinError);
    Code(l*2-1)=liccode(findc+kmin-1);
    Code(l*2)=' ';
    l=l+1;
end
t=toc;




% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
