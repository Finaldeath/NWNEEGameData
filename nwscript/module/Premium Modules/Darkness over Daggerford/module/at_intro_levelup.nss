//ActivateFleeToExit will cause an NPC to flee to a waypoint called EXIT_ + <NPC's tag>,
//and then destroy itself, optionally respawning at its spawn-in location.
//
//Author: Phil Mitchell (Baron of Gateford)
//Date:29-June-2005

#include "NW_I0_GENERIC"

void main()
{
    //DelayCommand(0.5,ExecuteScript("at_remove_immob",OBJECT_SELF));
    DelayCommand(0.5,ExecuteScript("at_cara_exit",OBJECT_SELF));
    ActivateFleeToExit();
    //additions - Damian Brown (Luspr), 03-Aug-2005, for opening sequence
    object oPC = GetPCSpeaker();
    int nHitDie = GetHitDice(oPC);
    if(nHitDie <8)//if level is less than 8, levelup to 8
    {
        //AssignCommand(oPC, ClearAllActions());
       // DelayCommand(0.3, AssignCommand(oPC, ActionStartConversation
       // (OBJECT_SELF, "db_levelup", FALSE, FALSE)));
    }
    //end additions
}
