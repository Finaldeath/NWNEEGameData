// onDeath event for bandit campers in AR1100
// .. update teygan's journal entry when all the bandits are dead

void main()
{
    int nAllDead = TRUE;
    int i = 0;
    object oBandit = GetObjectByTag("_ar1100_bandit", i);
    while (GetIsObjectValid(oBandit))
    {
        if (!GetIsDead(oBandit))
        {
            nAllDead = FALSE;
            break;
        }
        oBandit = GetObjectByTag("_ar1100_bandit", ++i);
    }
    if (nAllDead)
    {
        object oPC = GetFirstPC();
        AddJournalQuestEntry("j8", 2, oPC);
        SetLocalInt(GetModule(), "teygan_bandits", 1);
    }

    // execute the standard death script
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
