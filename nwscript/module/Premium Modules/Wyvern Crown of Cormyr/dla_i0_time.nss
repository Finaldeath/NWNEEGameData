////////////////////////////////////////////////////////////////////////////////
// dla_i0_time - DLA Team Library - Supports time related functions
// Original Scripter: Deva B. Winblood            DLA Team
// Last Modified By:  Deva B. Winblood            5/15/2006
//------------------------------------------------------------------------------
// The purpose of this library is to provide absolute time functions which can
// be used within time sensitive scripts without adding the added overhead of
// delay commands which do not survive reload, can cascade fail, and eat up
// more CPU time.
////////////////////////////////////////////////////////////////////////////////


////////////////////////
// PROTOTYPES
////////////////////////

// FILE: dla_i0_time
// This function will return the absolute delay which is a product of the
// following formula: Current Day + Month x 30 + Year x 12 x 30.
int DLA_GetAbsoluteDay();

// FILE: dla_i0_time
// This function will return the absolute hour which is a product of the
// following formula: Current Hour + Day x 24 + Month x 30 x 24 + Year x 30 x 24 x 12
int DLA_GetAbsoluteHour();

// FILE: dla_i0_time
// This function will return the absolute minute which is a product of the
// following formula: Current Minute + Hour x 60 + Day x 24 x 60 + Month x 60 x 24 x 30 + Year x 60 x 24 x 30 x 12
int DLA_GetAbsoluteMinute();


////////////////////////
// FUNCTIONS
////////////////////////

int DLA_GetAbsoluteDay()
{ // PURPOSE: To calculate and return the absolute day
  // Original Scripter: Deva B. Winblood
  // Last Modified By:  Deva B. Winblood  5/15/2006
  return GetCalendarDay()+GetCalendarMonth()*30+GetCalendarYear()*30*12;
} // DLA_GetAbsoluteDay()


int DLA_GetAbsoluteHour()
{ // PURPOSE: To calculate and return the absolute hour
  // Original Scripter: Deva B. Winblood
  // Last Modified By:  Deva B. Winblood  5/15/2006
  return GetTimeHour()+GetCalendarDay()*24+GetCalendarMonth()*24*30+GetCalendarYear()*24*30*12;
} // DLA_GetAbsoluteHour()

int DLA_GetAbsoluteMinute()
{ // PURPOSE: To calculate and return the absolute minute
  // Original Scripter: Deva B. Winblood
  // Last Modified By:  Deva B. Winblood  5/15/2006
  return GetTimeMinute()+GetTimeHour()*60+GetCalendarDay()*60*24+GetCalendarMonth()*60*24*30+GetCalendarYear()*60*24*30*12;
} // DLA_GetAbsoluteMinute()


//void main(){}
