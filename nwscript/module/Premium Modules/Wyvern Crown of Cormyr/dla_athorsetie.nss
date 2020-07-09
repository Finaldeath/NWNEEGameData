//::///////////////////////////////////////////////
//:: Created By: Deva B. Winblood
//:: Created On: 7/30/2006 - based losely on work by Gale and B.G.Hughes
//:: Available in Thunderstone areas.
//:://////////////////////////////////////////////

#include "dla_i0_horse"
#include "dla_i0_horseai"
#include "cu_functions"


//////////////////////////
// PROTOTYPES
//////////////////////////




//////////////////////////////////////////////////////////////////////[ MAIN ]//
void main()
{
    object oPC=GetPCSpeaker();
    object oHitchingPost=GetNearestObjectByTag(DLA_TAG_HITCHING_POST);

    if (!GetIsObjectValid(oPC)) oPC=OBJECT_SELF;

    DLA_RemoveAllHenchmenHorses(oPC,oHitchingPost,TRUE);
    FloatingTextStringOnCreature("Horses are now tied to nearby hitching post", oPC, FALSE);
}
//////////////////////////////////////////////////////////////////////[ MAIN ]//

//////////////////////////
// FUNCTIONS
//////////////////////////
