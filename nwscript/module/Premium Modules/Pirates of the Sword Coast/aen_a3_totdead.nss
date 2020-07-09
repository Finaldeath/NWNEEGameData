//::///////////////////////////////////////////////
//:: aen_a3_totdead
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player has entered the sepultcre on the
    Island of the Dead. The party has fallen
    into Kolmarr's trap and are made undead.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////
#include "inc_balance"
#include "inc_global"

void main()
{
    object oModule = GetModule();
    object oSelf = OBJECT_SELF;
    object oPC = GetEnteringObject();
    object oKolmarr = GetObjectByTag("a3_necro_fight");
    object oWayPoint, oNPC;

    effect eGhost = EffectCutsceneGhost();
    effect eVFX = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);

    int iFlag = GetLocalInt(oSelf, "aen_a3_totdead");
    int iCounter = 0;

    location lWP;
    string sNPCTag;

    cs_AreaOnEnter_Poly(oPC);

    if ((GetIsPCNotDM(oPC)== TRUE) && (iFlag == FALSE))
    {
        LevelUpNPC(oKolmarr);

        while (iCounter < 6)
        {
            SetLocalInt(oSelf, "aen_a3_totdead", TRUE);

            iCounter = iCounter + 1;

            oWayPoint = GetWaypointByTag("A3_NFIGHT_NPC" + IntToString(iCounter));
            sNPCTag = GetLocalString(oModule, "NPC_CREW" + IntToString(iCounter));

            oNPC = GetObjectByTag(sNPCTag);
            AssignCommand(oNPC, SetIsDestroyable(TRUE, FALSE, FALSE));
            DestroyObject(oNPC, 1.0f);

            lWP = GetLocation(oWayPoint);
            oNPC = CreateObject(OBJECT_TYPE_CREATURE, sNPCTag,
                lWP, FALSE, "PLACEHOLDER_" + IntToString(iCounter));

            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oNPC);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX, oNPC);

        }

        cs_PreCutsceneFade(CS_FADE_TYPE_BLACK);
        cs_StartCutscene_Poly("cut_a3_undead1", "exe_a3_dead40", 3.0f, FALSE, FALSE, 10, oSelf);
    }
}
