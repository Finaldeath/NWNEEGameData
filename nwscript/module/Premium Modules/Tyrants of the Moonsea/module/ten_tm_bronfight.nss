//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_bronfight
// DATE: August 29, 2005
// AUTH: Luke Scull
// NOTE: Spawns in Zhents once PC has spoken to Madoc in inn.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "nw_i0_2q4luskan"


const string NPC_RESREF_BRONFIGHT_BRON = "thebron";
const string WP_TAG_BRONFIGHT_BRON_INIT = "WP_bronfight_bron_init";


// spawn a creature at the location and make it immune to mind spells
// .. because hostiles might charm the creature and force the player to
// .. fight it which will cause faction problems later
void CreateActor(string sResRef, string sWP)
{
    object oTarget = GetWaypointByTag(sWP);
    location lTarget = GetLocation(oTarget);
    object oCreature = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lTarget);
    effect eImmune = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(eImmune), oCreature);
}


void main()
{
    object oPC = GetEnteringObject();
    if (!GetIsPC(oPC))
        return;

    int nJournal = GetLocalInt(oPC, "NW_JOURNAL_ENTRYVoonlar");
    if ((nJournal < 20) || (GetLocalInt(OBJECT_SELF, "fired") == 1))
       return;

    SetLocalInt(OBJECT_SELF, "fired", 1);
    SetLocalInt(oPC, "nobronfollow", 1);

    // Close and lock the door to The Swords Meet inn
    object oDoorTheSwordsMeet = GetObjectByTag("Voonlar_To_TheSwordsMeet");
    AssignCommand(oDoorTheSwordsMeet, ActionCloseDoor(OBJECT_SELF));
    DelayCommand(0.5, SetLocked(oDoorTheSwordsMeet, TRUE));

    // Fade out screen and spawn in Zhents
    BlackScreen(oPC);

    object oTarget;
    location lTarget;

    DelayCommand(1.0, CreateActor("zhentarimfighter", "WP_Zhentarim1_Fight"));
    DelayCommand(1.0, CreateActor("zhentarimfighter", "WP_Zhentarim2_Fight"));
    DelayCommand(1.0, CreateActor("zhentarimmage", "WP_Zhentarim3_Fight"));
    DelayCommand(1.0, CreateActor("gormstadd", "WP_Gormstadd_Fight"));

    oTarget = GetWaypointByTag("WP_Madoc_Fight");
    lTarget = GetLocation(oTarget);
    DelayCommand(1.0, CreateObjectVoid(OBJECT_TYPE_CREATURE, "madoctheuncou001", lTarget));

    oTarget = GetWaypointByTag(WP_TAG_BRONFIGHT_BRON_INIT);
    lTarget = GetLocation(oTarget);
    DelayCommand(1.0, CreateObjectVoid(OBJECT_TYPE_CREATURE, NPC_RESREF_BRONFIGHT_BRON, lTarget));
    DelayCommand(1.5, AssignCommand(oPC, SetCameraFacing(270.0, 9.0, 50.0)));

    // Fade in again
    DelayCommand(2.0, FadeFromBlack(oPC));

    // Fire Bron buffing/attack script
    DelayCommand(3.0, ExecuteScript("exe_tm_bronattck", GetFirstPC()));
}
