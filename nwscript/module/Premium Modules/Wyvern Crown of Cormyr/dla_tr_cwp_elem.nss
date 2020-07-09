#include "x0_i0_position"

void CreateElemental(object oCreature)
{
    CreateObject(OBJECT_TYPE_CREATURE, "dla_elem_fire", GetAheadLocation(oCreature));
}

void main()
{
    if (GetLocalInt(OBJECT_SELF, "bActivated")) return;
    object oCreature = GetEnteringObject();
    if (GetObjectType(oCreature) != OBJECT_TYPE_CREATURE) return;
    SetLocalInt(OBJECT_SELF, "bActivated", TRUE);
    string sTag = "CWPWyvern" + GetStringRight(GetTag(OBJECT_SELF), 1);
    object oWyvern = GetObjectByTag(sTag);
    if (!GetIsObjectValid(oWyvern)) return;
    AssignCommand(oWyvern, ActionCastFakeSpellAtObject(SPELL_FIREBALL, oCreature));
    DelayCommand(0.5, CreateElemental(oCreature));
    DelayCommand(0.6, AssignCommand(oWyvern, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));
}
