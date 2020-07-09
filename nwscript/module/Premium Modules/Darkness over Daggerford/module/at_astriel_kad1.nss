void main()
{
    //this flags the fact that the player has told Astriel about completing
    //Teygan's final quest (kill Drelia)
    //It is used in Astriel's endgame conversation back in Daggerford
    //where it is possible that the player may wish to tie up remaining
    //loose ends
    SetLocalInt(GetModule(), "astriel_knows_about_drelia", 1);
}
