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
 
void load_fai(std::string &matrix_file,std::map<std::string,int> &GenSize);
void cal_ppm(std::map<std::string,int> &GenRead, std::map<std::string,int> &GenSize,int total);