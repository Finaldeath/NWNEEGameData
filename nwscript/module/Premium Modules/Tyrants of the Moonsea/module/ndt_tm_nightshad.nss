//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ndt_tm_nightshad
//:: DATE: March 7, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Nightshade death script
//:: Transforms appearance to Malaugrym
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const int NIGHTSHADE_APPEARANCE_MALAUGRYM = 15036;
const string NIGHTSHADE_PORTRAIT_MALAUGRYM = "po_malaugrym_";

void main()
{ 
    object oNightshade = OBJECT_SELF;

    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oNightshade);
    SetCreatureTailType(CREATURE_TAIL_TYPE_NONE, oNightshade);
    SetCreatureAppearanceType(oNightshade, NIGHTSHADE_APPEARANCE_MALAUGRYM);
    
    SetPortraitResRef(oNightshade, NIGHTSHADE_PORTRAIT_MALAUGRYM);

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
