// February 2006
// B W-Husey
// NPC rewards template to be used after an action
// Alice has been hired to find information on Polter's Fort. Checks to see if info is gathered
#include "cu_functions"
void main()
{
    object oPC = GetPCSpeaker();
    int nChoice = GetLocalInt(oPC,"nAInfo");  //See if the PC asked for info.

  if (nChoice>0 && GetLocalInt(oPC,"nInfoPoltGath")<1)//run if we asked for info and don't have it yet.
  {
        int nDay = GetLocalInt(oPC,"nInfoDay");
        int nTime = GetLocalInt(oPC,"nInfoHour");
        switch(nChoice)
        {
            case 1:// chose 2 hour choice
                if (GetTimeHour()+1 > nTime || GetCalendarDay()>nDay)
                AllParty("nInfoPoltGath",oPC,1); //Info has been gathered
            break;
            case 2:// chose 1 day choice
                if ((GetTimeHour() > nTime && GetCalendarDay()>nDay) || (GetTimeHour() <= nTime && GetCalendarDay()>nDay+1))
                AllParty("nInfoPoltGath",oPC,1); //Info has been gathered
            break;
            case 3:// chose 2 day choice
                if ((GetTimeHour() > nTime && GetCalendarDay()>nDay+1) || (GetTimeHour() <= nTime && GetCalendarDay()>nDay+2))
                AllParty("nInfoPoltGath",oPC,1); //Info has been gathered
            break;
        }
  }
}
