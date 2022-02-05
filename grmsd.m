function[]=grmsd(options)
% add paths
addpath('algo');
addpath('algo/sub');

method='three_points';
use_label=true;
permit_mirror=false;
ignore_atom=1;
% ignore_atom=[];  % consider H
clus_mode=false;
reduction=true;
iter_num=4;

args=argv();
queryfile=args{1};
targetfile=args{2};
resultfile=args{3};

data1=importdata(queryfile);
data_num_1=data1(1,1);
mol_num_1=(size(data1,1)-1)/data_num_1;

data2=importdata(targetfile);
data_num_2=data2(1,1);
mol_num_2=(size(data2,1)-1)/data_num_2;

data_struct_1(1:mol_num_1)=struct('pos',zeros(3,data_num_1),'label',zeros(1,data_num_1));
data_struct_2(1:mol_num_2)=struct('pos',zeros(3,data_num_2),'label',zeros(1,data_num_2));

for i=1:mol_num_1
    data_struct_1(i).pos=data1(data_num_1*(i-1)+2:data_num_1*i+1,1:3)';
    final_label=true(1,data_num_1);
    data_struct_1(i).label=data1(data_num_1*(i-1)+2:data_num_1*i+1,4)';
    for ind=ignore_atom
        final_label=final_label&(data_struct_1(i).label~=ind);
    end
    data_struct_1(i).pos=data_struct_1(i).pos(:,final_label);
    data_struct_1(i).label=data_struct_1(i).label(final_label);
    if ~use_label
        data_struct_1(i).label=ones(1,data_num_1);
    end
        
end

for i=1:mol_num_2
    data_struct_2(i).pos=data2(data_num_2*(i-1)+2:data_num_2*i+1,1:3)';
    final_label=true(1,data_num_2);
    data_struct_2(i).label=data2(data_num_2*(i-1)+2:data_num_2*i+1,4)';
    for ind=ignore_atom
        final_label=final_label&(data_struct_2(i).label~=ind);
    end
    data_struct_2(i).pos=data_struct_2(i).pos(:,final_label);
    data_struct_2(i).label=data_struct_2(i).label(final_label);
    if ~use_label
        data_struct_2(i).label=ones(1,data_num_2);
    end
end
        
result=zeros(mol_num_1,mol_num_2);
progress=0.1; 
for i=1:mol_num_1
    for j=1:mol_num_2
        if strcmp(method,'three_points')
            result(i,j)=three_points(data_struct_1(i).pos,data_struct_2(j).pos,data_struct_1(i).label,data_struct_2(j).label,permit_mirror,reduction,iter_num);
        else
            result(i,j)=three_points(data_struct_1(i).pos,data_struct_2(j).pos,data_struct_1(i).label,data_struct_2(j).label,permit_mirror);
        end
    end
end
csvwrite(resultfile,result)
