state("iw7_ship"){
    int Points: 0x01BA6CB8, 0x8;
    int Round: 0x03CA1050, 0x1D4;
    int gunClip: 0x03C98660, 0xA60;
    int gunMagazine: 0x01BA6218, 0x8;
    int GameTimerIW: 0x05C6F640, 0x1D4; //not sure If i'll use this one, it keeps glitching the timer but it's the game timer
}

/*init{
    timer.IsGameTimePaused = false;
}*/

startup{ //150 cause of tests, will add more soon
    settings.Add("Rounds", true, "Rounds");
    settings.Add("Level2", true, "Split on level 2", "Rounds");
    settings.Add("Level3", true, "Split on level 3", "Rounds");
    settings.Add("Level4", true, "Split on level 4", "Rounds");
    settings.Add("Level5", true, "Split on level 5", "Rounds");
    settings.Add("Level10", true, "Split on level 10", "Rounds");
    settings.Add("Level15", true, "Split on level 15", "Rounds");
    settings.Add("Level20", true, "Split on level 20", "Rounds");
    settings.Add("Level30", true, "Split on level 30", "Rounds");
    settings.Add("Level40", true, "Split on level 40", "Rounds");
    settings.Add("Level50", true, "Split on level 50", "Rounds");
    settings.Add("Level70", true, "Split on level 70", "Rounds");
    settings.Add("Level100", true, "Split on level 100", "Rounds");
    settings.Add("Level110", true, "Split on level 110", "Rounds");
    settings.Add("Level120", true, "Split on level 120", "Rounds");
    settings.Add("Level130", true, "Split on level 130", "Rounds");
    settings.Add("Level140", true, "Split on level 140", "Rounds");
    settings.Add("Level150", true, "Split on level 150", "Rounds"); 

    vars.timer_value = 0;
    int diff = vars.timer_value;
}
    
start{ //Check if we've 500 points and ammo, so It knows the game has started
    if(current.Points == 500 && current.gunClip != 0 && current.gunMagazine != 0){   
        return true;
    }
}

split{ //I'm using the actual round pointer to split, seems easier because it will split exactly when scene changes on screen
    if(current.Round > old.Round && current.Round != 1){
        int lvl_to_check = current.Round;
        if(settings["Rounds"]){
            string toCheck = "Level"+lvl_to_check.ToString();
            if(settings[toCheck]){
                return true;
            }
        }
    }
}

reset{ //basic reset, if round is below 1 and no ammo then it will reset the timer 
    if(current.Round > 1 && current.gunClip == 0 && current.gunMagazine == 0){
        vars.timer_value = 0;
        return true;
    }
}

isLoading{ //Currently having a lot of problems with this one, still can't figure out how to use this without slowing the timer (because the game timer adds 10 each 500ms so it I can't check this value cause it will be true even if the game isn't paused)
    if(current.GameTimerIW == old.GameTimerIW || current.GameTimerIW == old.GameTimerIW + 10){
        return true;
    }
    else{
        return false;
    }
}