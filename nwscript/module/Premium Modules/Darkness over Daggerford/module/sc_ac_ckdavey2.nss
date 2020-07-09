//::///////////////////////////////////////////////
//:: FileName sc_ac_ckdavey1
//:: Check whether player paid off Vladmyr
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/15/2005 2:02:46 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_davey_quest") == 2))
        return FALSE;

    return TRUE;
}
