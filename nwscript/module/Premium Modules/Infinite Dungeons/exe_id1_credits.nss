//::///////////////////////////////////////////////
//:: ID1 Credits
//:: exe_id1_credits.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Cycles through the players and applies the
     module credits as floaty text above their
     heads.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: April 4, 2006
//:://////////////////////////////////////////////

#include "inc_id1_utility"

//Displays credits as floaty text above all players heads.
void RollCredits()
{
    //Declare variables
    object oCreditPC = GetFirstPC();
    int iN = 1;
    float fDelay = 0.0;
    string sCredit = GetLocalString(GetModule(), "s"+IntToString(iN));

    //Loop through the credit strings until you reach the end.
    while (sCredit != "//END//")
    {
        //Define the Delay
        fDelay = iN/1.5;

        //Loop through each player
        oCreditPC = GetFirstPC();
        while (oCreditPC != OBJECT_INVALID)
        {
            //Apply the credit string.
            DelayCommand(fDelay, FloatingTextStringOnCreature(sCredit, oCreditPC, FALSE));

            //Update the loop variable
            oCreditPC = GetNextPC();
        }
        //Update the loop variable
        iN++;

        //Get the next credit string.
        sCredit = GetLocalString(GetModule(), "s"+IntToString(iN));
    }
}

