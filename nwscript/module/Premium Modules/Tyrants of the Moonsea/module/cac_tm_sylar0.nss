//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_sylar
//::////////////////////////////////////////////////////
//:: Sylar either flees or is killed depending on
//:: Using HF_ARG to keep track of PCs choice
//::////////////////////////////////////////////////////

const string NPC_TAG_ASSOCIATE = "tm_cr_sylarassoc";

void main()
{
    object oSylar = OBJECT_SELF;
    object oSylarAssociate = GetNearestObjectByTag(NPC_TAG_ASSOCIATE, oSylar);

    GiveXPToCreature(GetPCSpeaker(), 250);

    // Decide what to do with Sylar
    int nHF_ARG = GetLocalInt(OBJECT_SELF, "HF_ARG");
    switch (nHF_ARG)
    {
        case 2: // PC kills Sylar
        {
            effect eDeath = EffectDeath();

            SetPlotFlag(oSylar, FALSE);
            SetImmortal(oSylar, FALSE);

            DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oSylar));
            break;
        }
        case 1: // PC lets Sylar live, he leaves
        default: // Default case is letting him live
        {
            SetLocalInt(oSylar, "HF_EXIT_RUN", 1);
            ExecuteScript("hf_cs_exit", oSylar);
            break;
        }
    }

    // Sylar Associate always flees
    SetLocalInt(oSylarAssociate, "HF_EXIT_RUN", 1);
    DelayCommand(1.0f, ExecuteScript("hf_cs_exit", oSylarAssociate));
}
