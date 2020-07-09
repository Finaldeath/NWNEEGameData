void main()
{
    SetLocalInt(OBJECT_SELF, "iCheckAttempted", 1);
    SetLocalInt(OBJECT_SELF, "iStrength", GetAbilityScore(GetPCSpeaker(), ABILITY_STRENGTH));
}
