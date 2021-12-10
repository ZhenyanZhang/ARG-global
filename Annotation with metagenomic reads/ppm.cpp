#include "ppm.h"
using namespace std;
void load_fai(string &matrix_file, map<string,int> &GenSize){
   ifstream infile;
   infile.open(matrix_file.c_str());
   if (! infile ) {
      cerr << "fail to open input file " << matrix_file << endl;
      exit(0);
   }
   string lineStr;
 
   while (getline(infile,lineStr,'\n')){
      if (lineStr[0] == ' ' || lineStr[0] == '\n'){
         continue;
      }
 
      vector<string> lineVec;
      boost::split(lineVec,lineStr, boost::is_any_of(", \t\n"), boost::token_compress_on);
      GenSize[lineVec[0]] =  boost::lexical_cast<int>(lineVec[1]);
   }
   infile.close();
}
 
void cal_ppm(map<string,int> &GenRead, map<string,int> &GenSize,int total){
   map<string,int>::const_iterator map_size;
   for (map_size=GenSize.begin();map_size!=GenSize.end();map_size++){
      int _size = map_size->second;
      int _read = 0;
      map<string,int>::iterator map_read;
      map_read = GenRead.find(map_size->first) ;
      if ( map_read != GenRead.end() ){
         _read = GenRead[map_size->first];
      }
      if(_read != 0){
         double ppm = log( (double)_read ) + log( (double)1000000 ) - log( (double)total );
         cout << map_size->first << "\t" << exp(ppm) << "\t" << _read << "\t" << total << endl;
      }
      
   }
}