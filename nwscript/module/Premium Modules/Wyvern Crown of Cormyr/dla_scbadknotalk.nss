//::///////////////////////////////////////////////
//:: FileName dla_scbadknotalk
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: B W-Husey
//:: Created On: 04/03/2006 14:59:47
//:: NPC will not talk, as the case is closed (Family Grave)
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nHandOver") == 1))
        return FALSE;

    return TRUE;
}
