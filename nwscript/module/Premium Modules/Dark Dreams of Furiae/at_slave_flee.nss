// have to also shift CHAOS and GOOD
#include "ddf_util"

void CreateEmptySlaveStockades(location lLocation)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, "x3_plc_stocks001", lLocation);
}

void main()
{
    // Slave flee!

    // Free all the slaves...
    int iCounter = 0;
    object oNPC = GetObjectByTag("SlaveSurgery", iCounter);

    while(GetIsObjectValid(oNPC))
    {
        DestroyObject(oNPC, 2.0f);
        iCounter = iCounter + 1;
        oNPC = GetObjectByTag("SlaveSurgery", iCounter);
    }

    iCounter = 0;
    oNPC = GetObjectByTag("ddf_aladara_stock_slave", iCounter);
    object oNewObject;

    while(GetIsObjectValid(oNPC))
    {
        //location lTemp = GetLocation(oNPC);
        //DelayCommand(2.0f, CreateEmptySlaveStockades(lTemp));
        oNewObject = CreateObject(OBJECT_TYPE_PLACEABLE, "x3_plc_stocks001", GetLocation(oNPC));
        if(GetIsObjectValid(oNewObject) == FALSE) debug("-- wasn't able to make new stockaide thignie.");
        DestroyObject(oNPC, 2.0f);
        iCounter = iCounter + 1;
        oNPC = GetObjectByTag("ddf_aladara_stock_slave", iCounter);
    }

    //ActionMoveToObject(GetObjectByTag("NW_ALAD_CHOP_SHOP"), TRUE);
    //DelayCommand(5.0, DestroyObject(OBJECT_SELF));

    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_GOOD, ALIGNMENT_SLIGHT, TRUE);
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_CHAOTIC, ALIGNMENT_SLIGHT, TRUE);

}
