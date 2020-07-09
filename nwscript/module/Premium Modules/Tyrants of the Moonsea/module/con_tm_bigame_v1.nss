//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_bigame_v1
//:: DATE: January 10, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Bug Game Hunt - Vaporandir dialogue
//:: Checks whether the PC has the fake tongue
//::////////////////////////////////////////////////////

const string ITM_TAG_FAKE_TONGUE = "";

int StartingConditional()
{
    return (GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),
                                                ITM_TAG_FAKE_TONGUE)));
}
