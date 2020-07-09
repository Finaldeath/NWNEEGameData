//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_flavortxt
// DATE: August 25, 2005
// AUTH: Luke Scull
// NOTE: Pop-up descriptive text when trigger entered.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    object oPC = GetEnteringObject();
    if (!GetIsPC(oPC))
        return;

    if (GetLocalInt(OBJECT_SELF, "fired") == 1)
        return;

    // some triggers only make sense the first time the player enters
    // so these can be forced to display the message even during combat
    int nForced = GetLocalInt(OBJECT_SELF, "HF_FORCE");
    if (nForced == 0)
    {
        if (GetIsInCombat(oPC))
            return;

        if (GetCutsceneMode(oPC))
            return;

        if (IsInConversation(oPC))
            return;
    }

    string sFlavor;
    string sName = GetName(OBJECT_SELF);
    if(sName == "flavor_stocks")
        sFlavor = "There are frost-covered bones surrounding the base of the stocks. The Bron is ruthless indeed.";
    if(sName == "flavor_tower")
        sFlavor = "The foreboding Locktower looms above town, the shadow it casts symbolic of the oppressive regime that rules Voonlar.";
    if(sName == "flavor_well")
        sFlavor = "Ice covers the well like a spider's web. A glance into its depths reveals chunks of ice floating in the water below.";
    if(sName == "flavor_zhentarim")
        sFlavor = "A group of men are talking near the center of the inn, studiously avoided by the other patrons. One of the men appears to be the Bron of Voonlar.";
    if(sName == "flavor_barn")
        sFlavor = "You notice the barn door has been left open a fraction. Soft light spills from within. You could probably rest in the barn.";
    if(sName == "flavor_boringpig")
        sFlavor = "A dead slaad sprawls near a broken table. The tavern's patrons, many half drunk, are looking at the blue-garbed woman in awe and fear.";
    if(sName == "flavor_mercenaries")
        sFlavor = "You can hear the sound of gruff voices behind this door. They don't sound particularly friendly...";
    if(sName == "flavor_valley")
        sFlavor = "The carnal stench in this narrow valley is strong, despite the bodies being recently dead. You sense you are being watched.";
    if(sName == "flavor_yulash")
        sFlavor = "A trio of Red Plume mercenaries surround a lone Zhentarim survivor, taunting and goading him.";
    if(sName == "flavor_catacombs")
        sFlavor = "There is a palpable sense of decay in this place. You can hear moans and shuffling from close by.";
    if(sName == "flavor_pillar")
        sFlavor = "An eerie red light illuminates a stone pillar, which is carved with images depicting scenes of tyranny and oppression. You sense great evil nearby.";
    if(sName == "flavor_meetingroom")
        sFlavor = "This must be where the Bron discusses matters concerning Voonlar with his deputies. There's a large book on the end of the table.";
    if(sName == "flavor_rattycell")
        sFlavor = "The stench emanating from this cell is truly vile.";
    if(sName == "flavor_market")
        sFlavor = "The market is almost empty: the biting cold and threat of war have persuaded most folk to remain in their homes. An exotic-looking mage and a solemn druid glare at each other across the square.";
    if(sName == "flavor_titys")
        sFlavor = "The ornate shopfront indicates this building may have once been a small temple. Red Plumes eye you suspiciously as you approach the entrance.";
    if(sName == "flavor_diamond")
        sFlavor = "The few patrons that have braved the cold weather for the warmth of the inn watch you with interest. The young innkeeper gives you a quick nod and then returns to polishing glasses.";
    if(sName == "flavor_gladiators")
        sFlavor = "A disturbing sight greets you as you emerge from your cell: gladiators wander aimlessly, dead eyes showing little concern for the wounds and weeping sores that cover their bodies.";
    if(sName == "flavor_drizzle")
        sFlavor = "You can see that something isn't quite right with the drow elf in this room. Most of his face appears to be missing.";
    if(sName == "flavor_dreadspire")
        sFlavor = "A large tower pierces the skyline, its entrance shrouded in an unnatural, shadowy darkness.";
    if(sName == "flavor_war")
        sFlavor = "The priests of Tempus are out in force, dispensing blessings to the Red Plumes that have come seeking the favor of the Lord of Battle.";
    if(sName == "flavor_fire")
        sFlavor = "The door ahead is cracked and blackened from the intense heat radiating from the other side.";
    if(sName == "flavor_earth")
        sFlavor = "This stretch of corridor seems more natural than the rest of the structure. You hear the rumblings of what sounds like a small avalanche just ahead.";
    if(sName == "flavor_air")
        sFlavor = "The battered old door in front of you shakes and rattles, as though constantly buffeted by air.";
    if(sName == "flavor_mirror")
        sFlavor = "The large, ornate mirror resting against the opposite wall catches your attention. There's something strangely compelling about your reflection...";
    if(sName == "flavor_tempus")
        sFlavor = "In contrast to most temples, the Vault of Swords is alive with rowdy priests laughing and joking. The impressive-looking head priest watches over proceedings from his position near the altar.";
    if(sName == "flavor_laris")
        sFlavor = "As soon as you enter the shop, the balding, red-faced owner beckons you over. He appears to be highly agitated.";
    if(sName == "flavor_elventree")
        sFlavor = "Built with the elven ethos of harmony with nature, Elventree is a wonder to behold, with homes built in hollowed-out trees and natural caverns.";
    if(sName == "flavor_unicorn")
        sFlavor = "This huge, fallen tree must have been an oak of colossal age and size before it died. The trunk has been converted into a temple of Mielikki, the benevolent goddess of the forest.";
    if(sName == "flavor_listening")
        sFlavor = "Towering over the other trees is the Listening Tree. The Listening Tree's upper branches form a perfect ampitheater in which the musicians of Elventree perform for the entertainment of all.";
    if(sName == "flavor_swaying")
        sFlavor = "This large oak has been cleverly modified, the upper reaches serving as an inn for the folk of Elventree.";
    if(sName == "flavor_goldcave")
        sFlavor = "A soft golden light spills out from the cave ahead.";
    if(sName == "flavor_harper")
       sFlavor = "The only dwelling in Elventree that isn't fashioned from the forest around it, the roof of this hut is covered in moss. The bridge crossing the chasm is down at the moment, presumably awaiting repairs.";
    if(sName == "flavor_bough")
       sFlavor = "This inn looks remarkably like any other upon first glance. It is only when you glance out to see the ground a hundred feet below and feel the inn swaying in the wind that you realize you are suspended in a huge oak tree.";
    if(sName == "flavor_softdraft")
       sFlavor = "You feel a soft draft emanating from somewhere near the center of the room.";
    if(sName == "flavor_giants")
       sFlavor = "Huge and very recent footprints in the snow lead up to the entrance of this cave.";
    if(sName == "flavor_elmwood")
       sFlavor = "This small town is an oasis of tranquillity in the rugged Moonsea. Despite its idyllic appearance, there is something troubling the people of Elmwood. You can see it on their faces.";
    if(sName == "flavor_elmdocks")
       sFlavor = "Elmwood's docks are unusually busy. Sailors lounge impatiently, and a dark-skinned captain catches your eye near a sleek-looking merchant vessel.";
    if(sName == "flavor_stillwaterupstairs")
       sFlavor = "The upper floor of Still Waters is near vacant of guests at this time of year. Even so, you can hear the angry murmur of two people talking heatedly and trying their best to disguise it.";
    if(sName == "flavor_subterraneanlair")
       sFlavor = "You glance up to see massive, dark shadows far overhead. There are dozens of them, tracking your movements. You are being watched - by many hundreds of eyes...";
    if(sName == "flavor_mulmasterdocks")
       sFlavor = "The stench of rotten fish assails you as soon as you step off the Voyager, as does the relentless drizzle. Mulmaster is not a city of which the bards sing with any warmth, and it is clear to see why.";
    if(sName == "flavor_mulmasterimperial")
       sFlavor = "Mulmaster's Imperial District is more agreeable than the harborside. Even the smell of fish is muted. Rising towers dominate the skyline, looming threateningly, and you sense you had best be on your guard.";
    if(sName == "flavor_templeofcyric")
       sFlavor = "This temple smells strongly of blood and, worse, festering corpses. Cyric's faithful watch you hungrily, a mad gleam in their eyes.";
    if(sName == "flavor_oxpit")
       sFlavor = "A large number of rough-faced men and women are mixing with - and in many cases, intimidating - the locals. They appear to be a ship's crew, in Mulmaster for shore leave. They do not look friendly.";
    if(sName == "flavor_zhentsquarter")
       sFlavor = "The dirty, narrow streets of the Zhents' Quarter reflect the misery of those who live there. This is not a place anyone with any say in the matter would wish to settle.";
    if(sName == "flavor_melvauntnavy")
       sFlavor = "Your voyage is interrupted by the appearance of a large fleet flying the flag of Melvaunt, City of Swords.";
    if(sName == "flavor_elementals")
       sFlavor = "Your voyage is interrupted by a loud crack coming from the hull!";
    if(sName == "flavor_burak")
       sFlavor = "Your voyage is interrupted by pirates!";
    if(sName == "flavor_marel")
       sFlavor = "Your voyage is interrupted. Dark shadows lurk beneath the surface of the water - the marel are plotting an ambush!";
    if(sName == "flavor_blockade")
       sFlavor = "Before you can dock in Zhentil Keep, you are interrupted by a blockade - a huge pirate fleet bars your progress!";
    if(sName == "flavor_thentia")
       sFlavor = "The ripe stench of rothe dung permeates Thentia. In the distance, the towers and keeps of powerful wizards keep watch on the city below.";
    if(sName == "flavor_inlet")
       sFlavor = "You are shocked to see that the bartender at this inn is a hulking minotaur. Despite his bestial appearance, he gives you a polite nod of greeting with his massive, horned head and returns to polishing glasses.";
    if(sName == "flavor_candlemas")
       sFlavor = "These ruins are ancient and of a style lost to modern Faerûn. You wonder just how deep they go...";
    if(sName == "flavor_melvauntdocks")
       sFlavor = "Smoke hangs like a curtain over this grim city, mixing with the mist and ash from the countless forges that glow in the distance.";
    if(sName == "flavor_melvauntmarket")
       sFlavor = "Melvaunt's thriving market is filled with merchants hawking their wares, watched over by suspicious guards. Near the far end of the market is the slave pen - an industry illegal in most of the western Realms but permitted within the City of Swords.";
    if(sName == "flavor_purpleportals")
       sFlavor = "The Purple Portals, a temple to Gond the Wonderbringer, is an architectural marvel and a big source of the city's income.";
    if(sName == "flavor_restingplace")
       sFlavor = "Screams of agony, ecstasy, and more often than not both at the same time echo from within this temple's gloomy chambers. For a temple devoted to the goddess of pain, it is surprisingly busy - perhaps a testament to the decadence of Melvaunt's nobles.";
    if(sName == "flavor_lodgeofthegreathunt")
       sFlavor = "The clergy of the Beastlord Malar stare at you appraisingly, as though deciding whether you are predator or prey - or perhaps both.";
    if(sName == "flavor_thepride")
       sFlavor = "This decrepit inn truly is the worst you have ever stepped foot in. Ale, blood, and worse cover the floor. Leaks are everywhere you look. A pair of the ugliest half-orcs you have laid eyes on wait the bar.";
    if(sName == "flavor_grandtemple")
       sFlavor = "The Grand Temple of the Black Lord, the most impressive building in Zhentil Keep, looms up ahead. You sense your epic journey is nearing its conclusion.";
    if(sName == "flavor_tharcracks")
       sFlavor = "There is something unnatural about the great cracks in the earth here. You wonder what made them...";
    if(sName == "flavor_jaggedrocks")
       sFlavor = "Pools of saltwater cover the floor of this temple, and it stinks of brine. The head priestess watches you with unfriendly eyes as you splash towards her.";
   if(sName == "flavor_kurtharsugates")
       sFlavor = "The colossal gates of Kur-Tharsu stand boldly ahead of you. You can hear the stronghold's defenders massing beyond.";
    if(sName == "flavor_ogremages")
       sFlavor = "Demonic chanting echoes from somewhere ahead. A summoning ritual is taking place.";

    AssignCommand(oPC, SpeakString(sFlavor));
    SetLocalInt(OBJECT_SELF, "fired", 1);
}
