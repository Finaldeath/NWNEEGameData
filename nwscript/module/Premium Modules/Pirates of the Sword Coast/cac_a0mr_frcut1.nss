#include "_inc_cutscene"

void main()
{
    object oPC = GetPCSpeaker();
    object oDoor = GetObjectByTag("a0rn_chatdoor");

    SetLocalInt(oDoor, "iCutStart", TRUE);
    SetLocalObject(GetModule(), "MAGICPCOBJECT", oPC);

    cs_PreCutsceneFade(CS_FADE_TYPE_TO_BLACK, FADE_SPEED_MEDIUM, GetArea(OBJECT_SELF));
    // July 27/04, Jon: cs_StartCutscene parameters changed.
    //cs_StartCutscene(1.5f, TRUE, TRUE, "cut_mrseige1", "exe_cut2wrapper", 1, GetArea(OBJECT_SELF));
    cs_StartCutscene("cut_mrseige1", "exe_cut2wrapper", 1.5, TRUE, TRUE, 1, GetArea(OBJECT_SELF));
}
