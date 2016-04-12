saved_name = 'C';
s = load('ORLFACEDATABASE.mat',saved_name);
d = s.(saved_name);

Z = rotdim(d(:,1:5));

for i = 1:39
	j = i*10 + 1; 
	Z = cat(1,Z,rotdim(d(:,j:j+4)));
endfor

covZ = cov(Z);
[v,lambda] = eigs(covZ);

meanFaces = zeros(40,6);

for i = 0:39
	j = i*10 + 1;
	temp = double(rotdim(d(:,j:j+4))) * v;
	meanFaces(i+1,:) = mean(temp,1);
endfor

%Testing phase

errorRate = 0;

for l = 0:4
	for i = 0:39
		j = i*10 + 6 + l;
		newVector = double(rotdim(d(:,j))) * v;
		
		minimumDistance = norm(meanFaces(1,:) - newVector,2);
		person = 1;

		for k = 2:40
			temp = norm(meanFaces(k,:) - newVector,2);

			if (minimumDistance > temp)
				minimumDistance = temp;
				person = k;	
			endif

		endfor

		if( person != i+1)
			errorRate++;
		endif
	endfor
endfor

errorRate


