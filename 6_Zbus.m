// Zbus

clc
clear all

Zbus = [0];
Quit= 0;
i = 0;

while Quit == 0
    
    Case = input('Which case is to be implemented \n 1. New bus to reference bus \n 2. Existing bus to new bus \n 3. existing bus to reference bus \n 4. between two existing buses \n');
    
    if Case == 1
        
        if i == 0
            Zb =input("Enter the value of impedance =");
            
            Zbus=[Zb]
            
            i=i+1;
            
        else
            if i>0
                Zb =input('Enterthe value of impedance =');
                ord =length (Zb1);
                for d = 1:ordt1
                    for e = i:ord+1
                        if d<=ord && e<=ord                        
                            Zbus1(d,e) = Zb1 (d,e); 
                        end
                        if d==ord+1 && e==ordt1
                            Zbus1(d,e) = Zb;
                        end
                        if d==ord+1 && d~=e || e==ord+1 && d~=e
                            Zbus1(d,e) = 0;
                        end
                    end
                end
            end
            
            Zbus=[Zbus1]
            
        end
    end
    
    if Case == 2
        Z_new = input ('Enter the value of impedance for new bus ='); 
        m =length (Zbus); 
        for a=1:m
            for b=1:m
                Z_temp(a,b) = Zbus (a,b);
            end
        end
        for c = 1:m
            Z_temp (c,m+1) = Zbus (c,m) ;
            Z_temp (m+1,c)=Zbus (c,m);
            Z_temp (m+1,m+1)=Zbus(m,m)+Z_new;
        end
        
        Zbus=[Z_temp]
        
        i = i+1;
    end
    
    if Case == 3
        Znew = input ('Enter the value of impedance for newbus =');
        m = length (Zbus) ;
        for a=1:m
            for b=1:m
                Z_temp (a,b) = Zbus (a,b) ;
            end
        end
        for c=1:m
            Z_temp (c,m+1) = Zbus (c,m);
            Z_temp (m+1, c) = Zbus (c,m) ;
            Z_temp (m+1,m+1) = Zbus (m,m) +Z_new;
            fprintf('Zbus before Kron Reduction: \n ')
            
            Zbus=[Z_temp]
            
            m =length (Zbus);
            for i=1:m-1
                for k = 1:m-1
                    Z(i,k)=Zbus(i,k)-Zbus(i,m)*Zbus(m,k)/Zbus(m,m);
                end
            end
            fprintf('Zbus after Kron Zbus= [Z] Reduction: \n')
        end
    end
    
    if Case == 4
        Z1=input('Enter the value of impedance -');
        j=input('Enter the value of bus j '); 
        k=input('Enter the value of bus k ');
        m=length(Zbus);
        
        for a=l:m
            for b=l:m
                Z_temp(a,b) = Zbus (a,b); 
            end
        end
        
        for c =1:m
            Z_temp(c,m+1)= Zbus(c,j)-Zbus(c,k); 
            Z_temp(m+1,c)=Z_temp(C,m+1);
        end
        
        Z_temp (m+1,m+1) = Z1+Zbus (j,j)+Zbus (k,k) -2*Zbus (j,k);
        fprintf('Zbus before Kron Reduction :\n')
        Zbus = [Z_temp]
        m = length(Zbus);
        
        for i=l:m-1
            for k = 1:m-1
                z(i,k)= Zbus(i,k)-Zbus(i,m)*Zbus(m,k)/Zbus(m,m);
            end
        end
        
        fprintf('Zbus after Kron Reduction :\n');
        Zbus=[Z]
    end
    Quit=input('Do u want to quit =');
    Zbl=[Zbus];
end


        
        
        
        
        
        
        
        
        
