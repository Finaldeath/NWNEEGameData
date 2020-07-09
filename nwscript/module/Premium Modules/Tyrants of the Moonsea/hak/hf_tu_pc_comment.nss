void main()
{
    object oEnter = GetEnteringObject();

    if (GetIsPC(oEnter))
    {
        if (!GetIsInCombat(oEnter))
        {
            string sText = GetName(OBJECT_SELF);
            AssignCommand(oEnter, ClearAllActions());
            AssignCommand(oEnter, SpeakString(sText));
            DestroyObject(OBJECT_SELF);
        } else {
            if (GetLocalInt(OBJECT_SELF, "HF_REPEATING") == 0)
            {
                DestroyObject(OBJECT_SELF);
            }
        }
    }
}
