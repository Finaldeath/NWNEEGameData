//Player turns Elf hostile in post-Tusk dialog

#include "NW_I0_GENERIC"

#include "hf_in_alignment"
#include "hf_in_friend"
#include "hf_in_plot"

void main()
{
    object oDirector = GetObjectByTag("KTDirector");

    AdjustPlayerAlignment(GetPCSpeaker(), ALIGNMENT_EVIL, 5);
    FriendSetMaster(OBJECT_INVALID, OBJECT_SELF);
    PlotLevelSet(GetTag(OBJECT_SELF), 0);
    DeleteLocalObject(oDirector, "oElf");

    ClearAllActions(TRUE);
    SetPlotFlag(OBJECT_SELF, FALSE);
    SetImmortal(OBJECT_SELF, FALSE);
    ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE);
    DetermineCombatRound(GetPCSpeaker());
}
