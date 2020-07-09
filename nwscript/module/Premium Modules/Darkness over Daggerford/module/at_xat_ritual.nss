// xatuum takes the heart and performs the ritual

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    object oAltar = GetNearestObjectByTag("ks_bhaal_altar", oPC);
    if (GetIsObjectValid(oAltar))
    {
        ActionPauseConversation();
        ActionDoCommand(SetFacingPoint(GetPosition(oAltar)));
        PlaySound("as_pl_evilchantm");
        ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 4.0);
        ActionResumeConversation();
    }

    DestroyObject(GetItemPossessedBy(oPC, "rb_maerheart"));
    DestroyObject(GetItemPossessedBy(oPC, "rb_boarheart"));
    PlotLevelSet("ks_xatuum", 4);
    SetLocalInt(GetModule(), "StrongholdQuest_bhaal", 0);
}
