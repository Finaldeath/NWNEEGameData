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
    cs_ModuleOnCutsceneAbort(GetLastPCToCancelCutscene());
}
