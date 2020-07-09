// B W-Husey
// October 2005
// Polter's Fort entry script that checks whether the alarm has been raised and
// if so generates a hobgoblin who runs for the gong.
// Also generates the objects used in the Careless Master quest once it has been activated by the trigger outside the keep door.
#include "cu_functions"

void DoActions()
{
    object oGong = GetObjectByTag("FortGong");
    SpeakOneLinerConversation("intruders");
    ActionForceMoveToObject(oGong, TRUE, 1.0);
    DelayCommand(0.1,ActionInteractObject(oGong));
    DelayCommand(6.0,ActionDoCommand(SetCommandable(TRUE)));
    DelayCommand(0.2,ActionDoCommand(SetCommandable(FALSE)));
}


void main()
{
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);
    if (GetIsDefPC(oPC) && GetLocalInt(oPC,"nPFAlarmed")==1)
    {
        SetLocalInt(oPC,"nPFAlarmed",0); //Switch it off
        location lLoc = GetLocation (GetWaypointByTag("WP_AlarmSpawn"));
        object oGong = GetObjectByTag("FortGong");
        object oRunner = CreateObject(OBJECT_TYPE_CREATURE,"hobgoblinscout",lLoc,FALSE,"Runner"); //Make the runner
        AssignCommand(oRunner,ClearAllActions(TRUE));
        AssignCommand(oRunner,DoActions()); //shout the warning & bash the gong
        ExecuteScript("dla_obgong1",GetObjectByTag("FortGong")); //back up, so it always happens
        /*
        AssignCommand(oRunner,ClearAllActions(TRUE));
        AssignCommand(oRunner,SpeakOneLinerConversation("intruders")); //shout the warning
        AssignCommand(oRunner,DelayCommand(0.1,ActionForceMoveToObject(oGong, TRUE, 1.0)));//move to gong
        AssignCommand(oRunner,DelayCommand(0.2,ActionInteractObject(oGong)));              //ring it
        AssignCommand(oRunner, DelayCommand(10.0,ActionDoCommand(SetCommandable(TRUE))));
        AssignCommand(oRunner, ActionDoCommand(SetCommandable(FALSE)));
        */
    }
    if (GetIsDefPC(oPC) && GetLocalInt(oPC,"nCareActive")==1)
        {
            if (GetLocalInt(oArea,"nDefended")==1)
            {
            FloatingTextStringOnCreature("Your horse has been disturbed",oPC);
            AddJournalQuestEntry("Careless",11,oPC);
            }
            if (GetLocalInt(oArea,"nDefended")==2)
            {
            FloatingTextStringOnCreature("Your horse has been stolen",oPC);
            AddJournalQuestEntry("Careless",10,oPC);
            }
            SetLocalInt(oPC,"nCareActive",2);
        }

}
