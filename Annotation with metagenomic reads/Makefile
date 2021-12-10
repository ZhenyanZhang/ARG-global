cc=g++
exe=ppm
obj=main.o ppm.o

$(exe):$(obj)
	   $(cc) -o $(exe) $(obj) -std=c++11
main.o:main.cpp ppm.h
	   $(cc) -c main.cpp -std=c++11
MTP.o:ppm.cpp ppm.h
	   $(cc) -c MTP.cpp -std=c++11
clean:
	   rm -rf *.o $(exe)