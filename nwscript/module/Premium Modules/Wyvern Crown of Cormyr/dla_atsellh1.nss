////////////////////////////////////////////////////////////////////////////////
// dla_atsellh1 - Increment nParm and find horse... begin walking towards it
// Scripted By: Deva Winblood   8/03/2006
////////////////////////////////////////////////////////////////////////////////
#include "dla_i0_horse"

void main()
{
    object oPC=GetPCSpeaker();
    object oWangle=OBJECT_SELF;
    object oHorse;
    int nParm=GetLocalInt(oPC,"nParm");
    int nN;
    int nHorseNum=0;
    object oInterested=OBJECT_INVALID;
    nN=1;
    nParm++;
    SetLocalInt(oPC,"nParm",nParm);
    oHorse=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
    while(GetIsObjectValid(oHorse)&&nHorseNum<nParm)
    { // find horse
        if (DLA_GetIsDLAHorse(oHorse))
        { // horse
            nHorseNum++;
            if (nHorseNum==nParm)
            { // match
                oInterested=oHorse;
            } // match
            else
            { // not a match
                nN++;
                oHorse=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
            } // not a match
        } // horse
        else
        { // not horse
            nN++;
            oHorse=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
        } // not horse
    } // find horse
    if (GetIsObjectValid(oInterested))
    { // horse
        AssignCommand(oWangle,ActionMoveToObject(oInterested,FALSE,1.5));
        AssignCommand(oWangle,ActionDoCommand(SetFacingPoint(GetPosition(oInterested))));
        SetLocalObject(oWangle,"oInterested",oInterested);
    } // horse
    else
    { // not interested
        DeleteLocalObject(oWangle,"oInterested");
    } // not interested
}
