//dla_atallstopmus
// Stop the area background music & battle music

void main()
{
    MusicBackgroundStop(GetArea(GetPCSpeaker()));
    MusicBattleStop(GetArea(GetPCSpeaker()));
}
