// October 2005
// B W-Husey
// This OnEnter script is used on Forest Edge. It retrieves the weather over Thunderstone Town
// and applies it here too.

#include "cu_functions"

void main()
{
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);
    if (GetIsDefPC(oPC))
    {
    //disarm entering party and store what weapons they used
    RearmParty(oPC);

    if (GetCalendarDay()!= GetLocalInt(oPC,"nWeatherDay"))//Check the weather for today (once a day)
    {
    DelayCommand(0.1,CheckWeather(GetArea(oPC),oPC));
    //debug line ************
    //SendMessageToPC(oPC,"Checking Weather");
    }
    else  DelayCommand(0.1,GetMyWeather(oPC,oArea));
    SetLocalInt(oPC,"nWeatherDay",GetCalendarDay());
    }
}
