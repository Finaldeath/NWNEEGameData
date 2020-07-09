//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_ilandra_b
//:: DATE: April 13, 2019
//::////////////////////////////////////////////////////
//:: Checks wether Blizzard is near = availabe in
//:: a conversation.
//::////////////////////////////////////////////////////

int StartingConditional()
{
    object oBlizzard = GetNearestObjectByTag("Blizzard");
    object oPC = GetPCSpeaker();

    return ( (GetIsObjectValid(oBlizzard)) &&
             (GetDistanceBetween(oBlizzard, oPC) < 5.0f) );
}
