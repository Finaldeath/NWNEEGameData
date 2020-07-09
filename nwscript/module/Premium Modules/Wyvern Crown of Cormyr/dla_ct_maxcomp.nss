//////////////////////////////////////////////////////////////////
// dla_ct_maxcomp - Maximum competitions for the day have been
// completed.
// Original Scripter:  Deva B. Winblood
// Last Modified By:   Deva B. Winblood   5/3/2006
/////////////////////////////////////////////////////////////////

int StartingConditional()
{
   object oPC=GetPCSpeaker();
   int nCount=GetLocalInt(oPC,"nArcheryCompCount");
   int nArcheryDay=GetLocalInt(oPC,"nArcheryDay");
   int nToday=GetCalendarDay()+GetCalendarMonth()*30+GetCalendarYear()*30*12;
   if (nCount>2&&nToday==nArcheryDay) return TRUE;
   if (nCount>2) DeleteLocalInt(oPC,"nArcheryCompCount");
   return FALSE;
}
