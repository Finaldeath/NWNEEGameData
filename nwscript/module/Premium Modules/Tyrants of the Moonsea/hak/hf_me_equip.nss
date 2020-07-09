// module equip event; runs tag-based activation and special item variable activations

#include "x2_inc_switches"

void main()
{
    object oItem = GetPCItemLastEquipped();
    object oPC   = GetPCItemLastEquippedBy();

    // play custom item equip VFX
    int nVfx = GetLocalInt(oItem, "HF_ITEM_EQUIP_VFX");
    if (nVfx > 0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(nVfx), oPC);
    }

    // play custom item equip SFX
    string sSfx = GetLocalString(oItem, "HF_ITEM_EQUIP_SFX");
    if (sSfx != "")
    {
        AssignCommand(oPC, PlaySound(sSfx));
    }

    // run custom item equip script
    string sScript = GetLocalString(oItem, "HF_ITEM_EQUIP_SCRIPT");
    if (sScript != "")
    {
        int nRet = ExecuteScriptAndReturnInt(sScript, OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
            return;
        }
    }

    // run the standard tag-based item activtation scripts
    if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
    {
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_EQUIP);
        int nRet = ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
            return;
        }
    }
}
