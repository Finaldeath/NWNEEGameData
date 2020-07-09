//::///////////////////////////////////////////////
//:: FileName dla_scmatroncomp
//::
//:: Created By: B W-Husey
//:: Created On: 30/04/2006 12:08:07
//:: A complete dialogue node for the Matron on getting Londro's Oath
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "XP3Londro") > 0))
        return FALSE;

    return TRUE;
}
