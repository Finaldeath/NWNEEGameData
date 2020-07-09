//::///////////////////////////////////////////////
//:: cex_a0_tasthugb
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    End the intro dialog cutscene with the thugs
    in the Golden Appple.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_cutscene"

void EndCutscene();
void main()
{
    object oSelf = OBJECT_SELF;
    object oArea = GetArea(oSelf);
    int iDoOnce = GetLocalInt(oArea, "cex_a0_tasthugb");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oArea, "cex_a0_tasthugb", TRUE);
        AssignCommand(oArea, EndCutscene());
    }
}

void EndCutscene()
{
    cs_CameraDoFade(1.0f, CS_FADE_TYPE_TO_BLACK);
    cs_EndCutscene(3.0f, FALSE, TRUE);
}
