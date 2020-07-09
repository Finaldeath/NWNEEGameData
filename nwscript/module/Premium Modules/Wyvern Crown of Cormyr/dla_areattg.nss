// October 2005
// B W-Husey
// This OnEnter script is used on the Tournament/Jousting Ground. It retrieves the weather over Thunderstone Town
// and applies it here too. Also plays the tournament music once before switching to background


#include "cu_functions"

void main()
{
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);
    if (GetIsDefPC(oPC))
    {
    //disarm entering party and store what weapons they used
    DisarmParty(oPC);
    if (GetCalendarDay()!= GetLocalInt(oPC,"nWeatherDay"))//Check the weather for today (once a day)
    {
        DelayCommand(0.1,CheckWeather(GetArea(oPC),oPC));
        //debug line ************
    //    SendMessageToPC(oPC,"Checking Weather");
    }
    else  DelayCommand(0.1,GetMyWeather(oPC,oArea));
    DelayCommand(122.0,MusicBackgroundChangeDay(oArea,20));
    DelayCommand(122.0,MusicBackgroundChangeDay(oArea,20));
    SetLocalInt(oPC,"nWeatherDay",GetCalendarDay());
    }
}
