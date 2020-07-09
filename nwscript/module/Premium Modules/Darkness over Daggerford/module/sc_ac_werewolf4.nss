//::///////////////////////////////////////////////
//:: FileName sc_ac_werewolf4
//:: See if player escaped maze
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/4/2005 2:40:47 PM
//:://////////////////////////////////////////////
int StartingConditional()
{
    if(GetLocalInt(GetModule(), "ac_werewolf") == 4)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
