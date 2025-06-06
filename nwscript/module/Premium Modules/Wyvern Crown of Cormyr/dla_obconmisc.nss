//October 2005
//B W-Husey
//Creates miscellaneous treasure in container. 0, 1 or 2 items.
// Search dependent lucky find of minor treasure.

#include "CU_FUNCTIONS"
#include "CU_TREASURE"
#include "x2_inc_compon"
#include "CU_MAGICSPECIFIC"

void main()
{
int nEmptied;
if (GetLocalInt(OBJECT_SELF,"nEmptied")<1){
//==========This section gives the PC chance of having a lucky find
    int nRand = Random (100);
    object oPC = GetLastOpenedBy();
    int nBonus = GetSkillRank(SKILL_SEARCH,oPC);
    if (GetHasFeat(FEAT_LUCKY,oPC)) {nBonus=nBonus+5;}
    if (GetHasFeat(FEAT_LUCK_OF_HEROES,oPC)) {nBonus=nBonus+5;}
    if (nBonus > nRand){
    GiveXPToCreature (oPC, 45);
    FloatingTextStringOnCreature("XP Gained - lucky find amongst the contents, use of search skill/luck feats",oPC);
    GetTreasure("Minor",OBJECT_SELF,100,0,0);
    GetTreasureType("Misc", OBJECT_SELF, 10, 1, 1);
    }
//==========This section places treasure in the container
    GetTreasure("Misc",OBJECT_SELF,75,0,0);  //75% chance of a micsellaneous item
    GetTreasure("Misc",OBJECT_SELF,12,0,0);  //12% chance of a micsellaneous item
    SetLocalInt(OBJECT_SELF,"nEmptied",1);   // Container has been raided
    }
    if (GetObjectType(OBJECT_SELF)==OBJECT_TYPE_PLACEABLE) craft_drop_placeable(); //Can be broken for crafting item
}
