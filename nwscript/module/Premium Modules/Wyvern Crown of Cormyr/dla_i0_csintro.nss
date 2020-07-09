//::///////////////////////////////////////////////
//:: dla_i0_csintro
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Include file for module introduction cutscene scripts
*/
//:://////////////////////////////////////////////
//:: Create By  : Syrsnein
//:: Created On : March 18, 2006
//:://////////////////////////////////////////////

#include "dla_i0_cutscene"
#include "dla_i0_debug"

string sName      = GetName(GetFirstPC());
string sFirst     = GetStringLeft(sName, FindSubString(sName, " "));
string sFirstName = (GetStringLength(sFirst)>0) ? sFirst : sName;

// Script and Lines

// Scene 1
// Cut to Maria coming in from the fields.
// Maria stops at her door and greets Lena.
// Enter Lena from stage left as she greets Maria.
// Fade out Fast
string sLineMaria1 = "Good evening Lena.";
string sLineLena1 = "Good evening Maria.";

// Scene 2
// Cut to 2 hobgoblins sneaking their way behind the fields next to the wall
// Pan on the 1st hobgoblin
// An off-screen hobgoblin kills a chicken with a bow.
// Fade out fast

// Scene 3
// Patrick closes the gate to the cow pen.
// Patrick talks to his dog, Draco, saying the day is done and it's time to eat.
// We see hobgoblins moving in the background.
// Fade out fast
string sLineFather1 = "Well Draco, old boy, it looks like we got 'em all in.  Let's grab a bit o' dinner.";

// Scene 4
// Cut to 2 hobgoblins sneaking out of the woods and up to the side of the house
// Pan around to a third sneaking along the wall
// Fade out fast

// Scene 5
// Enter Dalan from stage rear, entering through the door and greeting the ladies.
// Dalan remarks upon Jonas doing a hard days work.
// Lena replies and Maria remarks on Jonas's better attitude since the PC has returned.
// Dalan comments on how the PC is more like their father
// Fade out fast
string sLineDalan1 = "Good evening ladies.";
string sLineMaria2 = "Good evening dear.";
string sLineLena2 = "Good evening Dalan.";
string sLineDalan2 = "It looks like we'll get a hard day's work out of Jonas.";
string sLineLena3 = "Aye. I was quite suprised when he got up to leave early today.";
string sLineMaria3 = "Since " + sFirstName + " returned, he has been much better about helping around the farm.";
string sLineDalan3 = "Yes, " + sFirstName + " is much more like their father. A leader and a hard worker.";

// Scene 7
// Enter Bardas from stage right.  Dalan greets him.
// Maria comments on getting dinner started.
// Lena hears something odd and turns to face the camera.
// Fade out fast and jump to the wood cutting area.
string sLineDalan4 = "Good evening Bardas.";
string sLineBardas1 = "Good evening everyone.";
string sLineMaria4 = "We'd better be getting dinner ready. Patrick will have the animals penned and " + sFirstName + " will be back soon.";
string sLineLena4 = "I've already put out the cheese and ...";
string sLineLena5 = "What was that?!";
// End Script and Lines

// Set Up the Actors
const string CS_Father  = "CS_Father";
const string CS_Dog     = "CS_Dog";
const string CS_Lena    = "CS_Lena";
const string CS_Dalan   = "CS_Dalan";
const string CS_Maria   = "CS_Maria";
const string CS_Bardas  = "CS_Bardas";
const string CS_HG1     = "HobgoblinSoldier1";
const string CS_HG2     = "HobgoblinSoldier2";
const string CS_HG3     = "HobgoblinSoldier3";
const string CS_HG4     = "HobgoblinSoldier4";
const string CS_HG5     = "HobgoblinSoldier5";
const string CS_HG6     = "HobgoblinSoldier6";
const string CS_HGT1    = "HobgoblinTorchGuy1";
const string CS_HGT2    = "HobgoblinTorchGuy2";
const string CS_HGT3    = "HobgoblinTorchGuy3";
const string CS_Jonas   = "Jonas";
const string CS_Godfroy = "Godfroy";

// Set Up props
const string CS_Red        = "RedLeader";
const string CS_Blue       = "BlueLeader";
const string CS_Neutral    = "NoTeam";
const string CS_DoorCormas = "CS_DoorCormas";
const string CS_DoorBardas = "CS_DoorBardas";

// Choreography
const string CS_WPHG101     = "WP_Hobgoblin1_01";
const string CS_WPHG201     = "WP_Hobgoblin2_01";
const string CS_WPHG301     = "WP_Hobgoblin3_01";
const string CS_WPHG401     = "WP_Hobgoblin4_01";
const string CS_WPHG501     = "WP_Hobgoblin5_01";
const string CS_WPHG601     = "WP_Hobgoblin6_01";
const string CS_WPHG102     = "WP_Hobgoblin1_02";
const string CS_WPHG202     = "WP_Hobgoblin2_02";
const string CS_WPHG302     = "WP_Hobgoblin3_02";
const string CS_WPHG402     = "WP_Hobgoblin4_02";
const string CS_WPHG502     = "WP_Hobgoblin5_02";
const string CS_WPHG602     = "WP_Hobgoblin6_02";
const string CS_WPHG103     = "WP_Hobgoblin1_03";
const string CS_WPHG503     = "WP_Hobgoblin5_03";
const string CS_WPHG504     = "WP_Hobgoblin5_04";
const string CS_WPFather01  = "WP_Father_01";
const string CS_WPFather02  = "WP_Father_02";
const string CS_WPFather03  = "WP_Father_03";
const string CS_WPMaria01   = "WP_Maria_01";
const string CS_WPLena01    = "WP_Lena_01";
const string CS_WPDalan01   = "WP_Dalan_01";
const string CS_WPBardas01  = "WP_Bardas_01";
const string CS_WPBardas02  = "WP_Bardas_02";
const string CS_WPHGT1      = "WP_HobgoblinTorchGuy1";
const string CS_WPHGT2      = "WP_HobgoblinTorchGuy2";
const string CS_WPHGT3      = "WP_HobgoblinTorchGuy3";
const string WC_StartMod    = "WP_Woodcutters";
const string CS_StartJonas  = "WP_StartJonas";
const string CS_WPExitCS    = "WP_ExitCSIntro";

// Set Up Camera Locations
const string CS_Camera1     = "WP_FarmCamera1";
const string CS_Camera2     = "WP_FarmCamera2";
const string CS_Camera3     = "WP_FarmCamera3";
const string CS_Camera4     = "WP_FarmCamera4";
const string CS_Camera5     = "WP_FarmCamera5";

// Set Up Cutscene Events
const int CS_INTRO_KILLCHICKEN   = 0x001;

// Debug
const int CS_DEBUG = TRUE;

void CS_Debug(string sMsg)
{
    if (!CS_DEBUG) return;

    DLA_Debug(sMsg);
}