void main()
{
    DebugMessage("Starting credits.");

    //Declare variables
    object oM = GetModule();
    int iN = 0;

    //Save out Credit Strings
    SetLocalString(oM, "s"+IntToString(iN++), "=========================================");
    SetLocalString(oM, "s"+IntToString(iN++), "The BioWare Community Live Team presents:");
    SetLocalString(oM, "s"+IntToString(iN++), "'Neverwinter Nights: Infinite Dungeons'");
    SetLocalString(oM, "s"+IntToString(iN++), "=========================================");
    SetLocalString(oM, "s"+IntToString(iN++), "");
    SetLocalString(oM, "s"+IntToString(iN++), "Designed by");
    SetLocalString(oM, "s"+IntToString(iN++), "-----------");
    SetLocalString(oM, "s"+IntToString(iN++), "Peter Thomas - Project Lead Designer");
    SetLocalString(oM, "s"+IntToString(iN++), "Jason 'Elidrin' Lowry - Community Designer");
    SetLocalString(oM, "s"+IntToString(iN++), "Grant Mackay - Technical Designer");
    SetLocalString(oM, "s"+IntToString(iN++), "Cori May - Technical Designer");
    SetLocalString(oM, "s"+IntToString(iN++), "Dan Whiteside - Writer");
    SetLocalString(oM, "s"+IntToString(iN++), "Jonathan Epp - Cutscene Designer");
    SetLocalString(oM, "s"+IntToString(iN++), "Rob Bartel - Original Design");
    SetLocalString(oM, "s"+IntToString(iN++), "");
    SetLocalString(oM, "s"+IntToString(iN++), "Art Management");
    SetLocalString(oM, "s"+IntToString(iN++), "--------------");
    SetLocalString(oM, "s"+IntToString(iN++), "Brian Chung - Technical Artist");
    SetLocalString(oM, "s"+IntToString(iN++), "");
    SetLocalString(oM, "s"+IntToString(iN++), "Audio");
    SetLocalString(oM, "s"+IntToString(iN++), "-----");
    SetLocalString(oM, "s"+IntToString(iN++), "Shauna Perry - VO Casting and Direction");
    SetLocalString(oM, "s"+IntToString(iN++), "Michael Kent - Audio Designer");
    SetLocalString(oM, "s"+IntToString(iN++), "Chris Postle - Voice Actor");
    SetLocalString(oM, "s"+IntToString(iN++), "David John - Composer");
    SetLocalString(oM, "s"+IntToString(iN++), "");
    SetLocalString(oM, "s"+IntToString(iN++), "BioWare Quality Assurance");
    SetLocalString(oM, "s"+IntToString(iN++), "-------------------------");
    SetLocalString(oM, "s"+IntToString(iN++), "Bruce Venne - Quality Assurance Lead");
    SetLocalString(oM, "s"+IntToString(iN++), "Stanley Woo - Quality Assurance");
    SetLocalString(oM, "s"+IntToString(iN++), "Chris Priestly - Quality Assurance");
    SetLocalString(oM, "s"+IntToString(iN++), "");
    SetLocalString(oM, "s"+IntToString(iN++), "BioWare Community Live Team");
    SetLocalString(oM, "s"+IntToString(iN++), "---------------------------");
    SetLocalString(oM, "s"+IntToString(iN++), "Diarmid Clarke - Project Director");
    SetLocalString(oM, "s"+IntToString(iN++), "Darcy Pajak - Associate Producer");
    SetLocalString(oM, "s"+IntToString(iN++), "Moye Daniel - Assistant External Producer");
    SetLocalString(oM, "s"+IntToString(iN++), "Rob Bartel - Lead Designer");
    SetLocalString(oM, "s"+IntToString(iN++), "Derek French - Technical Producer");
    SetLocalString(oM, "s"+IntToString(iN++), "Craig Welburn - Game Programmer");
    SetLocalString(oM, "s"+IntToString(iN++), "Owen Borstad - Tools Programmer");
    SetLocalString(oM, "s"+IntToString(iN++), "Gorman Ho - Programmer");
    SetLocalString(oM, "s"+IntToString(iN++), "");
    SetLocalString(oM, "s"+IntToString(iN++), "BioWare Marketing");
    SetLocalString(oM, "s"+IntToString(iN++), "-----------------");
    SetLocalString(oM, "s"+IntToString(iN++), "Craig Priddle - Director of Marketing");
    SetLocalString(oM, "s"+IntToString(iN++), "Jarrett Lee - Marketing Manager");
    SetLocalString(oM, "s"+IntToString(iN++), "Erik Einsiedel - Public Relations Coordinator");
    SetLocalString(oM, "s"+IntToString(iN++), "Robin Mayne - Web Team Manager");
    SetLocalString(oM, "s"+IntToString(iN++), "Jeff Marvin - Web Developer");
    SetLocalString(oM, "s"+IntToString(iN++), "Johnn Four - Web Content Developer");
    SetLocalString(oM, "s"+IntToString(iN++), "Todd Grenier - Senior Artist");
    SetLocalString(oM, "s"+IntToString(iN++), "Colin Walmsley - Artist");
    SetLocalString(oM, "s"+IntToString(iN++), "Jay Watamaniuk - Community Manager");
    SetLocalString(oM, "s"+IntToString(iN++), "Jason Barlow - Client Care Specialist");
    SetLocalString(oM, "s"+IntToString(iN++), "");
    SetLocalString(oM, "s"+IntToString(iN++), "Additional Internal Assistance");
    SetLocalString(oM, "s"+IntToString(iN++), "------------------------------");
    SetLocalString(oM, "s"+IntToString(iN++), "Ray Muzyka - Joint CEO and Co-Executive Producer");
    SetLocalString(oM, "s"+IntToString(iN++), "Greg Zeschuk - Joint CEO and Co-Executive Producer");
    SetLocalString(oM, "s"+IntToString(iN++), "Richard Iwaniuk - Director of Finance");
    SetLocalString(oM, "s"+IntToString(iN++), "Robert Kallir - Director of Legal/Business Services");
    SetLocalString(oM, "s"+IntToString(iN++), "The BioWare Administrative Department");
    SetLocalString(oM, "s"+IntToString(iN++), "Craig Miller - Senior Systems Administrator");
    SetLocalString(oM, "s"+IntToString(iN++), "Dups Wijayawardhana - Senior Systems Developer");
    SetLocalString(oM, "s"+IntToString(iN++), "Dave McGruther - Systems Administrator");
    SetLocalString(oM, "s"+IntToString(iN++), "");
    SetLocalString(oM, "s"+IntToString(iN++), "========================================================");
    SetLocalString(oM, "s"+IntToString(iN++), "With Art Content by DLA - [http://www.dladventures.com/]");
    SetLocalString(oM, "s"+IntToString(iN++), "========================================================");
    SetLocalString(oM, "s"+IntToString(iN++), "");
    SetLocalString(oM, "s"+IntToString(iN++), "Producer");
    SetLocalString(oM, "s"+IntToString(iN++), "--------");
    SetLocalString(oM, "s"+IntToString(iN++), "Robert Trifts");
    SetLocalString(oM, "s"+IntToString(iN++), "");
    SetLocalString(oM, "s"+IntToString(iN++), "Animations");
    SetLocalString(oM, "s"+IntToString(iN++), "----------");
    SetLocalString(oM, "s"+IntToString(iN++), "Adam Anden");
    SetLocalString(oM, "s"+IntToString(iN++), "");
    SetLocalString(oM, "s"+IntToString(iN++), "Modeling");
    SetLocalString(oM, "s"+IntToString(iN++), "--------");
    SetLocalString(oM, "s"+IntToString(iN++), "Lior Bilia");
    SetLocalString(oM, "s"+IntToString(iN++), "Alex Bobylev");
    SetLocalString(oM, "s"+IntToString(iN++), "Brian Chung");
    SetLocalString(oM, "s"+IntToString(iN++), "Martin Ellis");
    SetLocalString(oM, "s"+IntToString(iN++), "Dan Ireson");
    SetLocalString(oM, "s"+IntToString(iN++), "Elazar Katvan");
    SetLocalString(oM, "s"+IntToString(iN++), "Jason Kwong");
    SetLocalString(oM, "s"+IntToString(iN++), "Francis Lacuna");
    SetLocalString(oM, "s"+IntToString(iN++), "Derek Lo");
    SetLocalString(oM, "s"+IntToString(iN++), "Lisa");
    SetLocalString(oM, "s"+IntToString(iN++), "Ron Norton");
    SetLocalString(oM, "s"+IntToString(iN++), "Mirko Zohren");
    SetLocalString(oM, "s"+IntToString(iN++), "");
    SetLocalString(oM, "s"+IntToString(iN++), "Textures");
    SetLocalString(oM, "s"+IntToString(iN++), "--------");
    SetLocalString(oM, "s"+IntToString(iN++), "Gareth Davies");
    SetLocalString(oM, "s"+IntToString(iN++), "Martin Ellis");
    SetLocalString(oM, "s"+IntToString(iN++), "Francis Lacuna");
    SetLocalString(oM, "s"+IntToString(iN++), "Lisa");
    SetLocalString(oM, "s"+IntToString(iN++), "Erik Lindqvist");
    SetLocalString(oM, "s"+IntToString(iN++), "Anthony Marinakis");
    SetLocalString(oM, "s"+IntToString(iN++), "Ron Norton");
    SetLocalString(oM, "s"+IntToString(iN++), "Marc-Andrew Soehl");
    SetLocalString(oM, "s"+IntToString(iN++), "");
    SetLocalString(oM, "s"+IntToString(iN++), "Portraits");
    SetLocalString(oM, "s"+IntToString(iN++), "---------");
    SetLocalString(oM, "s"+IntToString(iN++), "Anthony Marinakis");
    SetLocalString(oM, "s"+IntToString(iN++), "");
    SetLocalString(oM, "s"+IntToString(iN++), "Sound");
    SetLocalString(oM, "s"+IntToString(iN++), "-----");
    SetLocalString(oM, "s"+IntToString(iN++), "David John");
    SetLocalString(oM, "s"+IntToString(iN++), "John Michaels");
    SetLocalString(oM, "s"+IntToString(iN++), "");
    SetLocalString(oM, "s"+IntToString(iN++), "Tools & Programming");
    SetLocalString(oM, "s"+IntToString(iN++), "-------------------");
    SetLocalString(oM, "s"+IntToString(iN++), "Rick Burton");
    SetLocalString(oM, "s"+IntToString(iN++), "Mikael Pajunen");
    SetLocalString(oM, "s"+IntToString(iN++), "James Walker");
    SetLocalString(oM, "s"+IntToString(iN++), "Mirko Zohren");
    SetLocalString(oM, "s"+IntToString(iN++), "");
    SetLocalString(oM, "s"+IntToString(iN++), "Quality Assurance");
    SetLocalString(oM, "s"+IntToString(iN++), "-----------------");
    SetLocalString(oM, "s"+IntToString(iN++), "Lee Joel");
    SetLocalString(oM, "s"+IntToString(iN++), "Kathlina Nielson");
    SetLocalString(oM, "s"+IntToString(iN++), "");
    SetLocalString(oM, "s"+IntToString(iN++), "===========================");
    SetLocalString(oM, "s"+IntToString(iN++), "Publishing Support by Atari");
    SetLocalString(oM, "s"+IntToString(iN++), "===========================");
    SetLocalString(oM, "s"+IntToString(iN++), "");
    SetLocalString(oM, "s"+IntToString(iN++), "Production");
    SetLocalString(oM, "s"+IntToString(iN++), "----------");
    SetLocalString(oM, "s"+IntToString(iN++), "Dorian Richard - Sr. Producer");
    SetLocalString(oM, "s"+IntToString(iN++), "Keehwan Her - Assistant Producer");
    SetLocalString(oM, "s"+IntToString(iN++), "Ezequiel 'Chuck' Nunez - Manager of Publishing Support");
    SetLocalString(oM, "s"+IntToString(iN++), "");
    SetLocalString(oM, "s"+IntToString(iN++), "Quality Assurance");
    SetLocalString(oM, "s"+IntToString(iN++), "-----------------");
    SetLocalString(oM, "s"+IntToString(iN++), "Michael O'Shea - QA Supervisor");
    SetLocalString(oM, "s"+IntToString(iN++), "Jason Gates - QA Lead Tester");
    SetLocalString(oM, "s"+IntToString(iN++), "Kimo Pamintuan - Assistant Lead Tester");
    SetLocalString(oM, "s"+IntToString(iN++), "");
    SetLocalString(oM, "s"+IntToString(iN++), "QA Test Team");
    SetLocalString(oM, "s"+IntToString(iN++), "------------");
    SetLocalString(oM, "s"+IntToString(iN++), "Jeremiah Turner");
    SetLocalString(oM, "s"+IntToString(iN++), "Barry Bishop");
    SetLocalString(oM, "s"+IntToString(iN++), "Drave Cochems");
    SetLocalString(oM, "s"+IntToString(iN++), "");
    SetLocalString(oM, "s"+IntToString(iN++), "======================================================");
    SetLocalString(oM, "s"+IntToString(iN++), "D&D Licence Support by Hasbro and Wizards of the Coast");
    SetLocalString(oM, "s"+IntToString(iN++), "======================================================");
    SetLocalString(oM, "s"+IntToString(iN++), "Ed Stark");
    SetLocalString(oM, "s"+IntToString(iN++), "Rich Redman");
    SetLocalString(oM, "s"+IntToString(iN++), "Peter Archer");
    SetLocalString(oM, "s"+IntToString(iN++), "Liz Schuh");
    SetLocalString(oM, "s"+IntToString(iN++), "Mary Elizabeth Allen");
    SetLocalString(oM, "s"+IntToString(iN++), "Charles Ryan");
    SetLocalString(oM, "s"+IntToString(iN++), "Ellen Guilfoyle");
    SetLocalString(oM, "s"+IntToString(iN++), "Rachel Hoagland");
    SetLocalString(oM, "s"+IntToString(iN++), "");
    SetLocalString(oM, "s"+IntToString(iN++), "==================");
    SetLocalString(oM, "s"+IntToString(iN++), "Special Thanks to:");
    SetLocalString(oM, "s"+IntToString(iN++), "==================");
    SetLocalString(oM, "s"+IntToString(iN++), "Ed Stark");
    SetLocalString(oM, "s"+IntToString(iN++), "Rich Redman");
    SetLocalString(oM, "s"+IntToString(iN++), "Everyone at BioWare, past and present,");
    SetLocalString(oM, "s"+IntToString(iN++), "  who has contributed to NWN's success.");
    SetLocalString(oM, "s"+IntToString(iN++), "The BioWare fan community for");
    SetLocalString(oM, "s"+IntToString(iN++), "  supporting us for so long.");
    SetLocalString(oM, "s"+IntToString(iN++), "//END//");

    //Roll the Credits
    RollCredits();
}

