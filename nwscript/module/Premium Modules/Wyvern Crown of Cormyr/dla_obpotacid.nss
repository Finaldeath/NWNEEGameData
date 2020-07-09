// October 2003
// B W-Husey
// Fills bottles with Acid

#include "CU_FUNCTIONS"

void main()
{
    object oPC = GetLastDisturbed();
    object oItem = GetInventoryDisturbItem();
    effect eVis = EffectVisualEffect(VFX_IMP_ACID_S);
    if (GetLocalInt(OBJECT_SELF,"nFrenzyPoCount")<4) {
        if (GetTag(oItem) == "EmptyBottle")
        {
        if (GetLocalInt(OBJECT_SELF,"nFrenzyPoCount")==0) PartyGotEntry("nAcidPotionXP1",oPC, 50, "XP Gain - Resourcefulness"); //Give xp
            SetLocalInt(OBJECT_SELF,"nFrenzyPoCount",GetLocalInt(OBJECT_SELF,"nFrenzyPoCount")+1);
            DestroyObject(oItem,0.3);
            CreateItemOnObject("x1_wmgrenade001",OBJECT_SELF,1);
        }
        else if(GetPlotFlag(oItem) != TRUE)
        {
            DestroyObject(oItem,0.3);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,OBJECT_SELF);
        }
    }
}



