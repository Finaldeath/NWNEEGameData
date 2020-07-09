// only spawn when a certain creature is alive in the area

void main()
{
    string sTag = GetLocalString(OBJECT_SELF, "HF_NPC_TAG");
    object oCreature = GetObjectByTag(sTag);
    if (GetIsObjectValid(oCreature))
    {
        if (!GetIsDead(oCreature))
        {
            SetLocalInt(OBJECT_SELF, "HF_RETVAL", 1);
        }
        else
        {
            SetLocalInt(OBJECT_SELF, "HF_RETVAL", 0);
        }
    }
    else
    {
        SetLocalInt(OBJECT_SELF, "HF_RETVAL", 0);
    }
}
