//::///////////////////////////////////////////////
//:: Sets the weapon type to Great Axe
//:: q3ai_mw_axegrt
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player picks 'great axe' as his magic weapon type
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: August 20, 2003
//:://////////////////////////////////////////////

void main()
{
    SetLocalInt(OBJECT_SELF,"Q3AI_WEAPON_TYPE",11);
    //11=Great Axe
}
