//October 2005
//B W-Husey
//Creates miscellaneous treasure in container. Gold and gems.
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
    GetTreasure("Gold100",OBJECT_SELF,100,d6()*30);  //1-100+30-180 gold
    GetTreasure("Gem",OBJECT_SELF,25);  //25% chance of gems
    SetLocalInt(OBJECT_SELF,"nEmptied",1);   // Container has been raided
    }
    if (GetObjectType(OBJECT_SELF)==OBJECT_TYPE_PLACEABLE) craft_drop_placeable(); //Can be broken for crafting item
}
