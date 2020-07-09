//::///////////////////////////////////////////////
//:: ten_a2_gdtdr_sht
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Goods Trader in the city of spindrift
    barks his sales pitch to passers by.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Aug, 2004
//:://////////////////////////////////////////////

void main()
{
    object oEnter = GetEnteringObject();
    object oGoodsTrader = GetObjectByTag("a2_goodstrader");

    if (GetIsPC(oEnter) == TRUE)
    {
        AssignCommand(oGoodsTrader, SpeakOneLinerConversation("a2_goodstrader", oEnter));
    }
}
