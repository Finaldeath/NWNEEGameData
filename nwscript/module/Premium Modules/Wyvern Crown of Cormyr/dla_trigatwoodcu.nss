// March 2006
// B W-Husey
// Give the PC back his henchmen and transition

#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    object oTarget = GetTransitionTarget(OBJECT_SELF);
/*
    object oJonas = GetNearestObjectByTag("Jonas");
    object oGodfroy =  GetNearestObjectByTag("Godfroy");

    // Add Jonas and Godfroy as henchmen
    /*
    SetMaxHenchmen(2); // remove this after integration
    SetLocalInt(oJonas,   "X0_L_LEVELRULES", 0);
    SetLocalInt(oGodfroy, "X0_L_LEVELRULES", 0);
    DLA_SetHenchman(oJonas,   oPC);
    DLA_SetHenchman(oGodfroy, oPC);
    SetDidQuit(oPC, oJonas,   FALSE);
    SetDidQuit(oPC, oGodfroy, FALSE);

    // Turn on standard henchman listening patterns
    SetAssociateListenPatterns(oJonas);
    SetAssociateListenPatterns(oGodfroy);
    LevelUpXP1Henchman(oPC);
    DLA_RefreshMovementSpeed(oJonas);
    DLA_RefreshMovementSpeed(oGodfroy);
*/

    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC,JumpToObject(oTarget));
}


