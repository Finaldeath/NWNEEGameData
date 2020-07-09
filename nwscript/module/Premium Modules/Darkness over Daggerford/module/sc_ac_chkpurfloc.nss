//::///////////////////////////////////////////////
//:: FileName sc_ac_chkpurfloc
//:: Check whether first meeting Purfbin on the Trade Way.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 1/7/2006 2:02:46 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetTag(GetArea(GetPCSpeaker())) == "C1AR0099TradeWayNorth"))
        return FALSE;

    return TRUE;
}
