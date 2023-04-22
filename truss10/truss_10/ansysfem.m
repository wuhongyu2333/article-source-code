function [d,se]=ansysfem(x)
        clear_txt=[];
        input=x';
        fid = fopen('F:\Ansys\ANSYSInc\truss\input.txt','wt');
        fprintf(fid,'%g\n',input);
        fclose(fid);
        %system('SET KMP_STACKSIZE=2048k & F:\Ansys\ANSYSInc\v150\ansys\bin\winx64\ANSYS150.exe -b -p ane3fl -i F:\Ansys\ANSYSInc\truss\femcal.mac -o  F:\Ansys\ANSYSInc\truss\out.txt')
        system('F:\Ansys\ANSYSInc\v150\ansys\bin\winx64\ANSYS150.exe -b -p ane3fl -i F:\Ansys\ANSYSInc\truss\femcal.mac -o  F:\Ansys\ANSYSInc\truss\out.txt')
        load F:\Ansys\ANSYSInc\truss\output.txt   -ASCII
        if isempty(output)
            d = 10;
            se=1e10;
            disp('error');
        else
            y_max = output(1);
            y_min = output(2);
            stress_max = output(3);
            stress_min = output(4);
            d = max(abs(y_max),abs(y_min));
            se = max(abs(stress_max),abs(stress_min));
        end
        fid = fopen('output.txt','wt');
        fprintf(fid,'%g\n',clear_txt);
        fclose(fid);
%         if d<2 && se<2.5e4
%             j=1;
%         else
%             j=-1;
%         end
end