#include "x0_i0_petrify"

void main()
{
    object oPC=GetFirstPC();

    switch(GetUserDefinedEventNumber())
    {
        //Jonas killed
        case 5200:
            SetLocalInt(GetModule(), "iJonasDead",1);
            if((GetLocalInt(GetModule(), "iJuniorDead") == 1) &&
               GetLocalInt(GetModule(), "iGraviaDead") == 1)
            {
                AddJournalQuestEntry("j55", 9, oPC);
            }
        break;

        //Jonas Junior killed
        case 5201:
            SetLocalInt(GetModule(), "iJuniorDead",1);
            if((GetLocalInt(GetModule(), "iJonasDead") == 1) &&
               GetLocalInt(GetModule(), "iGraviaDead") == 1)
            {
                AddJournalQuestEntry("j55", 9, oPC);
            }
        break;

        //Gravia killed
        case 5202:
            SetLocalInt(GetModule(), "iGraviaDead",1);
            if((GetLocalInt(GetModule(), "iJonasDead") == 1) &&
               GetLocalInt(GetModule(), "iJuniorDead") == 1)
            {
                AddJournalQuestEntry("j55", 9, oPC);
            }
        break;
    }
}
