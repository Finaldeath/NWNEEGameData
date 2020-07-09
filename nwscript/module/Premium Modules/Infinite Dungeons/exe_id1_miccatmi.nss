#include "inc_id1_debug"
#include "inc_id1_creature"

void main()
{
//    DebugMessage("");
//    DebugMessage("====CREATURE CATALOG MICROPROCESS START====");
//    DebugMessage("");

    // get variables
    int nCreature = GetLocalInt(OBJECT_SELF, "nCreature");
    int nTheme = GetLocalInt(OBJECT_SELF, "nTheme");
    int nMinCR = GetLocalInt(OBJECT_SELF, "nMinCR");
    int nMaxCR = GetLocalInt(OBJECT_SELF, "nMaxCR");
    int bIntelligent = GetLocalInt(OBJECT_SELF, "bIntelligent");
    int bMediumSize = GetLocalInt(OBJECT_SELF, "bMediumSize");
    int nCreatureNum;
    string sCR;
    string sCreature;

//    DebugMessage("  Creature is " + IntToString(nCreature));
//    DebugMessage("  Theme is " + IntToString(nTheme));
//    DebugMessage("  Min CR is " + IntToString(nMinCR));
//    DebugMessage("  Max CR is " + IntToString(nMaxCR));

    // add creature to theme
    SetLocalInt(GetModule(), "bMiniBoss" + IntToString(nCreature) + "Theme" + IntToString(nTheme), TRUE);
    SetLocalInt(GetModule(), "bTheme" + IntToString(nTheme) + "MiniBoss" + IntToString(nCreature), TRUE);

    while (nMinCR <= nMaxCR)
    {
        sCR = "nTheme" + IntToString(nTheme) + "CR" + IntToString(nMinCR);

        // add creature to themes generic creature list
        sCreature = sCR + "MiniBoss";
        nCreatureNum = GetLocalInt(GetModule(), sCreature);
        nCreatureNum++;
        SetLocalInt(GetModule(), sCreature, nCreatureNum);

        sCreature += IntToString(nCreatureNum);
        SetLocalInt(GetModule(), sCreature, nCreature);
//        DebugMessage("  Setting " + sCreature + " to " + IntToString(nCreature));
/*
        if (bIntelligent == TRUE)
        {
            // add creature to themes intelligent creature list
            sCreature = sCR + "IntelligentMiniBoss";
            nCreatureNum = GetLocalInt(GetModule(), sCreature);
            nCreatureNum++;
            SetLocalInt(GetModule(), sCreature, nCreatureNum);

            sCreature += IntToString(nCreatureNum);
            SetLocalInt(GetModule(), sCreature, nCreature);
//            DebugMessage("  Setting " + sCreature + " to " + IntToString(nCreature));
        } else
        {
            // add creature to themes unintelligent creature list
            sCreature = sCR + "UnIntelligentMiniBoss";
            nCreatureNum = GetLocalInt(GetModule(), sCreature);
            nCreatureNum++;
            SetLocalInt(GetModule(), sCreature, nCreatureNum);

            sCreature += IntToString(nCreatureNum);
            SetLocalInt(GetModule(), sCreature, nCreature);
//            DebugMessage("  Setting " + sCreature + " to " + IntToString(nCreature));
        }

        if (bMediumSize == TRUE)
        {
            // add creature to themes medium size creature list
            sCreature = sCR + "MediumSizeMiniBoss";
            nCreatureNum = GetLocalInt(GetModule(), sCreature);
            nCreatureNum++;
            SetLocalInt(GetModule(), sCreature, nCreatureNum);

            sCreature += IntToString(nCreatureNum);
            SetLocalInt(GetModule(), sCreature, nCreature);
//            DebugMessage("  Setting " + sCreature + " to " + IntToString(nCreature));

            if (bIntelligent == TRUE)
            {
                // add creature to themes intelligent medium size creature list
                sCreature = sCR + "IntelligentMediumSizeMiniBoss";
                nCreatureNum = GetLocalInt(GetModule(), sCreature);
                nCreatureNum++;
                SetLocalInt(GetModule(), sCreature, nCreatureNum);

                sCreature += IntToString(nCreatureNum);
                SetLocalInt(GetModule(), sCreature, nCreature);
//                DebugMessage("  Setting " + sCreature + " to " + IntToString(nCreature));
            } else
            {
                // add creature to themes creature list
                sCreature = sCR + "UnIntelligentMediumSizeMiniBoss";
                nCreatureNum = GetLocalInt(GetModule(), sCreature);
                nCreatureNum++;
                SetLocalInt(GetModule(), sCreature, nCreatureNum);

                sCreature += IntToString(nCreatureNum);
                SetLocalInt(GetModule(), sCreature, nCreature);
//                DebugMessage("  Setting " + sCreature + " to " + IntToString(nCreature));
            }
        }
*/
        nMinCR++;
    }

    // increment, showing that this process is finished
    int nMicroDead = GetLocalInt(GetModule(), "nMicroDead");
    nMicroDead++;
    SetLocalInt(GetModule(), "nMicroDead", nMicroDead);

//    DebugMessage("");
//    DebugMessage("====CREATURE CATALOG MICROPROCESS END====");
//    DebugMessage("");

    // destroy this object
    DelayCommand(0.1, DestroyObject(OBJECT_SELF));
}
