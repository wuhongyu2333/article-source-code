function [d,se,sa]=ansysfem(x)
        clear_txt=[];
        input=reshape(x,29,1);
        fid = fopen('input.txt','wt');
        fprintf(fid,'%g\n',input);
        fclose(fid);
        system('SET KMP_STACKSIZE=2048k & F:\Ansys\ANSYSInc\v150\ansys\bin\winx64\ANSYS150.exe -b -p ane3fl -i F:\Ansys\ANSYSInc\dome4\fem1.mac -o  F:\Ansys\ANSYSInc\dome4\out.txt')
        load output.txt   -ASCII
        if isempty(output)
            d = 1e10;
            se = 1e10;
            sa = 1e10;
            disp('error');
        else
            d = output(1);
            se = output(2);
            sa = output(3);
        end
        fid = fopen('input.txt','wt');
        fprintf(fid,'%g\n',clear_txt);
        fclose(fid);
        fid = fopen('output.txt','wt');
        fprintf(fid,'%g\n',clear_txt);
        fclose(fid);    
end