void main()
{
    object oGoblin = GetObjectByTag("CharmedGoblin");
    AssignCommand(GetFirstPC(),
        ActionCastSpellAtObject(SPELL_CHARM_PERSON_OR_ANIMAL, oGoblin,METAMAGIC_ANY,TRUE,20,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));

}
