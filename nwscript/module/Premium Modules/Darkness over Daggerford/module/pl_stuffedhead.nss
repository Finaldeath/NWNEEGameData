// nagnorm speaks to his stuffed heads (called via ambient system)

void main()
{
    string s;
    int n = d8();
    if      (n == 1)  s = "Yes? How interesting! Tell me more!";
    else if (n == 2)  s = "Good beastie! Extra munchies for you tonight!";
    else if (n == 3)  s = "Oh, I completely agree!";
    else if (n == 4)  s = "No, you can't go outside tonight. You might get wet!";
    else if (n == 5)  s = "You should eat more! You're all skin and bones!";
    else if (n == 6)  s = "Naughty beastie! Where did you learn that word?";
    else if (n == 7)  s = "You seem quiet today. Did you get enough sleep last night?";
    else if (n == 8)  s = "Are you hungry? Would you like some munchies?";
    SpeakString(s);
}
