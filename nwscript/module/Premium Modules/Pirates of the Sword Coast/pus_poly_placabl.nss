//::///////////////////////////////////////////////
//:: Poly Placeable (OnUse)
//:: pus_poly_placabl.nss
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Play a Poly sfx and launch her conv.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Oct, 2004
//:://////////////////////////////////////////////

void main()
{
    //Play a Poly sound
    string sPoly;
    int iRandom = Random(15);
    switch (iRandom)
    {
        case 0:
            sPoly = "c_parrot_hit1";
            break;
        case 1:
            sPoly = "c_parrot_hit2";
            break;
        case 2:
            sPoly = "c_parrot_hit3";
            break;
        case 3:
            sPoly = "c_parrot_atk1";
            break;
        case 4:
            sPoly = "c_parrot_atk2";
            break;
        case 5:
            sPoly = "c_parrot_atk3";
            break;
        case 6:
            sPoly = "c_parrot_bat1";
            break;
        case 7:
            sPoly = "c_parrot_bat2";
            break;
        case 8:
            sPoly = "c_parrot_bat3";
            break;
        case 9:
            sPoly = "c_parrot_dead";
            break;
        case 10:
        case 11:
        case 12:
        case 13:
        case 14:
            sPoly = "c_parrot_sel";
            break;
    }
    PlaySound(sPoly);

    //Prevent possessed familiars from activating them.
    object oUser = GetLastUsedBy();
    if (GetIsPossessedFamiliar(oUser) == TRUE)
    {
        string sMessage = "You'd best not touch anything until your master arrives.";
        FloatingTextStringOnCreature(sMessage, oUser);
    }
    else
    {
        ActionStartConversation(oUser);
    }
}
