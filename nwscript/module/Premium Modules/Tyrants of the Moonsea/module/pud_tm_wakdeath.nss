//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: pud_tm_wakdeath
// DATE: October 19, 2018
// AUTH: Rich Barker
// NOTE: Handle relevant actions on Wak's death
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_spells"

void main()
{
    switch(GetUserDefinedEventNumber())
    {
        case 4000 :
            object oDoor = GetObjectByTag("TempleDistrict_To_TheDreadspire");
            object oPC = GetFirstPC();
            object oPitFiend = GetObjectByTag("PitFiend");
            object oInnovator = GetObjectByTag("DreadspireTheInnovatorofPain");

            //Destroy Pit Fiend
            DestroyObject(oPitFiend, 0.0);

            //Remove visual effects from outer door to Dreadspire
            RemoveSpecificEffect(EFFECT_TYPE_VISUALEFFECT, oDoor);

            // Apply a visual effect to player to signify the end of the Geas
            DelayCommand(1.0,
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION), oPC));

            // Update Madmen and Villains journal entry
            DelayCommand(3.0, AddJournalQuestEntry("CrazedOldMan", 35, oPC));
            DelayCommand(6.0, FloatingTextStringOnCreature("The Geas has been lifted!", oPC));

            // Remove Innovator of Pain's plot flag
            DelayCommand(3.5, SetPlotFlag(oInnovator, FALSE));
            DelayCommand(4.0,
                AssignCommand(oInnovator, SpeakString("Damn! That incompetent fool!", TALKVOLUME_SHOUT)));
        break;
    }
}
