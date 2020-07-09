//::///////////////////////////////////////////////
//:: cut_a2_tas1_end
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Act 2 cutscene where player meets Tasina
    as she's about to leave. (end script)
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 17/05
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    // should I start the tas2 cutscene?
    if(GetLocalInt(OBJECT_SELF, "nNextCutscene") == 2)
    {
        cs_SetOption(CS_OPTION_RESTORE_PC_LOCATION, TRUE);
        cs_PreCutsceneFade(CS_FADE_TYPE_BLACK);
        cs_StartCutscene_Poly("cut_a2_tas2", "cut_a2_tas2_end", 1.0, TRUE, TRUE, 2);
    }
    else
    {
        object oRealNisar = GetObjectByTagInArea(a2c_tag_Nisar);
        object oRealGarm = GetObjectByTagInArea(a1c_tag_Garm);
        object oNisarCopy = GetObjectByTagInArea("nisar_copy");
        object oGarmCopy = GetObjectByTagInArea("garm_copy");

        // move people into end positions
        AssignCommand(oRealNisar, ClearAllActions(TRUE));
        AssignCommand(oRealNisar, ActionJumpToLocation(GetLocation(oNisarCopy)));
        AssignCommand(oRealGarm, ClearAllActions(TRUE));
        AssignCommand(oRealGarm, ActionJumpToLocation(GetLocation(oGarmCopy)));

        // destroy henchmen copies
        DestroyObject(oNisarCopy);
        DestroyObject(oGarmCopy);
    }

    // Remove the Midnight Rose from Spindrift town
    // This happens regardless of what the player chose in the Tasina
    // conversation, which is why this is not in the if statement above.
    object oArea = GetObjectByTag("SpindriftIslandSpindrift");

    object oFront = GetObjectByTagInArea(a2p_MidnightRose_Front, oArea);
    object oBack = GetObjectByTagInArea(a2p_MidnightRose_Back, oArea);
    object oMid = GetObjectByTagInArea(a2p_MidnightRose_Mid, oArea);

    DestroyObject(oFront);
    DestroyObject(oBack);
    DestroyObject(oMid);

}
