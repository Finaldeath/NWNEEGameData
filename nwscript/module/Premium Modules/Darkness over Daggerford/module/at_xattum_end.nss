// xatuum takes the blood and performs the ritual

#include "inc_bloodbag"
#include "hf_in_plot"
#include "hf_in_xp"

void main()
{
    object oPC = GetPCSpeaker();
    object oAltar = GetNearestObjectByTag("WP_AR1301A_VAULT", oPC);
    if (GetIsObjectValid(oAltar))
    {
        ActionPauseConversation();
        ActionDoCommand(SetFacingPoint(GetPosition(oAltar)));
        PlaySound("as_pl_evilchantm");
        ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 4.0);
        ActionResumeConversation();
    }
    EmptyBloodBag(oPC);
    PlotLevelSet("ks_xatuum", 3);
    SetLocalInt(GetModule(), "StrongholdQuest_bhaal", 0);
}
