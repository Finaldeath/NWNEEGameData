// March 2004
// B W-Husey
// Conversation starts only if not in combat.

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(GetIsInCombat(GetPCSpeaker())==TRUE)
        return FALSE;

    return TRUE;
}
