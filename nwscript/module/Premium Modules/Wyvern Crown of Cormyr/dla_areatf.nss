// March 2006
// B W-Husey
// Gives the final vision cutscene, fades to black for the summary
// Check the finish state of the PC, and apply the correct scene.

#include "cu_functions"
#include "cu_cutscenes"
#include "cu_cameras"

// Declare Functions we're going to use (they're at the bottom)
void MakeEffects(string sResRef, string sWPTag);
// Makes the wyverns
void MakeWyvern(string sResRef,string sWPTag);
// Makes the masses - 1 at each waypoint, and make them do an animation.
void MakeMasses(string sResRef1,string sResRefS,string sWP1,string sWPC);

void main()
{
    object oPC = GetEnteringObject();

    //Only fire the rest of the script if we got a PC

    if (GetIsDefPC(oPC))
    {
        ClearForCut(oPC);
        SetTime(18,25,1,1);

        //Define all the variables
        object oTalker = GetObjectByTag("EndObject");
        float fDelay;

        //give the PC a horse
        DLA_Mount(oPC,OBJECT_INVALID, FALSE,DLA_HORSE3_TAIL_BARDING5);

        FadeFromBlack(oPC,FADE_SPEED_SLOWEST);
        SetCameraFacing(325.0,20.0,75.0);
        //Pick up which finish state this is from the the PC.
        int nFinish = GetLocalInt(oPC,"nFinishState");

        //MOVE THIS TO CASE 1
        string sCreature1 = "battlepdkm";
//        string sCreature2 = "battlepdkl";
//        string sCreature3 = "battlehawk";
        string sSpecial = "caladnei";
        string sEffect = "wclightm";
        string sShaft = "wclightl";

        switch (nFinish)
        {
            case 1:    //mean to give crown to Caladnei
        sCreature1 = "battlepdkm";
         sSpecial = "caladnei";
         sEffect = "wclightm";
         sShaft = "wclightl";
            break;
            case 2:   //kept crown but killed WL
         sCreature1 = "battlepdkm";
         sSpecial = "caladnei";
         sEffect = "plc_flamelarge";
         sShaft = "wclightl";
            break;
            case 3:  //gave crown to WL
         sCreature1 = "hobgoblinsoldier";
         sSpecial = "witchlord2";
         sEffect = "plc_flamelarge";
         sShaft = "plc_solred";
            break;
            case 4:  //kept crown but kept WL
         sCreature1 = "hobgoblinsoldier";
         sSpecial = "witchlord2";
         sEffect = "plc_flamelarge";
         sShaft = "plc_solred";
            break;
        }
        CreateObject(OBJECT_TYPE_PLACEABLE,sShaft,GetLocation(GetObjectByTag("WP_TFShaft")));
        MakeEffects(sEffect, "WP_TFEffect");
        MakeMasses(sCreature1,sSpecial,"WP_TFCreature","WP_TFSpecial");
        WCCameraMove(1.0,325.0,20.0,75.0,315.0,20.0,75.0,30.0,100.0,oPC);
        DelayCommand(fDelay+=2.1,MakeWyvern("hugewyvern","WP_TFWyvern1"));
        DelayCommand(fDelay+=3.5,MakeWyvern("hugewyvern","WP_TFWyvern2"));
        DelayCommand(fDelay+=6.1,MakeWyvern("hugewyvern","WP_TFWyvern3"));
        DelayCommand(fDelay+=0.5,MakeWyvern("immaturewyvern","WP_TFWyvern4"));
        fDelay = 20.0;
        DelayCommand(fDelay,AssignCommand(oPC,FadeToBlack(oPC,FADE_SPEED_SLOWEST)));
        DelayCommand(fDelay+=1.2,AssignCommand(oPC,ActionStartConversation(oTalker,"End",FALSE,FALSE)));
    } //end of is PC if
}



