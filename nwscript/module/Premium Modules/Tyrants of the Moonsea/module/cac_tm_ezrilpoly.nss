//Transform Ezril into Eremuth
void main()
{
    object oEremuth = OBJECT_SELF;

    ActionPauseConversation();

    SetName(oEremuth, "Eremuth");
    SetPortraitResRef(oEremuth, "po_eremuth_");

    ActionPlayAnimation(ANIMATION_LOOPING_SPASM, 1.0, 2.0);
    ActionDoCommand(SetCreatureBodyPart(CREATURE_PART_HEAD, 6, oEremuth));
    ActionDoCommand(SetColor(oEremuth, COLOR_CHANNEL_HAIR, 1));
    ActionPlayAnimation(ANIMATION_LOOPING_SPASM, 1.0, 2.0);
    ActionDoCommand(SetCreatureBodyPart(CREATURE_PART_HEAD, 4, oEremuth));
    ActionDoCommand(SetColor(oEremuth, COLOR_CHANNEL_HAIR, 3));
    ActionPlayAnimation(ANIMATION_LOOPING_SPASM, 1.0, 2.0);

    ActionDoCommand(SetCreatureAppearanceType(oEremuth, APPEARANCE_TYPE_ELF));
    ActionPlayAnimation(ANIMATION_LOOPING_SPASM, 1.0, 2.0);
    ActionDoCommand(SetCreatureBodyPart(CREATURE_PART_HEAD, 16, oEremuth));
    ActionDoCommand(SetColor(oEremuth, COLOR_CHANNEL_HAIR, 37));
    ActionPlayAnimation(ANIMATION_LOOPING_SPASM, 1.0, 2.0);
    ActionDoCommand(SetCreatureBodyPart(CREATURE_PART_HEAD, 13, oEremuth));
    ActionDoCommand(SetColor(oEremuth, COLOR_CHANNEL_HAIR, 7));
    ActionDoCommand(SetColor(oEremuth, COLOR_CHANNEL_SKIN, 9));
    ActionDoCommand(
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(EFFECT_TYPE_POLYMORPH), oEremuth));
    ActionEquipItem(GetItemPossessedBy(oEremuth, "EremuthsRobe"), INVENTORY_SLOT_CHEST);

    ActionResumeConversation();
}
