//::///////////////////////////////////////////////
//:: Cutscene system - Default module OnCutsceneAbort script
//:: _cs_oncsabort.nss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is the default OnCutsceneAbort script.

*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Dec. 9, 2003
//:://////////////////////////////////////////////
#include "_inc_cutscene"

void main()
{
    object oAborter = GetLastPCToCancelCutscene();
    int iGarmFight = GetLocalInt(oAborter, "A1_WATCHING_FIGHT");

    if (iGarmFight == TRUE)
    {
        ExecuteScript("exe_a1nwtchfight", oAborter);
    }

    cs_ModuleOnCutsceneAbort(GetLastPCToCancelCutscene());
}