// Makes the effect - send it the blueprint and the waypoint tag
void MakeEffects(string sResRef, string sWPTag)
{
    location lLoc;
    int n=1;
    // Loop all objects in area
    object oObject = GetObjectByTag(sWPTag,n);
    while(GetIsObjectValid(oObject))
    {
         if(GetTag(oObject) == sWPTag)
         {
            lLoc = GetLocation(oObject);
            CreateObject(OBJECT_TYPE_PLACEABLE,sResRef,lLoc);
         }
         n++;
         oObject = GetObjectByTag(sWPTag,n);
    }

}

// Makes the wyverns
void MakeWyvern(string sResRef,string sWPTag)
{
    location lLoc = GetLocation(GetWaypointByTag(sWPTag));
    object oWyv = CreateObject(OBJECT_TYPE_CREATURE,sResRef,lLoc,TRUE,"EndWyvern");
    ChangeToStandardFaction(oWyv,STANDARD_FACTION_COMMONER);
}

// Makes the masses - 1 at each waypoint, and make them do an animation.
void MakeMasses(string sResRef1,string sResRefS,string sWP1,string sWPC)
{
    int n=1;
    object oC1 = GetObjectByTag(sWP1,n);
//    object oC2 = GetObjectByTag(sWP2,n);
//    object oC3 = GetObjectByTag(sWP3,n);
    object oCS = GetObjectByTag(sWPC);
    location lLoc;
    object oMass1;
    object oMass4;
    //This creates the grunts
    while(GetIsObjectValid(oC1))
    {
            lLoc = GetLocation(oC1);
            oMass1 = CreateObject(OBJECT_TYPE_CREATURE,sResRef1,lLoc,FALSE,"Mass1");
            ChangeToStandardFaction(oMass1,STANDARD_FACTION_COMMONER);
            DelayCommand(IntToFloat(1*n+1),AssignCommand(oMass1,ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1)));
            DelayCommand(IntToFloat(3*n+1),AssignCommand(oMass1,ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1)));
            DelayCommand(IntToFloat(2*n+1),AssignCommand(oMass1,ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1)));
         n++;
         oC1 = GetObjectByTag(sWP1,n);
    }
    //create Caladnei or Witch Lord
    //***********debug line************
//    SendMessageToPC(GetFirstPC(),"Special call "+sResRefS);
    lLoc = GetLocation(oCS);
    oMass4 = CreateObject(OBJECT_TYPE_CREATURE,sResRefS,lLoc,FALSE,"Special");
    ChangeToStandardFaction(oMass4,STANDARD_FACTION_COMMONER);
    DelayCommand(IntToFloat(n+1),AssignCommand(oMass4,ActionPlayAnimation(ANIMATION_FIREFORGET_BOW)));

    /*
    n=1;
    while(GetIsObjectValid(oC2))
    {
            lLoc = GetLocation(oC2);
            CreateObject(OBJECT_TYPE_PLACEABLE,sResRef2,lLoc);
            object oMass2 = CreateObject(OBJECT_TYPE_CREATURE,sResRef1,lLoc,FALSE,"Mass2");
            ChangeToStandardFaction(oMass2,STANDARD_FACTION_COMMONER);
            DelayCommand(IntToFloat(n+1),AssignCommand(oMass2,ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3)));
         n++;
         oC1 = GetObjectByTag(sWP2,n);
    }

    n=1;
    while(GetIsObjectValid(oC3))
    {
            lLoc = GetLocation(oC3);
            CreateObject(OBJECT_TYPE_PLACEABLE,sResRef3,lLoc);
            object oMass3 = CreateObject(OBJECT_TYPE_CREATURE,sResRef1,lLoc,FALSE,"Mass3");
            ChangeToStandardFaction(oMass3,STANDARD_FACTION_COMMONER);
            DelayCommand(IntToFloat(n+1),AssignCommand(oMass3,ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2)));
         n++;
         oC1 = GetObjectByTag(sWP3,n);
    }
    */
}



