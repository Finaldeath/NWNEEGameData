// October 2005
// B W-Husey
// This OnEnter script is used on Melee Ground. It retrieves the weather over Thunderstone Town
// and applies it here too.
// Rearms party

#include "cu_functions"

void main()
{
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);
    string sExtension = GetLocalString(oArea,"sExtension");
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
    // Deva  7/14/2006
    if (GetStringLength(sExtension)>0)
    { // run extension script
        ExecuteScript(sExtension,OBJECT_SELF);
    } // run extension script
}
