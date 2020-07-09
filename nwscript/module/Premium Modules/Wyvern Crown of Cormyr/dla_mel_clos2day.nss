/*
    DLA_MEL_CLOS2DAY.nss
    gaoneng erick            June 24, 2006

    returns FALSE if maximum bouts per day not exceeded or day has passed.
*/

#include "dla_mel_inc2"

int StartingConditional()
{
    return !dla_GetCanEnter(GetPCSpeaker());
}


/*#include "dla_mel_inc"

int StartingConditional()
{
   object oPC = GetPCSpeaker();

   //If current day is equal to last day PC fought
   if (GetLocalString(oPC,"DLA_mel_lastday") == DLA_Retrieve_Current_Game_Date())
   {
       if (GetLocalInt(oPC, "DLA_mel_timesday") >= DLA_MAX_FIGHTS_PER_DAY)
       //how many times PC did fight today
       return TRUE;
   }
   else //it's another day, so reset the number of fights today.
   DeleteLocalInt(oPC, "DLA_mel_timesday");
   return FALSE;
}
