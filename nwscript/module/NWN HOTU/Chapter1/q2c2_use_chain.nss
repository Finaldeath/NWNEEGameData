//::///////////////////////////////////////////////
//:: Name q2c2_use_chain
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////


void main()
{
        //Play sound so PC knows chain was pulled.
        AssignCommand(GetLastUsedBy(),PlaySound("as_cv_shopmetal2"));
}

