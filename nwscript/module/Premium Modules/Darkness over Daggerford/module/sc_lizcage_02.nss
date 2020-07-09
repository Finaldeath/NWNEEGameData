// is the lizard cage in the slaver's hut open?
// .. the door is deleted when it is "opened"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oDoor = GetNearestObjectByTag("ks_pl_lizcage_door", oPC);
    return(!GetIsObjectValid(oDoor));
}
