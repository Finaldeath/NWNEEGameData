////////////////////////////////////////////////////////////////////////////////
// dla_oe_validname - Check to see if the PC used a valid name for this module
// Original Scripter: Deva B. Winblood
// Last Modified By : B W-Husey  14th May - to fire from an object (OBJECT_SELF)
//------------------------------------------------------------------------------
// This should be setup as ExecuteScript("dla_oe_validname",oPC);
////////////////////////////////////////////////////////////////////////////////
#include "dla_i0_strings"

/////////////////////////
// PROTOTYPES
/////////////////////////

void privateDLA_InvalidName(object oPC);

//////////////////////////////////////////////////////////////////[ MAIN ]//////
void main()
{
   object oPC=OBJECT_SELF;
   string sName=GetName(oPC);
   int nWordCount=0;
   string sLower=GetStringLowerCase(sName);
   if (GetStringLength(sLower)>0)
   { // count words
     sLower=DLA_ParseRight(sName," ");
     if (sLower=="the"||sLower=="a"||sLower=="an")
     { // invalid
       privateDLA_InvalidName(oPC);
       return;
     } // invalid
     nWordCount++;
     sName=DLA_RemoveParsedLeft(sName,sLower," ");
     while(GetStringLength(sName)>0)
     { // count words
       sLower=DLA_ParseRight(sName," ");
       if (sLower=="the"||sLower=="a"||sLower=="an")
       { // invalid
         privateDLA_InvalidName(oPC);
         return;
       } // invalid
       nWordCount++;
       sName=DLA_RemoveParsedLeft(sName,sLower," ");
     } // count words
     if (nWordCount!=2) privateDLA_InvalidName(oPC);
   } // count words
}/////////////////////////////////////////////////////////////////[ MAIN ]//////


/////////////////////////
// FUNCTIONS
/////////////////////////

void privateDLA_InvalidName(object oPC)
{ // PURPOSE: Give player message that their name is invalid
  // Original Scripter: Deva B. Winblood
  // Last Modified By:  Deva B. Winblood
  string sInvalidName=DLA_SetStringColor("YOUR PLAYER NAME IS INVALID!","622");
  string sMsg;
  DelayCommand(15.0,FloatingTextStringOnCreature(sInvalidName,oPC,FALSE));
  sMsg=DLA_SetStringColor("WARNING!!:","622");
  sMsg=sMsg+" The name you have chosen does not meet the name guidelines for this";
  sMsg=sMsg+" module and will result in odd dialog during play.  It is recommended that";
  sMsg=sMsg+" you use these guidelines when designing a character for this module.  The ";
  sMsg=sMsg+" character should have a FIRST and LAST name.  The character should not have";
  sMsg=sMsg+" the words THE, A, or AN in the name.  BAD NAME EXAMPLES: 'Conan', 'Conan the";
  sMsg=sMsg+" Barbarian', 'A mysterious man'.  GOOD NAMES: 'Conan Cimmerian'.";
  DelayCommand(15.1,SendMessageToPC(oPC,sMsg));
} // privateDLA_InvalidName()
