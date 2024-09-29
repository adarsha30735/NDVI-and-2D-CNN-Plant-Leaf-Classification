clear all  clc


I_nir=(imread("0045_nir.tiff"));
I_rgb=imread('0045_rgb.tiff');
red= I_rgb(:,:,1);
green=I_rgb(:,:,2);
blue=I_rgb(:,:,3);

[r2 , c2]=size(I_nir);

B_heq=histeq(blue);
G_heq = histeq(green);
R_heq = histeq(red);
NIR_heq = histeq(I_nir);

NIR = double(NIR_heq);
R = double(R_heq);
G = double(G_heq);
B= double(B_heq);

ndvi=zeros(r2,c2);
vari=zeros(r2,c2);
for i=1:r2
    for j=1:c2
        ndvi(i,j)= (NIR(i,j)-R(i,j))/(NIR(i,j)+R(i,j));
        vari(i,j)=(G(i,j)-R(i,j))/(G(i,j)+R(i,j)-B(i,j));
        rvi(i,j)=(NIR(i,j))/(R(i,j));
    end
end

% NDVI = (NIR -R) ./ (NIR + R);
% figure(), imshow(NDVI, []), title('NDVI');
% colormap(jet);
% colorbar;
% impixelinfo

% VARI = (G -R) ./ (G+ R-B);
% figure(), imshow(VARI, []), title('VARI');
% colormap(jet);
% colorbar;
% impixelinfo

figure
imshow(rvi, []);
title('RVI');
colormap(jet);
colorbar;
impixelinfo




figure
imshow(vari,[]);
title('VARI');
colormap(jet);
colorbar;
impixelinfo

figure
imshow(I_rgb);


c1=0;
c22=0;
c3=0;
c4=0;
c5=0;
c6=0;
c7=0;
c8=0;
for f=1:r2
    for g=1:c2
       if (ndvi(f,g)>=(-1)) && (ndvi(f,g)<-0.41379)
           c1=c1+1;
       
       elseif (ndvi(f,g)>=-0.41379) && (ndvi(f,g)<-0.10401)
           c22=c22+1;
           
       elseif (ndvi(f,g)>=-0.10401) && (ndvi(f,g)<0.055727 )
           c3=c3+1; 
      
       
       elseif (ndvi(f,g)>=0.055727 ) && (ndvi(f,g)<0.20579)
           c4=c4+1; 
       
       elseif (ndvi(f,g)>=0.20579  ) && (ndvi(f,g)<0.37035 )
           c5=c5+1;
           
       elseif (ndvi(f,g)>=0.37035 ) && (ndvi(f,g)<0.51073  )
           c6=c6+1;        
       elseif (ndvi(f,g)>=0.51073) && (ndvi(f,g)<0.82051 )
           c7=c7+1;    
       elseif (ndvi(f,g)>=0.82051) && (ndvi(f,g)<=1 )
           c8=c8+1;    
       end
    end
end



%barren areas rock stone or no vegetation
p1=(c1/(r2*c2))*100;
%water or no vegetation (deep/shallows)
p2=(c22/(r2*c2))*100;
%buitups/ rivers sand
p3=(c3/(r2*c2))*100;
%fallow/wasteland/limited grass or crops
p4=(c4/(r2*c2))*100;
%crops/grass
p5=(c5/(r2*c2))*100;
%Agroforestry plus  vegetation such as crops/grass
p6=(c6/(r2*c2))*100;
%Forest or healthy vegetation
p7=(c7/(r2*c2))*100;
%very dense forest and healthy vegetation
p8=(c8/(r2*c2))*100;

total_classified=c1+c22+c3+c4+c5+c6+c7+c8;

%unclassified
if total_classified<(r2*c2)
    unclassified=(r2*c2)-total_classified;
    p9= unclassified/(r2*c2)*100;
else
    p9=0;
end

figure
imshow(ndvi, []);
title('NDVI');
colormap(jet);
colorbar;
impixelinfo

data=[p1, p2, p3, p4, p5, p6, p7 ,p8, p9];
figure;


%bar(diag(data),'stacked')
pie(data)

set(gca, 'XTickLabel',{'c1', 'c2','c3','c4','c5','c6','c7','c8', 'c9'});

ylabel('Percentage');


legend('barren areas rock stone or no vegetation','water or no vegetation (deep/shallows)','buitups/ rivers sand','fallow/wasteland/limited grass or crops','crops/grass','Agroforestry plus  vegetation such as crops/grass','Forest or healthy vegetation','very dense forest and healthy vegetation','unclassified')


