//::///////////////////////////////////////////////
//::
//:: c2_ud_ar2504
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: User defined script for area.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 11/9/2005
//::
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"

void MakeDefenders(string sTag, string sShout = "");

void main()
{
    int nEvent = GetUserDefinedEventNumber();

    if (nEvent == 501) // prisoners freed
    {
        SetLocalInt(GetModule(), "nIH_PrisonersFreed", 1);

        MakeDefenders("bw_slave01", "We're free!");
        MakeDefenders("bw_slave02", "Thank you!");
        MakeDefenders("bw_slave03");
        MakeDefenders("bw_korin");

        int nNth = 0;
        object oSound = GetObjectByTag("c1ar2504_pris_sound", nNth);

        while (GetIsObjectValid(oSound))
        {
            SoundObjectStop(oSound);
            DestroyObject(oSound);

            nNth += 1;
            oSound = GetObjectByTag("c1ar2504_pris_sound", nNth);
        }
    }
}

void MakeDefenders(string sTag, string sShout = "")
{
    object oDoor = GetObjectByTag("ar2504_prisoner_door");

    int nNth = 1;
    object oCreature = GetNearestObjectByTag(sTag, oDoor, nNth);

    if (sShout != "")
    {
        AssignCommand(oCreature, SpeakString(sShout));
    }

    while (GetIsObjectValid(oCreature))
    {
        if (!GetIsDead(oCreature))
        {
            ChangeToStandardFaction(oCreature, STANDARD_FACTION_DEFENDER);
            AssignCommand(oCreature, DetermineCombatRound());
        }
        nNth += 1;
        oCreature = GetNearestObjectByTag(sTag, oDoor, nNth);
    }
}
