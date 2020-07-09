#include "inc_global"

void main()
{
    object oArea = GetObjectByTag("TheLighthouse");
    object oPC = GetFirstPC();
    while(GetIsObjectValid(oPC))
    {
        if(GetArea(oPC) == oArea)
        {
            // from cac_a2_tlset.nss
            cs_PreCutsceneFade(CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);
            cs_SetOption(CS_OPTION_RESTORE_PC_LOCATION, TRUE);
            cs_StartCutscene_Poly("cut_a2_puzzw", "cut_a2_puzzw_end", 1.0, TRUE);
            return;
        }
        oPC = GetNextPC();
    }
}
