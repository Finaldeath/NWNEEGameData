//::///////////////////////////////////////////////
//:: cac_a1_utnlkey
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    If Utnal still has his key Give it to the
    player.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
void main()
{
    object oUtnal = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    object oKey = GetItemPossessedBy(oUtnal, "a1_utnlkey");

    if (GetIsObjectValid(oKey) == TRUE)
    {
        SetLocalInt(GetModule(), "cac_a1_utnlkey", TRUE);
        CreateItemOnObject("a1_utnlkey", oPC);
        DestroyObject(oKey, 0.5f);
    }
}
