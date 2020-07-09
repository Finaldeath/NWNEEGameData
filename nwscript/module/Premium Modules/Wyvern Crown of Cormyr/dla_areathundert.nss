// October 2005
// B W-Husey
// This OnEnter script is used on Thunderstone Town. It checks the weather only if the weather has not been
// set today.
// USE ON THUNDERSTONE: TOWN ONLY
#include "cu_functions"

void main()
{
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);

    if (GetIsDefPC(oPC))
    {
        //disarm entering party and store what weapons they used
        DisarmParty(oPC);
        //Weather stuff
        if (GetLocalInt(oPC,"nFirstThund")==0)
        {
            SetLocalInt(oPC,"nFirstThund",1);
            AddJournalQuestEntry("MainPlot",20,oPC,TRUE);
            SetLocalInt(oPC,"nWeatherDay",0);
        }
        else if (GetCalendarDay()!= GetLocalInt(oPC,"nWeatherDay"))//Check the weather for today (once a day)
        {
            DelayCommand(0.1,CheckWeather(GetArea(oPC),oPC));
            //debug line ************
//            SendMessageToPC(oPC,"Checking Weather");
        }
        else
            DelayCommand(0.1,GetMyWeather(oPC,oArea));

        SetLocalInt(oPC,"nWeatherDay",GetCalendarDay());

        //Next line fires a script that updates status of Family Grave quest
        ExecuteScript("misc_graveupdate",oPC);
        ExecuteScript("dla_miscgohome",oPC); //retrieve henchmen left in closed off areas.

    } //end of is PC if
}
