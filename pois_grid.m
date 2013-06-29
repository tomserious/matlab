fidin=fopen('poicounters.txt');
fidout=fopen('mkmatlab.txt','w');                        % 新建MKMATLAB.txt文件用于输出            
i=0;
while ~feof(fidin)                                     % 文件指针 fid 未到达文件末尾    
    tline=fgetl(fidin);                               % 从文件中读取一行数据，并丢弃行末的换行符 
    fprintf(fidout,'%s\n',tline);                   % 当前行写入MKMATLAB.txt    
end 
fclose(fidout); 
MK=importdata('MKMATLAB.txt');      % 从外部将文本或者数据文件如txt.dat导入到Matlab的workspace中 



    %初始赋值
    for i=1:150
        for j=1:150
            A(i,j)=0;
        end
    end
    %遍历填充矩阵  
    len=length(MK);
        for m=1:len
            
                grid=MK(m,1);
                if(grid>=0)        %网格编号在研究区域内
                    row=fix(grid/150);%向0取整
                    row=row+1;%得到行号
                    column=rem(grid,150);%取余数
                    column=column+1;%得到列号
                    A(row,column)=MK(m,2);%时间赋值
                end
                m=m+1;
            
        end       
    x=1:150;y=1:150;
    
    pcolor(x,y,A);colorbar;title('POIs per Grid');
    %subplot(4,6,k-1);pcolor(x,y,A);%?????%shading interp;%image(A);
