#include "dla_i0_feats"
void main()
{
    object oPC = GetExitingObject();
    object oDummy = GetObjectByTag("dla_strengthdummy");
    string sChamp = GetLocalString(OBJECT_SELF,"sDummyChamp");
    string sNewChamp = "Sir "+RandomName();
    int nRecord = GetLocalInt(oDummy,"nDummyDamageRecord");
    int nNewRecord = nRecord +d6(2);
    if(!GetIsPC(oPC))
    {
        return;
    }
    //remove granted simple prof for the dart game
    DLA_TakeFeat(oPC, IP_CONST_FEAT_WEAPON_PROF_SIMPLE);

    //randomly reset the dummy challenge
    if(GetLocalInt(oPC,"nDummyChamp") && d3()==1)
    {
        DeleteLocalInt(oPC,"nDummyChamp");
        SetLocalInt(oDummy,"nDummyDamageRecord",nNewRecord);
        SetLocalString(oDummy,"sDummyChamp",RandomName());
        SetName(oDummy, sNewChamp+": "+IntToString(nNewRecord)+" damage");
    }
    //remove all gamedarts
    object oDart = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oDart))
    {
        if(GetTag(oDart)=="dla_gamedart")
        {
            DestroyObject(oDart);
        }
        oDart = GetNextItemInInventory(oPC);
    }
    oDart = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    if(GetTag(oDart)=="dla_gamedart")
    {
        DestroyObject(oDart);
    }
}
