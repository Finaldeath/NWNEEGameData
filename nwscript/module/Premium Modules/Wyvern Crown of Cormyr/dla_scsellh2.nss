////////////////////////////////////////////////////////////////////////////////
// dla_scsellh2 - Sell horses - no more horses to select
// Scripted By: Deva B. Winblood  8/3/2006
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
    object oHorse=GetLocalObject(OBJECT_SELF,"oInterested");
    if (!GetIsObjectValid(oHorse)) return TRUE;
    return FALSE;
}
