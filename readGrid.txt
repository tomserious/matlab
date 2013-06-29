fidin=fopen('grid_per_hour126.txt');
countnum=fopen('count.txt','w'); 
fidout=fopen('mkmatlab.txt','w');                        % 新建MKMATLAB.txt文件用于输出            
i=0;
while ~feof(fidin)                                     % 文件指针 fid 未到达文件末尾    
    tline=fgetl(fidin);                                % 从文件中读取一行数据，并丢弃行末的换行符 
    if findstr(tline,'~')>0       % 查找 '~'是否存在     
       fprintf(countnum,'%d\n',i);%记下该时段内数据记录数
        i=0;
        continue% 跳过此行
    else
       fprintf(fidout,'%s\n',tline);                   % 当前行写入MKMATLAB.txt
       i=i+1;
       continue
    end 
end 
fprintf(countnum,'%d\n',i);%最后一行
fclose(fidout); 
fclose(countnum);
MK=importdata('MKMATLAB.txt');      % 从外部将文本或者数据文件如txt.dat导入到Matlab的workspace中 
MC=importdata('count.txt');

len=length(MK);
count=1;
for k=2:25
    %初始赋值
    for i=1:30
        for j=1:30
            A(i,j)=0;
        end
    end
    %遍历填充矩阵   
        for m=count:len
            for n=1:MC(k)
                grid=MK(m,1);
                if(grid>0)        %网格编号在研究区域内
                    row=fix(grid/30);%向0取整
                    row=row+1;%得到行号
                    column=rem(grid,30);%取余数
                    column=column+1;%得到列号
                    A(row,column)=MK(m,2);%时间赋值
                end
                m=m+1;
            end
            count=count+MC(k);break;
        end       
    x=1:30;y=1:30;
    path=strcat('abc',num2str(k),'.png');
    pcolor(x,y,A);colorbar;title(strcat(num2str(k-2),'~',num2str(k-1)));print(gcf,'-dpng',path);%输出为png格式
    %subplot(4,6,k-1);pcolor(x,y,A);%?????%shading interp;%image(A);
end

filename='face.gif';%要创建的gif名
for i=2:25    
    path=strcat('abc',num2str(i),'.png');
    Img=imread(path);  %读取图像
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

