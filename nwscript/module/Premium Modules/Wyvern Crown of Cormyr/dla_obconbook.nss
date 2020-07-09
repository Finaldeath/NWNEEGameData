//October 2005
//B W-Husey
//Creates miscellaneous book treasure in container.
// Search dependent lucky find of scroll.

#include "cu_magic"
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
    GetMagic("Scrolls2",OBJECT_SELF,100);
    }
//==========This section places treasure in the container
    GetMagic("Books",OBJECT_SELF,100,0,0);  //75% chance of a micsellaneous item
    SetLocalInt(OBJECT_SELF,"nEmptied",1);   // Container has been raided
    }
    if (GetObjectType(OBJECT_SELF)==OBJECT_TYPE_PLACEABLE) craft_drop_placeable(); //Can be broken for crafting item
}
