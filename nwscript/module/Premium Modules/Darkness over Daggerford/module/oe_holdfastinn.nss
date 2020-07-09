// onEnter event for the holdfast inn in liam's hold

#include "hf_in_spawn"
#include "hf_in_npc"
#include "hf_in_util"

void main()
{
    //spawn related stuff
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        SpawnEnter(oPC);
    }
    //let's deal with Hevesar first as he is the most important NPC in here
    //if the player has agreed to help we need to create the version that
    //remembers meeting and dealing with the player
    location lHevesar = GetLocation(GetWaypointByTag("wp_hevesar_hfi"));
    if(GetIsPC(oPC) && GetLocalInt(GetModule(), "hevesar_plot") ==2
    && (GetLocalInt(GetModule(), "hfi_spwn") !=1))
    {
        //SendMessageToPC(oPC, "I'm on part one");
        //create hevesar
        //lSpwn == GetLocation(GetWaypointByTag("wp_hevesar_hfi"));
        CreateObject(OBJECT_TYPE_CREATURE, "db_hevesar_hfi1", lHevesar);
        //set do once integer
        SetLocalInt(GetModule(), "hfi_spwn", 1);
    }
    //the player has not yet agreed to help and is entering for the first time
    //create the hevesar who explains the plot to the PC
    else
    {
        if(GetIsPC(oPC) &&(GetLocalInt(GetModule(), "hfi_spwn") !=1))
        {
            //SendMessageToPC(oPC, "I'm on part two");
            //create hevesar
            //lSpwn == GetLocation(GetWaypointByTag("wp_hevesar_hfi0"));
            CreateObject(OBJECT_TYPE_CREATURE, "db_hevesar_hfi0", lHevesar);
            //set do once integer
            SetLocalInt(GetModule(), "hfi_spwn", 1);
        }
    }
    //now we deal with the spawn of Jerick's lad, who is also Hevesar's nephew
    //once the player has solved the orcs crossing the fields mystery
    //we spawn Jerick's Lad by Heversar the next time they enter,
    //and remove the farmers from the wild pastures area
    if(GetIsPC(oPC) && GetLocalInt(GetModule(), "fieldsquest") ==1
    && (GetLocalInt(GetModule(), "hfi_lad_spwn") !=1))
    {
        //destroy the farmers in the wild pastures
        object oJerick = GetObjectByTag("db_shepherd");
        object oGaslo = GetObjectByTag("db_gaslo2");
        object oLad = GetObjectByTag("db_jerickslad");
        DestroyObject(oJerick);
        DestroyObject(oGaslo);
        DestroyObject(oLad);
        //spawn Jerick's Lad into the Inn
        location lLad = GetLocation(GetWaypointByTag("wp_spawn_nephew"));
        CreateObject(OBJECT_TYPE_CREATURE, "db_jerickslad_hf", lLad, FALSE, "db_jerickslad");
        //create Jerick in the Drop Off Cave
        location lJerick = GetLocation(GetWaypointByTag("wp_drop_jerick"));
        CreateObject(OBJECT_TYPE_CREATURE, "db_shepherd2", lJerick);
        //only do all that once
        SetLocalInt(GetModule(), "hfi_lad_spwn", 1);
    }
    //create Lashar the shopkeeper if nighttime
    if(GetIsPC(oPC))
    {
        object oLashar=GetObjectInArea("db_lashar", OBJECT_SELF);
        location lLashar=GetLocation(GetWaypointByTag("wp_lashar_night"));

        if(!GetIsDay() && !GetIsDawn())
        {
            if (!GetIsObjectValid(oLashar))
            {
                CreateObject(OBJECT_TYPE_CREATURE, "db_lashar" ,lLashar, FALSE);
            }
        }
        else
        {
            if (GetIsObjectValid(oLashar))
            {
                DestroyObject(oLashar,0.1);
            }
        }
    }

    //create White Glove if Vejoni has been killed (she's the alternative magic store)
    if(GetLocalInt(GetModule(), "vejoni_dead") >=1 && GetLocalInt(OBJECT_SELF, "white_spawn") !=1)
    {
        //spawn White
        location lSpawnWhite = GetLocation(GetWaypointByTag("wp_whiteglove"));
        CreateObject(OBJECT_TYPE_CREATURE, "db_whiteglove", lSpawnWhite, FALSE);
        //do it only once
        SetLocalInt(OBJECT_SELF, "white_spawn", 1);
    }

    if(GetIsPC(oPC)&&GetLocalInt(GetModule(),"evani_plot")==10
       ||GetLocalInt(GetModule(),"evani_plot")==15)
    {
       //do the Evani Fantabulizer!
       if(!GetLocalInt(GetModule(),"holdfast_party_active")==1)
       {
           SetLocalInt(GetModule(),"holdfast_party_active",1);

           //create the lights
           location lLight1=GetLocation(GetWaypointByTag("wp_light1"));
           location lLight2=GetLocation(GetWaypointByTag("wp_light2"));
           location lLight3=GetLocation(GetWaypointByTag("wp_light3"));
           location lLight4=GetLocation(GetWaypointByTag("wp_light4"));
           location lLight5=GetLocation(GetWaypointByTag("wp_light5"));
           location lLight6=GetLocation(GetWaypointByTag("wp_light6"));
           location lLight7=GetLocation(GetWaypointByTag("wp_light7"));
           CreateObject(OBJECT_TYPE_PLACEABLE,"plc_solyellow",lLight1,FALSE,"_light1");
           CreateObject(OBJECT_TYPE_PLACEABLE,"plc_solblue",lLight2,FALSE,"_light2");
           CreateObject(OBJECT_TYPE_PLACEABLE,"plc_solgreen",lLight3,FALSE,"_light3");
           CreateObject(OBJECT_TYPE_PLACEABLE,"plc_solpurple",lLight4,FALSE,"_light4");
           CreateObject(OBJECT_TYPE_PLACEABLE,"plc_solorange",lLight5,FALSE,"_light5");
           CreateObject(OBJECT_TYPE_PLACEABLE,"plc_solcyan",lLight6,FALSE,"_light6");
           CreateObject(OBJECT_TYPE_PLACEABLE,"plc_solred",lLight7,FALSE,"_light7");

           //spawn in the dancers
           location lSpwnD1=GetLocation(GetWaypointByTag("wp_spwnd1"));
           location lSpwnD2=GetLocation(GetWaypointByTag("wp_spwnd2"));
           location lSpwnD3=GetLocation(GetWaypointByTag("wp_spwnd3"));
           location lSpwnD4=GetLocation(GetWaypointByTag("wp_spwnd4"));
           CreateObject(OBJECT_TYPE_CREATURE,"db_patron1",lSpwnD1,FALSE,"_patron1");
           CreateObject(OBJECT_TYPE_CREATURE,"db_patron3",lSpwnD4,FALSE,"_patron2");
           CreateObject(OBJECT_TYPE_CREATURE,"db_patron2",lSpwnD3,FALSE,"_patron3");
           CreateObject(OBJECT_TYPE_CREATURE,"db_patron4",lSpwnD2,FALSE,"_patron4");

           //turn the sounds on/off
           //object oDrums=GetObjectInArea("WarDrum2",OBJECT_SELF);
           object oCrackle=GetObjectInArea("JacobsLadder",OBJECT_SELF);
           object oTrance = GetObjectInArea("am_fantabulizer", OBJECT_SELF);
           //SoundObjectPlay(oDrums);
           SoundObjectStop(oCrackle);
           //ExecuteScript("db_dancing",OBJECT_SELF);
           SoundObjectPlay(oTrance);

           //turn off background music
           object oArea = GetArea(OBJECT_SELF);
           MusicBackgroundStop(oArea);

           // start the timer (dancers should go away after a while)
           IsTimerExpired(OBJECT_SELF, 48);
       }
       else if (GetLocalInt(GetModule(), "holdfast_party_active") == 1)
       {
            if (IsTimerExpired(OBJECT_SELF, 48))
            {
               // cleanup the dancers
               SetLocalInt(GetModule(), "holdfast_party_active", 2);
               object oDrums=GetObjectInArea("WarDrum2", OBJECT_SELF);
               SoundObjectStop(oDrums);
               object oLight1 = GetObjectInArea("_light1", OBJECT_SELF);
               DestroyObject(oLight1);
               object oLight2 = GetObjectInArea("_light2", OBJECT_SELF);
               DestroyObject(oLight2);
               object oLight3 = GetObjectInArea("_light3", OBJECT_SELF);
               DestroyObject(oLight3);
               object oLight4 = GetObjectInArea("_light4", OBJECT_SELF);
               DestroyObject(oLight4);
               object oLight5 = GetObjectInArea("_light5", OBJECT_SELF);
               DestroyObject(oLight5);
               object oLight6 = GetObjectInArea("_light6", OBJECT_SELF);
               DestroyObject(oLight6);
               object oLight7 = GetObjectInArea("_light7", OBJECT_SELF);
               DestroyObject(oLight7);
               object oDancer1 = GetObjectInArea("_patron1", OBJECT_SELF);
               DestroyObject(oDancer1);
               object oDancer2 = GetObjectInArea("_patron2", OBJECT_SELF);
               DestroyObject(oDancer2);
               object oDancer3 = GetObjectInArea("_patron3", OBJECT_SELF);
               DestroyObject(oDancer3);
               object oDancer4 = GetObjectInArea("_patron4", OBJECT_SELF);
               DestroyObject(oDancer4);
               //added by Luspr 26th June 06
               //turn on the background music
               object oTrance = GetObjectInArea("am_fantabulizer", OBJECT_SELF);
               SoundObjectStop(oTrance);
               object oArea = GetArea(OBJECT_SELF);
               MusicBackgroundPlay(oArea);
               //dont start all that again!
               SetLocalInt(GetModule(), "evani_plot", 20);
            }
       }
    }
}
