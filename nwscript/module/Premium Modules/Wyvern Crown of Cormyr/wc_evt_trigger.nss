//::///////////////////////////////////////////////////////
// WC_EVT_TRIGGER
/*
  This is the OnEntered script for the henchman trigger objects.
  It signals the event router that a given event has occured,
  by obtaining the key tag from the trigger and using that as
  the event number.

  Each trigger will only be activated once, and can only be
  activated by a PC.

  AUGUST 2003
  1. Code split. New script for new XP2 functionality


  MODIFIED BY BRENT, APRIL 2003
  1. Henchmen now trigger the trigger, not players
  2. Henchmen will only attempt to do the popup or intjereciton
      if the player and the henchmen meet he following requirements
        (a) Neither in combat
        (b) Neither in Conversation
        (c) Within 10 meters of each other
*/
//::///////////////////////////////////////////////////////
// May 26 2003: Make player trigger the interjection.
//    If henchmen is able to move, move them to player and
//    start interjection.
//    Destroy trigger regardless.

//:////////////////////////////////////////////////////////////
// MODIFIED from standard x2_evt_trigger to prevent horses intitiating dialogue
// B W-Husey, Jan2006
// Modified to be triggered only the first time a PC enters, so that henchmen dialogues that are contextual don't get fired later
// April 2006

#include "x0_i0_common"
#include "x2_inc_banter"
#include "cu_functions"


void main()
{
    object oTrigger = GetEnteringObject();
    if (GetIsDefPC(oTrigger) && GetLocalInt(OBJECT_SELF,"nFired")<1) //we don't want these triggers fired except the first time they are entered by a PC
    // even though it is the henchman that triggers them
    {
    SetLocalInt(OBJECT_SELF,"nFired",1);
    object oHench = ReturnHenchman(oTrigger,1);
    string sTag = GetTag(OBJECT_SELF); // What kind of trigger am I?
    if (GetIsObjectValid(oHench)) AttemptInterjectionOrPopup(OBJECT_SELF, sTag, oTrigger,0,oHench);
    }
}


