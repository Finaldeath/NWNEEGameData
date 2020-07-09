//::///////////////////////////////////////////////
//:: cac_a0_pscintroc
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    End the intro dialog cutscene with alledry.
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
    int iDoOnce = GetLocalInt(oArea, "cac_a0_pscintroc");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oArea, "cac_a0_pscintroc", TRUE);
        AssignCommand(oArea, EndCutscene());
    }
}

void EndCutscene()
{
    cs_CameraDoFade(0.875f, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);

    // JE: Destroy PC copies manually, slightly before the cutscene ends.
    // This will prevent the player from seeing their copy fade out.
    object oPCCopy = GetObjectByTagInArea("pccopy", OBJECT_SELF, 0);
    int i=0;
    while(GetIsObjectValid(oPCCopy))
    {
        cs_DestroyObject(1.2, oPCCopy);
        i++;
        oPCCopy = GetObjectByTagInArea("pccopy", OBJECT_SELF, i);
    }

    cs_EndCutscene(3.25f, FALSE, TRUE);
}
