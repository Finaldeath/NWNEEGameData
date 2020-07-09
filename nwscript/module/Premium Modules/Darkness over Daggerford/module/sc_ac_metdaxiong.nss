//::///////////////////////////////////////////////
//:: FileName sc_ac_metdaxiong
//:: See if the player has met Daxiong
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/17/2005 4:21:04 PM
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oDax = GetObjectByTag("ac_daxiong");
    if (!GetIsObjectValid(oDax) || GetIsDead(oDax))
    {
        // player must have killed Daxiong (or convinced him to leave)
        return(TRUE);
    }

    if(GetLocalInt(oDax, "has_met_pc") == 1)
    {
        return TRUE;
    }

    return FALSE;
}
