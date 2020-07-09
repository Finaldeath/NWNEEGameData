//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ndt_tm_shrazgul
// DATE: November 9, 2005
// AUTH: Luke Scull
// NOTE: Updates journal on Shrazgul's death, and also
//       sets an Int that will fire the trigger in the
//       Old Catacombs which spawns Bane.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "x2_inc_compon"
#include "x0_i0_spawncond"
#include "hf_in_alignment"

const string DOOR_TAG_SHRAZ_LAIR = "ShrazgulsLair_To_OldCatacombs";

void main()
{
    int nClass = GetLevelByClass(CLASS_TYPE_COMMONER);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    object oKiller = GetLastKiller();

    // If we're a good/neutral commoner,
    // adjust the killer's alignment evil
    if(nClass > 0 && (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL))
    {
        AdjustPlayerAlignment(oKiller, ALIGNMENT_EVIL, 5);
    }

    // Call to allies to let them know we're dead
    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);

    //Shout Attack my target, only works with the On Spawn In setup
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);

    // NOTE: the OnDeath user-defined event does not
    // trigger reliably and should probably be removed
    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
         SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    }
    SetLocalInt(GetFirstPC(), "shrazguldead", 1);
    AddJournalQuestEntry("EvilBeneathVoonlar", 40, GetFirstPC());
    craft_drop_items(oKiller);

    // Open Door and let player leave
    object oDoor = GetObjectByTag(DOOR_TAG_SHRAZ_LAIR);
    AssignCommand(oDoor, SetLocked(oDoor, FALSE));
    DelayCommand(0.5, AssignCommand(oDoor, ActionPlayAnimation(ANIMATION_DOOR_OPEN1)));

}
