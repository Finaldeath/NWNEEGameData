// October 2005
// B W-Husey
// This OnEnter script is used on Hawklin Castle. It retrieves the weather over Thunderstone Town
// and applies it here too.
// Actually it's also used for the tournament, jousting grounds & forest adge too (place in OnEnter of area).

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
    //SendMessageToPC(oPC,"Checking Weather");
    }
    else  DelayCommand(0.1,GetMyWeather(oPC,oArea));
    SetLocalInt(oPC,"nWeatherDay",GetCalendarDay());
    }
}
