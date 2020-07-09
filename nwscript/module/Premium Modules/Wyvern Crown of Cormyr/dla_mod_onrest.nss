//::///////////////////////////////////////////////
//:: Module Rest Event
//:: dla_horse_onrest
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Currenly does the following:
     -Don't allow resting on horseback
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: June 6, 2005
//:://////////////////////////////////////////////

// Modified 8/05/2006 by Deva Winblood - Henchmen need to be checked as well
//                                       Mantis #2032

#include "dla_i0_horse"

void main()
{
    //disallow resting on horseback
    object oPC = GetLastPCRested();
    int nN=1;
    object oHench;
    if(GetLastRestEventType() == REST_EVENTTYPE_REST_STARTED)
    {
        if(DLA_GetIsMounted(oPC))
        {
            AssignCommand(oPC, ClearAllActions());
            FloatingTextStringOnCreature("You need to dismount before resting!", oPC, FALSE);
        }
        else
        { // check henchmen
            oHench=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
            while(GetIsObjectValid(oHench))
            { // check for mounted henchmen
                if (DLA_GetIsMounted(oHench))
                { // henchman is mounted
                    AssignCommand(oPC, ClearAllActions());
                    FloatingTextStringOnCreature(GetName(oHench)+" needs to dismount before resting!", oPC, FALSE);
                } // henchman is mounted
                nN++;
                oHench=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
            } // check for mounted henchmen
        } // check henchmen
    }
}

