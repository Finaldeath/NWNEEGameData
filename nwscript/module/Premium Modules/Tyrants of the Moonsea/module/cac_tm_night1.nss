//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_night1
//:: DATE: January 28, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: The Unseen
//:: Nightshade shapechanges and attacks the player
//::////////////////////////////////////////////////////

const int NIGHTSHADE_APPEARANCE_INVIS = 852;
const int NIGHTSHADE_TAILMODEL_MAGGRIS = 395;
const string NIGHTSHADE_PORTRAIT_MAGGRIS = "po_maggris_";


void main()
{
    object oPC = GetPCSpeaker();
    object oNightshade = OBJECT_SELF;

    SetLocalInt(oNightshade, "nBusy", 1);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oNightshade);
    SetCreatureAppearanceType(oNightshade, NIGHTSHADE_APPEARANCE_INVIS);
    SetCreatureTailType(NIGHTSHADE_TAILMODEL_MAGGRIS, oNightshade);
    SetPortraitResRef(oNightshade, NIGHTSHADE_PORTRAIT_MAGGRIS);

    DelayCommand(2.0, ExecuteScript("hf_ut_hostile", oNightshade));
}
