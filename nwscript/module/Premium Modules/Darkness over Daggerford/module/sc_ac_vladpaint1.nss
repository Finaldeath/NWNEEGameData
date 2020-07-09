//::///////////////////////////////////////////////
//:: FileName sc_ac_vladpaint1
//:: See whether play on Vlad's painting quest
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/15/2005 2:23:51 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_vlad_paint_quest") == 1))
        return FALSE;

    return TRUE;
}
