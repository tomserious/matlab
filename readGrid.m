fidin=fopen('grid_per_hour126.txt');
countnum=fopen('count.txt','w'); 
fidout=fopen('mkmatlab.txt','w');                        % �½�MKMATLAB.txt�ļ��������            
i=0;
while ~feof(fidin)                                     % �ļ�ָ�� fid δ�����ļ�ĩβ    
    tline=fgetl(fidin);                                % ���ļ��ж�ȡһ�����ݣ���������ĩ�Ļ��з� 
    if findstr(tline,'~')>0       % ���� '~'�Ƿ����     
       fprintf(countnum,'%d\n',i);%���¸�ʱ�������ݼ�¼��
        i=0;
        continue% ��������
    else
       fprintf(fidout,'%s\n',tline);                   % ��ǰ��д��MKMATLAB.txt
       i=i+1;
       continue
    end 
end 
fprintf(countnum,'%d\n',i);%���һ��
fclose(fidout); 
fclose(countnum);
MK=importdata('MKMATLAB.txt');      % ���ⲿ���ı����������ļ���txt.dat���뵽Matlab��workspace�� 
MC=importdata('count.txt');

len=length(MK);
count=1;
for k=2:25
    %��ʼ��ֵ
    for i=1:30
        for j=1:30
            A(i,j)=0;
        end
    end
    %����������   
        for m=count:len
            for n=1:MC(k)
                grid=MK(m,1);
                if(grid>0)        %���������о�������
                    row=fix(grid/30);%��0ȡ��
                    row=row+1;%�õ��к�
                    column=rem(grid,30);%ȡ����
                    column=column+1;%�õ��к�
                    A(row,column)=MK(m,2);%ʱ�丳ֵ
                end
                m=m+1;
            end
            count=count+MC(k);break;
        end       
    x=1:30;y=1:30;
    path=strcat('abc',num2str(k),'.png');
    pcolor(x,y,A);colorbar;title(strcat(num2str(k-2),'~',num2str(k-1)));print(gcf,'-dpng',path);%���Ϊpng��ʽ
    %subplot(4,6,k-1);pcolor(x,y,A);%?????%shading interp;%image(A);
end

filename='face.gif';%Ҫ������gif��
for i=2:25    
    path=strcat('abc',num2str(i),'.png');
    Img=imread(path);  %��ȡͼ��
    imshow(Img);  
    frame=getframe(gcf);  
    im=frame2im(frame);%??gif????????index????  
    [I,map]=rgb2ind(im,256);  
    if i == 2;
        imwrite(I,map,filename,'gif', 'DelayTime',3,'Loopcount',inf);
        else
        imwrite(I,map,filename,'gif','DelayTime',3,'WriteMode','append');
    end
    %imwrite(I,map,'face.gif','gif','DelayTime',0.1,'WriteMode','append','loopcount',inf);  
  
end

