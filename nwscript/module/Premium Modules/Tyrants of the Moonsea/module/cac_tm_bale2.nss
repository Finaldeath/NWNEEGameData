// npc equips a melee weapon during conversation

void main()
{
    object oNoble = GetNearestObjectByTag("ResistanceArmyNobleFemale", OBJECT_SELF);
    AssignCommand(oNoble, ActionEquipMostDamagingMelee());
}
