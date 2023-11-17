//====== create event ======

//flags to prevent crash and so step code runs once
can_pause = true;
pause_sprite = -4;

//==========================

//====== step event =======

//would check for a keyboard press here then run code below
if (can_pause){
        global.GAMEPaused = !global.GAMEPaused;   

        //checks if a screenshot does not exist
        if !(file_exists(pause_sprite)){
            pause_png = (working_directory + "\\ScreenShots\\Screen_pause.png");
            screen_save(pause_png);
    
            pause_sprite = sprite_add(pause_png,1,false,false,0,0);
        }
        //resets flags so this only runs once
        alarm[0] = GAMESPEED;
        can_pause = false;
    }
}

//checks global flag and operates based on the boolean
if (global.GAMEPaused){
    
    //turns all objects off
    instance_deactivate_all(true);
    
    //activate objects you dont want deactivated here
    
}else{
    //if gamepause global flag is false

    //checks to see if our pause sprite variable is not a default flag and is a sprite that exists
    if (pause_sprite != -4){
        if (file_exists(pause_sprite)){
            //cleans itself up for the next pause
            sprite_delete(pause_sprite);
            file_delete(pause_png);
        }
    }
    
    //reactivates everything
    instance_activate_all();   
}
//============================