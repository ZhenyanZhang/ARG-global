#include <cstring>
#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>
#include <map>
#include <set>
#include <cmath>
#include <inttypes.h>
#include <boost/lexical_cast.hpp>
#include <boost/algorithm/string.hpp>
#include "ppm.h"
 
using namespace std;
 
void usage()
{
   cout << "./ppm <input.sh_sort.sam> <genome.fa.fai> <total_reads_number> " << endl;
   cout << "  -h           get help information"   << endl;
   exit (0);
}
 
int main(int argc, char *argv[])
{
   int c;
   while ( (c=getopt(argc,argv,"a:p:h")) != -1 )
   {
      switch(c)
      {
         case 'h' : usage();break;
         default : usage();
      }
   }
   if (argc < 4) usage();
   string sam_file = argv[optind++];
   string fai_file = argv[optind++];
   string total_reads1 = argv[optind++];
   //int total_reads = atoi(total_reads1.c_str());
   int total_reads = stoi(total_reads1);
   //cout << total_reads << endl;
 
   map<string,int>   GenSize;
   map<string,int>   GenRead;
   load_fai(fai_file,GenSize);
   //cout << "load fai suceess" <<endl;
 
   ifstream infile;
   infile.open(sam_file.c_str());
   if (! infile )
   {
      cerr << "fail to open input file" << sam_file;
   }
   string lineStr;
   int total_line;
 
   while ( getline(infile,lineStr,'\n' ))
   {
      vector<string> lineVec;
      ++total_line;
      boost::split(lineVec,lineStr,boost::is_any_of("\t"),boost::token_compress_on);
      if (lineVec[5] == "*"){
         continue;
      }
      GenRead[lineVec[2]]++;
   }
   infile.close();
   cout << "Gene\tppm\treads\ttotal_reads" << endl;
   cal_ppm(GenRead,GenSize,total_reads);
}