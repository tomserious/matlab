fidin=fopen('poicounters.txt');
fidout=fopen('mkmatlab.txt','w');                        % �½�MKMATLAB.txt�ļ��������            
i=0;
while ~feof(fidin)                                     % �ļ�ָ�� fid δ�����ļ�ĩβ    
    tline=fgetl(fidin);                               % ���ļ��ж�ȡһ�����ݣ���������ĩ�Ļ��з� 
    fprintf(fidout,'%s\n',tline);                   % ��ǰ��д��MKMATLAB.txt    
end 
fclose(fidout); 
MK=importdata('MKMATLAB.txt');      % ���ⲿ���ı����������ļ���txt.dat���뵽Matlab��workspace�� 



    %��ʼ��ֵ
    for i=1:150
        for j=1:150
            A(i,j)=0;
        end
    end
    %����������  
    len=length(MK);
        for m=1:len
            
                grid=MK(m,1);
                if(grid>=0)        %���������о�������
                    row=fix(grid/150);%��0ȡ��
                    row=row+1;%�õ��к�
                    column=rem(grid,150);%ȡ����
                    column=column+1;%�õ��к�
                    A(row,column)=MK(m,2);%ʱ�丳ֵ
                end
                m=m+1;
            
        end       
    x=1:150;y=1:150;
    
    pcolor(x,y,A);colorbar;title('POIs per Grid');
    %subplot(4,6,k-1);pcolor(x,y,A);%?????%shading interp;%image(A);
