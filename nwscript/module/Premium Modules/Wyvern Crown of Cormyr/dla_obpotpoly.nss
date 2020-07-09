// October 2005
// B W-Husey
// Fills bottles with Polymorph Juice

#include "CU_FUNCTIONS"

void main()
{
    object oPC = GetLastDisturbed();
    object oItem = GetInventoryDisturbItem();
    if (GetLocalInt(OBJECT_SELF,"nFrenzyPoCount")<1) {
        if (GetTag(oItem) == "EmptyBottle"){
        if (GetLocalInt(OBJECT_SELF,"nFrenzyPoCount")==0) PartyGotEntry("nPotionXP",oPC, 50, "XP Gain - Resourcefulness"); //Give xp for each pot but not each potion
        SetLocalInt(OBJECT_SELF,"nFrenzyPoCount",GetLocalInt(OBJECT_SELF,"nFrenzyPoCount")+1);
        DestroyObject(oItem,0.2);
        CreateItemOnObject("polymorphjuice",OBJECT_SELF,1);}
    }
}
