#include "x0_i0_position"
#include "hf_in_graphics"

void main()
{
    int i = 1;
    object oTanarukk = GetNearestObjectByTag("ks_gate_tanarukk", OBJECT_SELF, i);

    if (GetIsObjectValid(oTanarukk) && !GetIsDead(oTanarukk))
    {
        // there is at least one tanarukk alive
        return;
    }

    while (GetIsObjectValid(oTanarukk))
    {
        if (!GetIsDead(oTanarukk))
        {
            // there is at least one tanarukk alive
            return;
        }
        oTanarukk = GetNearestObjectByTag("ks_gate_tanarukk", OBJECT_SELF, ++i);
    }

    // time to spawn gorgo
    if (GetLocalInt(OBJECT_SELF, "nDone") == 0)
    {
        SetLocalInt(OBJECT_SELF, "nDone", 1);
        object oPC = GetFirstPC();
        location lLoc = GetOppositeLocation(oPC);
        object oGorg = CreateObject(OBJECT_TYPE_CREATURE, "ks_gorgomorz", lLoc);
        ChangeToStandardFaction(oGorg, STANDARD_FACTION_HOSTILE);
        AssignCommand(oGorg, PlaySound("c_devil_bat1"));
        AssignCommand(oGorg, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), lLoc);
        DrawCircle(lLoc, 3.0, VFX_IMP_FLAME_M);
    }
    DestroyObject(OBJECT_SELF, 1.0);
}
