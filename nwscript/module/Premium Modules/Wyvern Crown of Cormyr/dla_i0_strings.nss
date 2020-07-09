////////////////////////////////////////////////////////////////////////////////
// dla_i0_strings - DLA - String Functions Include
//------------------------------------------------------------------------------
// Original Scripter: Deva B. Winblood
//------------------------------------------------------------------------------
// Last Modified By: Deva Winblood   5/2/2006
////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////
// CONSTANTS
///////////////////////////////////////
const string NEW_TXT_COLOR_GRAY = "444";
const string NEW_TXT_COLOR_WHITE = "666";
const string NEW_TXT_COLOR_CYAN = "066";
const string NEW_TXT_COLOR_MAGENTA = "606";
const string NEW_TXT_COLOR_YELLOW = "660";
const string NEW_TXT_COLOR_RED = "600";
const string NEW_TXT_COLOR_GREEN = "060";
const string NEW_TXT_COLOR_BLUE = "006";
const string NEW_TXT_COLOR_BLACK = "000";
const string NEW_TXT_COLOR_DEFAULT = NEW_TXT_COLOR_CYAN;


//////////////////////////////////////
// PROTOTYPES
//////////////////////////////////////

// FILE: dla_i0_strings     FUNCTION: DLA_SetStringColor()
// This function will make sString be the specified color
// as specified in sRGB.  RGB is the Red, Green, and Blue
// components of the color.  Each color can have a value from
// 0 to 6.   A RED = "600"   A GREEN = "060"   A BLUE = "006"
// WHITE = "666"  BLACK = "000" and so forth.  You may also
// pass string constants as sRGB provided they are in the 3 digit
// RGB format.
string DLA_SetStringColor(string sString,string sRGB);

// FILE: dla_i0_parse       FUNCTION: DLA_ParseRight()
// This function will parse from left to right until it encounters
// sDelimiter and will return all the characters it encountered before
// the delimiter occurred.
string DLA_ParseRight(string sSource,string sDelimiter=" ");

// FILE: dla_i0_parse       FUNCTION: DLA_ParseLeft()
// This function will parse from right to left until it encounters
// sDelimiter and will return all the characters it encountered before
// the delimiter occurred.
string DLA_ParseLeft(string sSource,string sDelimiter=" ");

// FILE: dla_i0_parse       FUNCTION: DLA_RemoveParsedRight()
// This function will take a string sParsed and remove it from the right side
// of the sSource string.  It will also remove any excess sDelimiter occurrences
// on that end.
string DLA_RemoveParsedRight(string sSource,string sParsed,string sDelimiter=" ");


// FILE: dla_i0_parse       FUNCTION: DLA_RemoveParsedLeft()
// This function will take a string sParsed and remove it from the left side
// of the sSource string.  It will also remove any excess sDelimiter occurrences
// on that end.
string DLA_RemoveParsedLeft(string sSource,string sParsed,string sDelimiter=" ");

//////////////////////////////////////
// FUNCTIONS
//////////////////////////////////////

string DLA_SetStringColor(string sString,string sRGB)
{ // PURPOSE: To convert sString to specified color
  // Original Scripter: Deva B. Winblood
  // Last Modified By: Deva B. Winblood   5/2/2006
  string sRGBVALUES=" fw®°Ìþ";
  string sColorEnd="</c>";
  string sRet;
  int nR=StringToInt(GetSubString(sRGB,0,1));
  int nG=StringToInt(GetSubString(sRGB,1,1));
  int nB=StringToInt(GetSubString(sRGB,2,1));
  if (nR>6) nR=6;
  if (nG>6) nG=6;
  if (nB>6) nB=6;
  sRet="<c"+GetSubString(sRGBVALUES,nR,1)+GetSubString(sRGBVALUES,nG,1);
  sRet=sRet+GetSubString(sRGBVALUES,nB,1)+">"+sString+sColorEnd;
  return sRet;
} // DLA_SetStringColorColor()


string DLA_ParseRight(string sSource,string sDelimiter=" ")
{ // PURPOSE: To return characters encountered from left to right until
  // sDelimiter is encountered.
  // Original Scripter:  Deva B. Winblood
  // Last Modified By:   Deva B. Winblood   5/2/2006
  string sRet="";
  int nPos=0;
  string sS;
  sS=GetSubString(sSource,nPos,1);
  while(sS!=sDelimiter&&nPos<GetStringLength(sSource))
  { // parse
    sRet=sRet+sS;
    nPos++;
    sS=GetSubString(sSource,nPos,1);
  } // parse
  return sRet;
} // DLA_ParseRight()

string DLA_ParseLeft(string sSource,string sDelimiter=" ")
{ // PURPOSE: To return characters encountered from right to left until
  // sDelimiter is encountered.
  // Original Scripter:  Deva B. Winblood
  // Last Modified By:   Deva B. Winblood   5/2/2006
  string sRet="";
  int nPos=GetStringLength(sSource)-1;
  string sS;
  sS=GetSubString(sSource,nPos,1);
  while(sS!=sDelimiter&&nPos>-1)
  { // parse
    sRet=sS+sRet;
    nPos=nPos-1;
    sS=GetSubString(sSource,nPos,1);
  } // parse
  return sRet;
} // DLA_ParseLeft()

string DLA_RemoveParsedRight(string sSource,string sParsed,string sDelimiter=" ")
{ // PURPOSE: Strip sParsed from the right side of sSource and remove excess
  // sDelimiter;
  // Original Scripter:  Deva B. Winblood
  // Last Modified By:   Deva B. Winblood   5/2/2006
  string sS;
  if (GetStringLength(sParsed)>=GetStringLength(sSource)) return "";
  sS=GetStringLeft(sSource,GetStringLength(sSource)-GetStringLength(sParsed));
  while(GetStringRight(sS,1)==sDelimiter)
  { // strip excess delimiters
    sS=GetStringLeft(sS,GetStringLength(sS)-1);
  } // strip excess delimiters
  return sS;
} // DLA_RemoveParsedRight()

string DLA_RemoveParsedLeft(string sSource,string sParsed,string sDelimiter=" ")
{ // PURPOSE: Strip sParsed from the left side of sSource and remove excess
  // sDelimiter;
  // Original Scripter:  Deva B. Winblood
  // Last Modified By:   Deva B. Winblood   5/2/2006
  string sS;
  if (GetStringLength(sParsed)>=GetStringLength(sSource)) return "";
  sS=GetStringRight(sSource,GetStringLength(sSource)-GetStringLength(sParsed));
  while(GetStringLeft(sS,1)==sDelimiter)
  { // strip excess delimiters
    sS=GetStringRight(sS,GetStringLength(sS)-1);
  } // strip excess delimiters
  return sS;
} // DLA_RemoveParsedLeft()


//void main(){}
