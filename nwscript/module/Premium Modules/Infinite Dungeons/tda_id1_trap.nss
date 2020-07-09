//::///////////////////////////////////////////////
//:: ID Trap Triggered
//:: ten_id_trap
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This trap must first setup using the IDSetUpScaledTrap function in the
"inc_id_traps" inorder to function.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: Sept 08, 2005
//:://////////////////////////////////////////////
#include "inc_id1_debug"
#include "inc_id_traps"
#include "inc_id1_utility"
#include "inc_id1_score"

void main()
{
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");
    int nDamageDC = GetLocalInt(OBJECT_SELF, "nDamageDC");
    int nDamageType = GetLocalInt(OBJECT_SELF, "nDamageType");
    int nDamageMin = GetLocalInt(OBJECT_SELF, "nDamageMin");
    int nDamageMax = GetLocalInt(OBJECT_SELF, "nDamageMax");
    float fTrapRadius = GetLocalFloat(OBJECT_SELF, "fRadius");

    int nDamage;

    SendMessageToPC(GetFirstPC(), "Disarmed trap.");
    DebugMessage("Disarming trap.");
    object oDungeon = GetCurrentDungeon();
    SetLocalInt(oDungeon, "b" + sVariable + "Triggered", TRUE);

    // award points
    object oPC = GetLastDisarmed();
    int nDC = GetTrapDisarmDC(OBJECT_SELF);

    AwardTrapDisarmedPoints(oPC, nDC);
}

