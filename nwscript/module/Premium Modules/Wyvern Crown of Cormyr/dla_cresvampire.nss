//::///////////////////////////////////////////////
//:: NW_C2_VAMPIRE7.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Vampire turns into a vampire shadow
    that looks for the nearest coffin
    with the same tag as the shadow.
*/
//:://////////////////////////////////////////////
//:: Modified By: B W-Husey
//:: To allow use of different tags
//:://////////////////////////////////////////////
void main()
{
    if(GetLocalInt(OBJECT_SELF,"bNoVampRespawn"))
    {
        DestroyObject(OBJECT_SELF, 0.5);
        return;
    }
    object oGas = CreateObject(OBJECT_TYPE_CREATURE, "VAMPIRE_SHADE",GetLocation(OBJECT_SELF),FALSE,GetTag(OBJECT_SELF)+"_SHAD");
    SetLocalString(oGas, "NW_L_MYCREATOR", GetTag(OBJECT_SELF));
    DestroyObject(OBJECT_SELF, 0.5);
}
